{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.gm = {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = "GohuFont";
            style = "Regular";
          };
          bold = {
            family = "GohuFont";
            style = "Regular";
          };
          size = 14;
        };
        colors = {
          primary = {
            background = "0x282828";
            foreground = "0xd5c4a1";
          };
          cursor = {
            text = "0x282828";
            cursor = "0xd5c4a1";
          };
          normal = {
            black = "0x282828";
            red = "0xfb4934";
            green = "0xb8bb26";
            yellow = "0xfabd2f";
            blue = "0x83a598";
            magenta = "0xd3869b";
            cyan = "0x8ec07c";
            white = "0xd5c4a1";
          };
          bright = {
            black = "0x665c54";
            red = "0xfb4934";
            green = "0xb8bb26";
            yellow = "0xfabd2f";
            blue = "0x83a598";
            magenta = "0xd3869b";
            cyan = "0x8ec07c";
            white = "0xfbf1c7";
          };
        };
      };
    };
  };
}
