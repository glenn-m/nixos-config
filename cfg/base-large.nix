{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-medium.nix
    ./golang.nix
    ./rust.nix
    ./rlang.nix
  ];

  environment.systemPackages = with pkgs; [
    lftp
    loki
    mpv
    ncdu
    neofetch
    playerctl
    ranger
    rofi
    scrot
    slack
    spotify
    texlive.combined.scheme-full
  ];
}
