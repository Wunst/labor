{ pkgs, ... }: {
  imports = [
    ./accounts.nix
    ./i18n.nix
    ./users/ben.nix
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
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.networkmanager.enable = true;

  programs = {
    zsh'.enable = true;
    git' = {
      enable = true;
      userName = "Ben Matthies";
      userEmail = "ben@matthsch.de";
    };

    kitty'.enable = true;
    firefox'.enable = true;
    thunderbird'.enable = true;
    neovim'.enable = true;

    gnupg.agent.enable = true;
  };

  services = {
    # Needed on all systems to generate host keys.
    openssh'.enable = true;

    pipewire'.enable = true;
    printing'.enable = true;
    xserver.enable = true;
    displayManager = {
      enable = true;
      autoLogin.user = "ben";
    };

    window-manager.i3'.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Office.
    libreoffice-fresh
    synology-drive-client
    keepassxc

    # Creative.
    gimp
    inkscape
    krita
    blender
    audacity
    musescore
    obs-studio
    kicad
    freecad

    # Multimedia.
    vlc
    spotify-spotx
    yt-dlp

    # Science.
    wxmaxima
    octaveFull
    texliveFull
    texlab

    arduino-ide
    godot_4

    discord
  ];

  home-manager = {
    # Use allowUnfree and overlays from system.
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  sops = {
    defaultSopsFormat = "binary";
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };
}
