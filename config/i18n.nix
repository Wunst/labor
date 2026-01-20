{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_IE.UTF-8";

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
