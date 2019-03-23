{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    beam.packages.erlangR21.elixir_1_8

    # Tools for nerves builds
    fwup
    squashfsTools
    x11_ssh_askpass
  ];

  environment.variables = {
    SUDO_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
  };
}
