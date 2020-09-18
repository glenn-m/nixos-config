{lib, pkgs, config, ...}:
with lib;
let
  cfg = config.services.xserver.windowManager.cwm;
in

{
  options = {
    services.xserver.windowManager.cwm.enable = mkEnableOption "cwm";
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "cwm";
        start = "
          ${pkgs.cwm}/bin/cwm
        ";
      }];
    };
    environment.systemPackages = [ pkgs.cwm ];
  };
}
