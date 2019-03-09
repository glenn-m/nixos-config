# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ../../cfg/base-small.nix
      ../../cfg/node-exporter.nix
  ];

  # Use GRUB2 and configure serial connection.
  boot = {
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

  networking.hostName = "Vesta-1";

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "18.09";

}
