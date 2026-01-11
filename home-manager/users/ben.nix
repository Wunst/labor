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
    vim = {
      enable = true;
      defaultEditor = true;
      extraConfig = ''
        set nu
        set rnu

        set shiftwidth=2
        set expandtab
        set smartindent

        set clipboard=unnamedplus

        set undofile
        set undodir=$HOME/.vim/undodir

        filetype plugin indent on
        colorscheme retrobox
      '';
    };
  };

  wm.i3.enable = true;

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
    feh
    vlc
    spotify-spotx
    yt-dlp

    # Scientific computing.
    wxmaxima
    octaveFull

    # LaTeX.
    texliveFull

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
