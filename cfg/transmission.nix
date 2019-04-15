{ config, lib, pkgs, ... }:

{
  # Enable and configure Transmission
  services.transmission =
    let secrets = (import ../secrets.nix).transmission;
    in {
      enable = true;
      settings = {
        download-dir = "/home/media";
        incomplete-dir = "/home/media/.incomplete";
        incomplete-dir-enabled = true;
        rpc-whitelist = "127.0.0.1,192.168.1.*";
        ratio-limit = 2;
        ratio-limit-enabled = true;
        rpc-bind-address = "0.0.0.0";
        rpc-authentication-required = true;
        rpc-username = secrets.username;
        rpc-password = secrets.password;
      };
    };

    networking.firewall.allowedTCPPorts = [ 9091 51413 ];
    users.groups.media.members = [ "transmission" ];

    # Creating /home/media requires root privileges. The transmission service
    # itself runs as an unpriveleged users. Use this helper service to create
    # the required directories.
    systemd.services.transmission-setup-dir = {
      description = "Create /home/media Directory for Transmission";
      requiredBy = [ "transmission.service" ];
      before = [ "transmission.service" ];
      script = ''
        mkdir -p /home/media
        chown transmission:media /home/media
      '';
      serviceConfig.Type = "oneshot";
    };
}
