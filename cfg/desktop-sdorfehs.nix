{ config, lib, pkgs, ... }: {
  imports = [ ./xserver.nix ];
  services = {
    xserver = {
      displayManager.defaultSession = "none+sdorfehs";
      windowManager = { sdorfehs = { enable = true; }; };
    };
    compton = {
      enable = true;
      fade = true;
      shadow = true;
      fadeDelta = 4;
    };
    unclutter = { enable = true; };
  };
  environment.systemPackages = with pkgs; [ dunst i3lock ];
}
