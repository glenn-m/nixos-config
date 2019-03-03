# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../cfg/base-large.nix
    ../../cfg/desktop-i3.nix
    ../../cfg/virtualisation.nix
  ];

  boot.loader.systemd-boot.enable = true;

  networking.hostName = "Ceres-1";
  networking.networkmanager.enable = true;

  # Screen layout
  services = {
    xserver = {
      xrandrHeads = [ "DVI-1" { output = "HDMI-0"; primary = true; } ];
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
