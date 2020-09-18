{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-medium.nix
    ./golang.nix
    ./elixir.nix
    ./rlang.nix
  ];

  environment.systemPackages = with pkgs; [
    lftp
    mpv
    ncdu
    playerctl
    ranger
    rofi
    scrot
    slack
    spotify
  ];

  programs.gnupg.agent.enable = true;
}
