{ config, lib, pkgs, ... }:

{
  services.promtail = {
    enable = true;
    configuration = {
      server = { http_listen_port = 9080; };
      client = { url = "http://eros-1.lan:3100/loki/api/v1/push"; };
      scrape_configs = [{
        job_name = "journal";
        journal = {
          max_age = "12h";
          labels = { job = "systemd-journal"; };
        };
        relabel_configs = [{
          source_labels = [ "__journal__systemd_unit" ];
          target_label = "unit";
        }];
      }];
    };
  };
}
