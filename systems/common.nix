{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 4;
    };
  };

  networking.networkmanager.enable = true;

  # Localization.
  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "C.UTF-8";
    extraLocaleSettings = {
      # 24 hour clock and week starting on Monday.
      LC_TIME = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
    };
  };

  programs.steam.enable = true;

  services = {
    # Needed on all systems to generate host keys.
    openssh'.enable = true;

    pipewire'.enable = true;
    printing'.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
    xserver = {
      enable = true;
      displayManager.sx.enable = true;
      xkb = {
        layout = "de";
        variant = "";
        options = "caps:escape";
      };
    };
  };

  users'.ben.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
