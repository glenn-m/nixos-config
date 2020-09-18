{ config, pkgs, lib, ... }:
{
  fonts = {
    fonts = with pkgs; [
      envypn-font
      hack-font
      gohufont
      siji
      font-awesome
    ];
  };
}
