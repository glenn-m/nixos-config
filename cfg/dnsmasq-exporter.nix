{ config, lib, pkgs, ... }:
{
  services.prometheus.exporters.dnsmasq = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 9153 ];
}
