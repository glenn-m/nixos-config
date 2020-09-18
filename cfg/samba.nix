{ config, lib, pkgs, ... }:
{
  fileSystems."/mnt/media" =
  let secrets = (import ../secrets.nix).samba;
  in {
      device = "//media-server.local/media";
      fsType = "cifs";
      options = [ "username=${secrets.username}" "password=${secrets.password}" "x-systemd.automount" "noauto" ];
  };
}
