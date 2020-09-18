{ config, lib, pkgs, ...}:
{
  services =
    let secrets = (import ../secrets.nix).traefik;
    in {
      traefik = {
        enable = true;
        staticConfigOptions = {
          log = {
            level = "INFO";
          };
          entryPoints = {
            web.address = ":80";
            websecure.address = ":443";
            matrixFederation.address = ":8448";
            internal.address = ":8080";
          };
          certificatesResolvers.le.acme = {
            email = secrets.email;
            storage = "/var/lib/traefik/acme.json";
	    httpChallenge = {
              entryPoint = "web";
            };
          };
          metrics.prometheus = {
            entryPoint = "internal";
          };
        };
        dynamicConfigOptions = {
          http = {
            routers = {
             grafana = {
              rule = "Host(`grafana.glennm.xyz`)";
              tls = {
                certResolver = "le";
              };
              service = "grafana";
             };
             matrix = {
              rule = "Host(`matrix.glennm.xyz`)";
              tls = {
                certResolver = "le";
              };
              service = "matrix";
              entrypoints = [ "websecure" ];
             };
             matrixFederation = {
              rule = "Host(`matrix.glennm.xyz`)";
              tls = {
                certResolver = "le";
              };
              service = "matrixFederation";
              entrypoints = [ "matrixFederation" ];
             };

            };
            services = {
              grafana.loadBalancer.servers = [{
                url = "http://192.168.2.90:3000";
              }];
              matrix.loadBalancer.servers = [{
                url = "http://192.168.2.120:80";
              }];
              matrixFederation.loadBalancer.servers = [{
                url = "http://192.168.2.120:8448";
              }];
            };
          };
      };
    };
  };
}
