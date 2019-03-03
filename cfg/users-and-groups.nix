{ config, lib, pkgs, ...}:
{
  users = {
    users.gm = {
      description = "Glenn McDonald";
      uid = 1000;
      extraGroups = [
        "docker"
        "libvirtd"
        "networkmanager"
        "transmission"
        "wheel" # sudo
      ];
      isNormalUser = true;
      initialPassword = "initialpw";
    };
  };
}
