# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      cfg/base-small.nix
      cfg/virtualisation.nix
      cfg/matrix.nix
      cfg/consul.nix
      cfg/nomad.nix
      modules/nomad.nix
    ];

  boot.loader.grub.enable = false;
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 4;
  boot.kernelPackages = pkgs.linuxPackages_rpi4;

  networking = {
    hostName = "Eros-1";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        80 # Matrix
        443 # Matrix
        3000 # Grafana
        3100 # Loki
        3478 # Matrix
        3479 # Matrix
        8448 # Matrix Federation
        4646 # Nomad HTTP
        8500 # Consul
        8300 # Consul RPC
        8301 # Consul Lan Serf
        9090 # Prometheus
      ];
      allowedUDPPorts = [
        5349 # Matrix
        5350 # Matrix
        8301 # Consul Lan Serf
      ];
    };
  }; 

  system.stateVersion = "20.03";

}
