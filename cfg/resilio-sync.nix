{config, lib, pkgs, ...}:
{
  services.resilio = {
    enable = true;
    enableWebUI = true;
  };

  users.users.rslsync.extraGroups = [ "media" ];
}
