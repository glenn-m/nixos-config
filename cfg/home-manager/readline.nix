{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.gm = {
    programs.readline = {
      enable = true;
      variables = {
        show-all-if-ambiguous = true;
        completion-ignore-case = true;
        visible-stats = true;
      };
      extraConfig = ''
        $if Bash
          # In bash only, enable "magic space" so that typing space
          # will show completions. i.e. !!_ (where _ is space)
          # will expand !! for you.
          Space: magic-space
        $endif
      '';
    };
  };
}
