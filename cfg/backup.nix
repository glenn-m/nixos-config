{ config, lib, pkgs, ... }:
{
  services.borgbackup.jobs = {
    main = {
      paths = "/home/gm";
      exclude = [ "/home/gm/.cache" ];
      user = "gm";

      encryption = {
        mode = "repokey";
        passCommand = "cat /home/gm/.secrets/borg-passphrase";
      };

      compression = "auto,lzma";
      startAt = "daily";

      prune.keep = {
        within = "1d";
        daily = 7;
        weekly = 4;
        monthly = -1;
      };

      postHook = ''
      '';
    };
  };
}
