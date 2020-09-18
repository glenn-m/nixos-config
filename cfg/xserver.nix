{
  imports = [
    ./fonts.nix
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";
    displayManager.lightdm.greeters.mini = {
        enable = true;
        user = "gm";
        extraConfig = ''
          [greeter]
          show-password-label = false
          [greeter-theme]
          window-color = "#1d6bf2"
          background-image="/var/lib/lightdm/background.png"
          [greeter-hotkeys]
          mod-key = meta
          shutdown-key = s
          restart-key = r
          hibernate-key = h
          suspend-key = u
        '';
    };
    desktopManager = {
      xterm.enable = false;
    };
  };
}
