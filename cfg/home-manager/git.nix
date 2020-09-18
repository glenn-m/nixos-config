{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.gm = {
    programs.git = {
      enable = true;
      userName = "Glenn McDonald";
      userEmail = "2371316+glenn-m@users.noreply.github.com";
      signing.signByDefault = true;
      signing.key = "1AF73EB9B06A6DAB";
      aliases = {
        prettylog =
          "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      };
      extraConfig = {
        includeIf."gitdir:~/code/work/".path = "~/code/work/.gitconfig";
      };
    };
  };
}
