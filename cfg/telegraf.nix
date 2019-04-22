{ config, lib, pkgs, ... }:
{
  services = {
      telegraf = {
      enable = true;
      extraConfig = {
        outputs = {
          influxdb = {
            urls = [ "http://Ceres-1.lan:8086" ];
            database = "telegraf";
          };
        };
        inputs = {
          # System Metrics
          cpu = {};
          kernel = {};
          mem = {};
          swap = {};
          system = {};
          disk = {};
          diskio = {};
          processes = {};
          net = {};
          netstat = {};

          # Telegraf Internal Metrics
          internal = {
            collect_memstats = true;
          };
        };
      };
    };
  };
}
