{ config, lib, pkgs, ... }:

{
  services.grafana = {
    enable = true;
    addr = "0.0.0.0";
    provision = {
      enable = true;
      datasources = [
        {
          name = "InfluxDB";
          type = "influxdb";
          database = "telegraf";
          url = "http://Ceres-1.lan:8086";
        }
        {
          name = "InfluxDB Internal";
          type = "influxdb";
          database = "_internal";
          url = "http://Ceres-1.lan:8086";
        }
      ];
    };
  };
}
