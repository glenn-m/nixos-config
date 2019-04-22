{ config, lib, pkgs, ... }:
{
  services =
    let secrets = (import ../secrets.nix).monitoring;
    in {
      influxdb = {
        enable = true;
        extraConfig = {
          http = {
            flux-enabled = true;
          };
          monitor = {
            store-enabled = true;
          };
        };
      };
      kapacitor = {
        enable = true;
        extraConfig = ''
          [pushover]
          enabled = true
          token = "${secrets.pushover.token}"
          user-key = "${secrets.pushover.user_key}"
          url = "https://api.pushover.net/1/messages.json"
        '';
      };
    };
}
