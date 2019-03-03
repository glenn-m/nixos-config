{ config, lib, pkgs, ...}:

{
  imports = [
    ./avahi.nix
    ./keyboard.nix
    ./users-and-groups.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  nixpkgs.config = import ./nixpkgs-config.nix;

  environment.systemPackages = with pkgs; [
    emacs
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
