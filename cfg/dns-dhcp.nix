{ config, lib, pkgs, ... }:
{
  services.dnsmasq = {
    enable = true;
    servers = [
      "1.1.1.1"
      "141.0.144.2"
    ];
    extraConfig = ''
      domain=lan
      cache-size=1000
      neg-ttl=900
      interface=wlp4s0
      interface=enp2s0
      interface=enp3s0
      bind-interfaces
      dhcp-range=192.168.1.10,192.168.1.254,24h
      dhcp-range=192.168.2.10,192.168.2.254,24h
      dhcp-range=192.168.3.10,192.168.3.254,24h
    '';
  };
  networking.firewall = {
    allowedTCPPorts = [
      53
    ];
    allowedUDPPorts = [
      53
    ];
  };
}
