{ config, lib, pkgs, ... }:

{
  imports = [ ./xserver.nix ];

  services = {
    xserver = {
      displayManager.gdm.enable = true;
      desktopManager = {
        default = "none";
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
        ];
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
