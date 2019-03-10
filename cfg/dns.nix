{ config, lib, pkgs, ... }:
{
  services.dnsmasq = {
    enable = true;
    servers = [
      "1.1.1.1"
      "141.0.144.2"
    ];
    extraConfig = ''
      cache-size=1000
      neg-ttl=900
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
