{ config, lib, pkgs, ... }:
{
  services = {
    consul = {
      enable = true;
      interface = {
        bind = "eno2";
      };
      extraConfig = {
        datacenter = "home";
        server = false;
        start_join = [ "192.168.2.120" ];
        telemetry = {
          prometheus_retention_time = "120s"  ;
        };
      };
    };
  };
}
