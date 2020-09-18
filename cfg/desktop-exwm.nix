{ config, lib, pkgs, ... }:

{
  imports = [ ./xserver.nix ];
  services = {
    xserver = {
      windowManager = {
        default = "exwm";
        exwm = { enable = true; };
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
