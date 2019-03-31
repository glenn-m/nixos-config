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
            i3lock
            i3status
            xautolock
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
