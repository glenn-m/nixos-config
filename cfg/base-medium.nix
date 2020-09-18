{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-small.nix
    ./fonts.nix
  ];

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
        # Echo cancellation and noise cleanup of mic
        load-module module-echo-cancel aec_method=webrtc
      '';
  };
  environment.systemPackages = with pkgs; [
    ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [
    epkgs.vterm
    ]))
    file
    gcc
    gnumake42
    gnupg
    gzip
    inotify-tools
    ldns
    minicom
    openssl
    stow
    unzip
    wget
    tex
  ];

  location = {
      latitude = 55.8642;
      longitude = 4.2518;
  };

  services = {
    redshift = {
      enable = true;
    };

    emacs = {
      enable = true;
    };
  };
}
