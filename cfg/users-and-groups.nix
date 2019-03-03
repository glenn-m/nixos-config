{ config, lib, pkgs, ...}:
{
  users = {
    users.gm = {
      description = "Glenn McDonald";
      uid = 1000;
      extraGroups = [
        "wheel"
        "networkmanager"
        "libvirtd"
        "docker"
      ];
      isNormalUser = true;
      initialPassword = "initialpw";
    };
  };
}
