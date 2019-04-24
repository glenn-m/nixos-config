{ config, lib, pkgs, ...}:

{
  imports = [
    ./avahi.nix
    ./keyboard.nix
    ./users-and-groups.nix
    ./telegraf.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Dublin";

  nixpkgs.config = import ./nixpkgs-config.nix;

  environment.systemPackages = with pkgs; [
    curl
    emacs
    gitMinimal
    pciutils
    tmux
    vim
  ];

  nix = {
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 30d";
  };

  services = {
    # sane journald defaults
    journald.extraConfig = ''
      SystemMaxUse=256M
    '';

    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };
}
