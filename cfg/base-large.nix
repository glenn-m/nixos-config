{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-medium.nix
    ./golang.nix
    ./rust.nix
  ];

  environment.systemPackages = with pkgs; [
     beam.packages.erlangR21.elixir_1_8
     fwup
     mpv
     ncdu
     neofetch
     nixops
     ranger
     rofi
     dmenu
     signal-desktop
     spotify
     squashfsTools
     texlive.combined.scheme-full
     x11_ssh_askpass
  ];

  environment.variables = {
    SUDO_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
  };
}
