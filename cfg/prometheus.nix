{ config, lib, pkgs, ...}:
{
  services = {
    prometheus = {
      enable = true;
      scrapeConfigs = [
        {
          job_name = "node";
          scrape_interval = "15s";
          static_configs = [
            {
              targets = [
                "localhost:9100"
              ];
              labels = { };
            }
          ];
        }
        {
          job_name = "prometheus";
          scrape_interval = "15s";
          static_configs = [
            {
              targets = [
                "localhost:9090"
              ];
              labels = {  };
            }
          ];
        }
      ];
    };
  };
  networking.firewall.allowedTCPPorts = [ 9090 ];
}
