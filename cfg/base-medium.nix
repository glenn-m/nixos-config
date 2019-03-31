{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-small.nix
  ];

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    file
    firefox
    gcc
    gnumake42
    gnupg
    gzip
    inotify-tools
    ldns
    minicom
    openssl
    stow
    sxiv
    termite
    unar
    unzip
    wget
  ];

  fonts.fonts = with pkgs; [
     gohufont
  ];

  services = {
    redshift = {
      enable = true;
      latitude = "55.8642";
      longitude = "4.2518";
    };

    emacs = {
      enable = true;
    };
  };
}
