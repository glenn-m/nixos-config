{ config, lib, pkgs, ...}:
{
  services =
    let secrets = (import ../secrets.nix).monitoring;
    in {
      prometheus = {
        enable = true;
        alertmanagerURL = [ "http://localhost:9093" ];
        rules = [
          ''
            ALERT instance_down
            IF up == 0
            FOR 10m
            ANNOTATIONS {
            summary="{{$labels.alias}}: Down.",
            description="{{$labels.alias}} has been down for at least 10 minutes now."
            }

            ALERT node_systemd_service_failed
            IF node_systemd_unit_state{state="failed"} == 1
            FOR 4m
            ANNOTATIONS {
            summary = "{{$labels.alias}}: Service {{$labels.name}} failed to start.",
            description = "{{$labels.alias}} failed to (re)start service {{$labels.name}}."
            }

            ALERT node_swap_using_80percent
            IF node_memory_SwapTotal - (node_memory_SwapFree + node_memory_SwapCached) > node_memory_SwapTotal * 0.8
            FOR 10m
            ANNOTATIONS {
            summary="{{$labels.alias}}: Running out of swap soon.",
            description="{{$labels.alias}} is using 80% of its swap space for at least 10 minutes now."
            }
          ''
        ];
        scrapeConfigs = [
          {
            job_name = "node";
            scrape_interval = "15s";
            static_configs = [
              {
                targets = [
                  "Ceres-1.local:9100"
                  "Vesta-1.local:9100"
                ];
                labels = {};
              }
            ];
          }
          {
            job_name = "prometheus";
            scrape_interval = "15s";
            static_configs = [
              {
                targets = [
                  "Ceres-1.local:9090"
                ];
                labels = {};
              }
            ];
          }
          {
            job_name = "alertmanager";
            scrape_interval = "15s";
            static_configs = [
              {
                targets = [
                  "Ceres-1.local:9093"
                ];
                labels = {};
              }
            ];
          }
          {
            job_name = "dnsmasq";
            scrape_interval = "15s";
            static_configs = [
              {
                targets = [
                  "Vesta-1.local:9153"
                ];
                labels = {};
              }
            ];
          }
          {
            job_name = "traefik";
            scrape_interval = "15s";
            static_configs = [
              {
                targets = [
                  "Vesta-1.local:8080"
                ];
                labels = {};
              }
            ];
          }
          {
            job_name = "grafana";
            scrape_interval = "15s";
            static_configs = [
              {
                targets = [
                  "Ceres-1.local:3000"
                ];
                labels = {};
              }
            ];
          }
        ];
      };
      prometheus.alertmanager = {
        enable = true;
        configuration = {
          "route" = {
            "group_by" = [ "alertname" ];
            "repeat_interval" = "4h";
            "receiver" = "team-alerts";
          };
          "receivers" = [
            {
              "name" = "team-alerts";
              "pushover_configs" = [
                {
                  "user_key" = secrets.pushover.user_key;
                  "token" = secrets.pushover.token;
                }
              ];
            }
          ];
        };
      };
    };
}
