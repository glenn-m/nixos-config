{
  # Select internationalisation properties.
  i18n = {
     consoleKeyMap = "us";
     defaultLocale = "en_US.UTF-8";
  };

  services.xserver = {
    layout = "us";
    xkbOptions = "ctrol:nocaps"; # Caps lock as Ctrl
  };
}
