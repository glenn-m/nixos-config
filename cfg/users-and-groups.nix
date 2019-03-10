{ config, lib, pkgs, ...}:
{
  users =
    let secrets = (import ../secrets.nix).users;
    in {
      users.gm = {
      description = "Glenn McDonald";
      uid = 1000;
      extraGroups = [
        "docker"
        "libvirtd"
        "networkmanager"
        "dialout"
        "transmission"
        "wheel" # sudo
      ];
      isNormalUser = true;
      initialPassword = secrets.gm.initialpw;
      };
    };
}
