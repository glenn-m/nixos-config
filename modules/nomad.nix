{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.nomad;
  configFile = if cfg.configFile == null then
    pkgs.writeText "config.json" (builtins.toJSON cfg.configOptions)
  else
    cfg.configFile;

in {
  options.services.nomad = {
    enable = mkEnableOption "Nomad Workload Orchestrator";

    configFile = mkOption {
      default = null;
      example = literalExample "/path/to/config.hcl";
      type = types.nullOr types.path;
      description = ''
        Path to verbatim nomad.hcl to use.
        (Using that option has precedence over <literal>configOptions</literal>)
      '';
    };

    configOptions = mkOption {
      description = ''
        Config for Nomad.
      '';
      type = types.attrs;
      example = {
        bind_addr = "0.0.0.0";
        advertise = {
          http = "127.0.0.1";
          rpc = "127.0.0.1";
          serf = "127.0.0.1";
        };
        server = {
          enabled = true;
          bootstrap_expect = 3;
        };
        client = {
          enabled = true;
          network_speed = 10;
        };
        consul = { address = "127.0.0.1:8500"; };
      };
    };

    dataDir = mkOption {
      default = "/var/lib/nomad";
      type = types.path;
      description = ''
        Location for any persistent data nomad creates.
      '';
    };

    group = mkOption {
      default = "docker";
      type = types.str;
      example = "docker";
      description = ''
        Set the group that nomad runs under.
        For the docker backend this needs to be set to <literal>docker</literal> instead.
      '';
    };

    package = mkOption {
      default = pkgs.nomad;
      defaultText = "pkgs.nomad";
      type = types.package;
      description = "Nomad package to use.";
    };
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [ "d '${cfg.dataDir}' 0700 nomad nomad - -" ];

    systemd.services.nomad = {
      description = "Nomad Workload Orchestrator";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.iproute ];
      serviceConfig = {
        ExecStart =
          "${cfg.package}/bin/nomad agent -config=${configFile} -data-dir=${cfg.dataDir}";
        Type = "simple";
        User = "nomad";
        Group = cfg.group;
        Restart = "on-failure";
        StartLimitInterval = 86400;
        StartLimitBurst = 5;
      };
    };

    users.users.nomad = {
      group = "nomad";
      home = cfg.dataDir;
      createHome = true;
      extraGroups = [ "docker" ];
    };

    users.groups.nomad = { };
  };
}
