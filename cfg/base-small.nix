{ config, lib, pkgs, ...}:

{
  imports = [
    ./avahi.nix
    ./keyboard.nix
    ./users-and-groups.nix
    ./node-exporter.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  nixpkgs.config = import ./nixpkgs-config.nix;

  environment.systemPackages = with pkgs; [
    emacs
    gitMinimal
    pciutils
    vim
  ];

  nix = {
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 30d";
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };
}
