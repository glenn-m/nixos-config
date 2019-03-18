{ config, lib, pkgs, ... }:

{
  services.grafana = {
    enable = true;
    provision = {
      enable = true;
      datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://localhost:9090";
        }
      ];
    };
  };
}
