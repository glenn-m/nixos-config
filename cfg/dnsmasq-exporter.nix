{ config, lib, pkgs, ... }:
{
  services.prometheus.exporters.dnsmasq = {
    enable = true;
  };
}
