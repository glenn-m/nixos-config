# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../cfg/base-large.nix
    ../../cfg/cad.nix
    ../../cfg/desktop-bspwm.nix
    ../../cfg/dropbox.nix
    ../../cfg/grafana.nix
    ../../cfg/influxdb.nix
    ../../cfg/plex.nix
    ../../cfg/seedbox.nix
    ../../cfg/transmission.nix
    ../../cfg/virtualisation.nix
  ];

  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "Ceres-1";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        3000 # Grafana
        8086 # InfluxDB
        9091 # Transmission
        17500 # Dropbox
        51413 # Transmission
      ];
      allowedUDPPorts = [
        17500 # Dropbox
      ];
    };
  };

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
  system.stateVersion = "19.03"; # Did you read the comment?
}
