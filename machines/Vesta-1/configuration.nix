# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:
let
  externalInterface = "enp1s0";
  internalInterfaces = [
    "wlp4s0"
    "enp2s0"
    "enp3s0"
  ];
in {
  imports = [
      ./hardware-configuration.nix
      ../../cfg/base-small.nix
      ../../cfg/dns.nix
      ../../cfg/dnsmasq-exporter.nix
      ../../cfg/hostapd.nix
      ../../cfg/traefik.nix
  ];

  # Use GRUB2 and configure serial connection.
  boot = {
    vesa = false;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "console=ttyS0,115200n8" ];
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
      extraConfig = ''
        serial --unit=0 --speed=115200;
        terminal_input serial;
        terminal_output serial
      '';
     };
  };
  networking = {
    hostName = "Vesta-1";
    nameservers = [ "127.0.0.1" ];
    nat = {
      enable = true;
      externalInterface = "enp1s0";
      internalInterfaces = [ "enp2s0" "enp3s0" "wlp4s0" ];
      internalIPs = [ "192.168.1.0/24" "192.168.2.0/24" "192.168.3.0/24" ];
    };
    interfaces = {
      wlp4s0 = {
        ipv4.addresses = [{
          address = "192.168.1.1";
          prefixLength = 24;
        }];
      };

      enp1s0 = {
        useDHCP = true;
      };

      enp2s0 = {
	ipv4.addresses = [{
          address = "192.168.2.1";
          prefixLength = 24;
        }];
      };

      enp3s0 = {
	ipv4.addresses = [{
          address = "192.168.3.1";
          prefixLength = 24;
        }];
      };
    };
    firewall = {
      enable = true;
      allowPing = true;
      extraCommands = let
        dropPortNoLog = port:
          ''
            ip46tables -A nixos-fw -p tcp \
              --dport ${toString port} -j nixos-fw-refuse
            ip46tables -A nixos-fw -p udp \
              --dport ${toString port} -j nixos-fw-refuse
          '';

        dropPortIcmpLog =
          ''
            iptables -A nixos-fw -p icmp \
              -j LOG --log-prefix "iptables[icmp]: "
            ip6tables -A nixos-fw -p ipv6-icmp \
              -j LOG --log-prefix "iptables[icmp-v6]: "
          '';

        refusePortOnInterface = port: interface:
          ''
            ip46tables -A nixos-fw -i ${interface} -p tcp \
              --dport ${toString port} -j nixos-fw-log-refuse
            ip46tables -A nixos-fw -i ${interface} -p udp \
              --dport ${toString port} -j nixos-fw-log-refuse
          '';
        acceptPortOnInterface = port: interface:
          ''
            ip46tables -A nixos-fw -i ${interface} -p tcp \
              --dport ${toString port} -j nixos-fw-accept
            ip46tables -A nixos-fw -i ${interface} -p udp \
              --dport ${toString port} -j nixos-fw-accept
          '';
        # IPv6 flat forwarding. For ipv4, see nat.forwardPorts
        forwardPortToHost = port: interface: proto: host:
          ''
            ip6tables -A FORWARD -i ${interface} \
              -p ${proto} -d ${host} \
              --dport ${toString port} -j ACCEPT
          '';

        privatelyAcceptPort = port:
          lib.concatMapStrings
            (interface: acceptPortOnInterface port interface)
            internalInterfaces;

        publiclyRejectPort = port:
          refusePortOnInterface port externalInterface;

        allowPortOnlyPrivately = port:
          ''
            ${privatelyAcceptPort port}
            ${publiclyRejectPort port}
          '';
      in lib.concatStrings [
        (lib.concatMapStrings allowPortOnlyPrivately
          [
            67    # DHCP
            69    # TFTP
            546   # DHCPv6
            547   # DHCPv6
            9100  # node exporter
            9153  # dnsmasq exporter
            8080  # internal traefik
          ])
        (lib.concatMapStrings dropPortNoLog
          [
            23   # Common from public internet
            143  # Common from public internet
            139  # From RT AP
            515  # From RT AP
            9100 # From RT AP
          ])
        (dropPortIcmpLog)
        ''
          # allow from trusted interfaces
          ip46tables -A FORWARD -m state --state NEW -i wlp4s0 -o enp1s0 -j ACCEPT
          ip46tables -A FORWARD -m state --state NEW -i enp2s0 -o enp1s0 -j ACCEPT
          ip46tables -A FORWARD -m state --state NEW -i enp3s0 -o enp1s0 -j ACCEPT
          # allow traffic with existing state
          ip46tables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
          # block forwarding from external interface
          ip6tables -A FORWARD -i enp1s0 -j DROP
        ''
      ];
      allowedTCPPorts = [ 
        80   # HTTP 
        443  # HTTPS 
        8448 # Matrix Federation
      ];
      #allowedUDPPorts = [ 51820 1194 1195 5060 5222 53 config.services.toxvpn.port ];
    };
  };

  # Enables the PC Engines APU Activity LEDs
  systemd.services.apu-led-setup = {
    description = "Enable the APU Networking Activity LEDs";
    wantedBy = [ "multi-user.target" ];
    script = ''
        echo "netdev" > /sys/class/leds/apu:green:2/trigger
        echo "wlp4s0" > /sys/class/leds/apu:green:2/device_name
        echo "1" > /sys/class/leds/apu:green:2/tx
        echo "1" > /sys/class/leds/apu:green:2/rx
        echo "netdev" > /sys/class/leds/apu:green:3/trigger
        echo "enp2s0" > /sys/class/leds/apu:green:3/device_name
        echo "1" > /sys/class/leds/apu:green:3/tx
        echo "1" > /sys/class/leds/apu:green:3/rx
    '';
    serviceConfig.Type = "oneshot";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "18.09";

}
