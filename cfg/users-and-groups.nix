{ config, lib, pkgs, ...}:
{
  users =
    let secrets = (import ../secrets.nix).users;
    in {
      groups.media = {};
      users.gm = {
        description = "Glenn McDonald";
        uid = 1000;
        extraGroups = [
          "docker"
          "libvirtd"
          "networkmanager"
          "dialout"
          "media"
          "wheel" # sudo
        ];
        isNormalUser = true;
        initialPassword = secrets.gm.initialpw;
        openssh.authorizedKeys.keys = secrets.gm.ssh_keys;
      };
    };
}
