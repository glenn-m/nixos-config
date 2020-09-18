{ config, lib, pkgs, ... }:

{
  imports = [
    ./email.nix
    ./sxhkd.nix
    ./alacritty.nix
    ./readline.nix
    #./bash.nix
  ];
}
