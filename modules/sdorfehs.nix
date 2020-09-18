{lib, pkgs, config, ...}:
with lib;
let
  cfg = config.services.xserver.windowManager.sdorfehs;
in

{
  options = {
    services.xserver.windowManager.sdorfehs.enable = mkEnableOption "sdorfehs";
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager = {
      session = [{
        name = "sdorfehs";
        start = "
          ${pkgs.sdorfehs}/bin/sdorfehs
        ";
      }];
    };
    environment.systemPackages = [ pkgs.sdorfehs ];
  };
}
