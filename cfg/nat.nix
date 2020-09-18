{ config, pkgs, ... }:
{
  networking.nat = {
    enable = true;
    internalIPs = [ "192.168.1.0/24" ];
    externalInterface = "enp1s0";
  };
}
