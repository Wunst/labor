{ pkgs, ... }: {
  programs = {
    bash.enable = true;
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
  };

  wm.i3.enable = true;

  services = {
    # Tray icons.
    udiskie.enable = true;
    network-manager-applet.enable = true;
    pasystray.enable = true;
  };

  # Additional packages without configuration.
  home.packages = with pkgs; [
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
    shotcut
    freecad
    kicad

    # Social.
    discord

    # Multimedia.
    thunar
    mate.engrampa
    mate.eom
    vlc
    spotify-spotx
    yt-dlp

    # Scientific computing.
    wxmaxima
    octaveFull

    # LaTeX.
    texliveFull
    texlab

    # Web dev.
    filezilla
    httpie
    jq

    # Embedded dev.
    arduino-ide
    minicom

    # Game dev.
    godot_4
  ];

  home.stateVersion = "25.11";
}
