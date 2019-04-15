{ config, lib, pkgs, ... }:
{
  users.users.gm.packages = with pkgs; [
    steam
  ];

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };
}
