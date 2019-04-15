{ config, lib, pkgs, ... }:
{
  systemd = {
    timers.seedbox-sync = {
      wantedBy = [ "timers.target" ];
      partOf = [ "seedbox-sync.service" ];
      timerConfig.OnCalendar = "*:0/15";
    };
    services.seedbox-sync = {
      path = [ pkgs.bash pkgs.lftp pkgs.openssh ];
      serviceConfig = {
        User = "gm";
        Type = "simple";
      };
      script = "/home/$(id -un 1000)/bin/seed-sync";
    };
  };
}
