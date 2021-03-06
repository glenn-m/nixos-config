{ config, lib, pkgs, ... }:

{
  imports = [ ./xserver.nix ];
  services = {
    xserver = {
      windowManager = {
        i3 = {
          enable = true;
          extraPackages = with pkgs; [ i3lock i3status xautolock ];
        };
      };
      displayManager = { defaultSession = "none+i3"; };
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
}
