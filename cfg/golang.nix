{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
     dep
     go
  ];
  environment.variables = {
    GOROOT = "${pkgs.go.out}/share/go";
  };
}
