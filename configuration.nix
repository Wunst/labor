{ config, pkgs, ... }:
{
  imports = [
    ./allow-unfree.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 4;
    };
  };

  nix = {
    channel.enable = false;
    gc.automatic = true;
    gc.dates = "weekly";
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.networkmanager = {
    enable = true;
    plugins = [ pkgs.networkmanager-fortisslvpn ];
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_IE.UTF-8";
  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "de";
    variant = "";
    options = "caps:escape";
  };

  programs = {
    zsh.enable = true;

    dconf.enable = true;
    steam.enable = true;
    obs-studio'.enable = true;
    orca-slicer.enable = true;

    sway.enable = true;
  };

  services = {
    openssh'.enable = true;
    pipewire'.enable = true;
    printing'.enable = true;

    gvfs.enable = true;
    udisks2.enable = true;
  };

  sops.secrets.hashedPassword = { sopsFile = ./secrets/hashedPassword; neededForUsers = true; };
  users.users.ben = {
    isNormalUser = true;
    description = "Ben";
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets.hashedPassword.path;
    extraGroups = [
      "wheel"
      "networkmanager"
      "dialout"
      "docker"
    ];
  };

  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "monthly";
    };
  };
}
