{
  imports = [
    ./fonts.nix
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps"; # Caps lock as Ctrl
    displayManager.lightdm.greeters.mini = {
        enable = true;
        user = "gm";
        extraConfig = ''
          [greeter]
          show-password-label = false
          [greeter-theme]
          window-color = "#1d6bf2"
        '';
    };
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
  };
}
