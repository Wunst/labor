{
  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "C.UTF-8";
    extraLocaleSettings = {
      # 24 hour clock.
      LC_TIME = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
    };
  };

  console = {
    font = "eurlatgr";
    useXkbConfig = true;
  };
  services.xserver.xkb = {
    layout = "de";
    variant = "";
    options = "caps:escape";
  };
}
