{ config, lib, pkgs, ... }:
{
  imports = [
    ./xserver.nix
  ];
  services = {
    xserver = {
      windowManager= {
        bspwm = {
          enable = true;
        };
      };
      displayManager = {
        defaultSession = "none+bspwm";
      };
    };
    compton = {
      enable = true;
      fade = true;
      shadow = true;
      fadeDelta = 4;
    };
    unclutter = {
      enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
      dunst
      i3lock
  ];
}
