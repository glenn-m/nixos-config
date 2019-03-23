{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-medium.nix
    ./golang.nix
    ./rust.nix
    ./elixir.nix
  ];

  environment.systemPackages = with pkgs; [
    dmenu
    mpv
    ncdu
    neofetch
    ranger
    rofi
    signal-desktop
    spotify
    texlive.combined.scheme-full
    qutebrowser
  ];
}
