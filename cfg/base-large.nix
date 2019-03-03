{ config, lib, pkgs, ... }:

{
  imports = [
    ./base-medium.nix
  ];

  environment.systemPackages = with pkgs; [
     beam.packages.erlangR21.elixir_1_8
     dep
     dropbox-cli
     fwup
     go
     mpv
     neofetch
     ranger
     rofi
     spotify
     squashfsTools
     tdesktop
     texlive.combined.scheme-small
     virtmanager
     x11_ssh_askpass
  ];

  environment.variables = {
    SUDO_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
    GOROOT = "${pkgs.go.out}/share/go";
  };

}
