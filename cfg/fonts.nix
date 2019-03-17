{ config, pkgs, lib, ... }:
{
  fonts = {
    fontconfig.ultimate.enable = true;
    fonts = with pkgs; [
      gohufont
      siji
    ];
  };
}
