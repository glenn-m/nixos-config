{ config, pkgs, ... }:
{
  services.nomad = {
    enable = true;
    configOptions = {
      bind_addr = "0.0.0.0";
      advertise = {
        http = "127.0.0.1";
        rpc = "127.0.0.1";
        serf = "127.0.0.1";
      };
      server = {
        enabled = true;
        bootstrap_expect = 1;
      };
      client = {
        enabled = true;
        servers = [ "127.0.0.1" ];
      };
    };
  };
}
