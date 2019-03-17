{ config, lib, pkgs, ... }:

{
  imports = [
    ./xserver.nix
  ];
  services = {
    xserver = {
      windowManager = {
        default = "i3";
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
            i3status
            i3lock
          ];
        };
      };
    };
    compton = {
      enable = true;
      fade = true;
      shadow = true;
      fadeDelta = 4;
    };
  };
}
