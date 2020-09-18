# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../cfg/base-large.nix
    ../../cfg/desktop-bspwm.nix
    #../../cfg/desktop-sdorfehs.nix
    #../../modules/sdorfehs.nix
    ../../modules/nomad.nix
    ../../cfg/nomad.nix
    ../../modules/promtail.nix
    ../../cfg/promtail.nix
    ../../cfg/consul-client.nix
    ../../cfg/dropbox.nix
    ../../cfg/virtualisation.nix
    ../../cfg/samba.nix
    ../../cfg/home-manager/home.nix
  ];

  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "Ceres-1";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        9100  # Node Exporter
        8301  # Consul Lan Serf
        17500 # Dropbox
      ];
      allowedUDPPorts = [
        17500 # Dropbox
      ];
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
