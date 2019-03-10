{ config, lib, pkgs, ... }:
{
  services.dnsmasq = {
    enable = true;
    servers = [
      "1.1.1.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}
