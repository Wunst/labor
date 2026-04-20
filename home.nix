{ pkgs, ... }:
{
  imports = [
    ./allow-unfree.nix
  ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";

  home.packages = with pkgs; [
    # Fonts.
    freefont_ttf
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.terminess-ttf

    thunar
    tumbler
    ffmpegthumbnailer
    engrampa
    zip
    unzip
    p7zip
    eog

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
    kicad
    freecad-fix-gsettings-schemas

    # Multimedia.
    vlc
    spotify-spotx
    yt-dlp

    # Social.
    discord

    # Science.
    texliveFull
    texlab
    (python3.withPackages (ps: with ps; [
      jupyter
      ipython
      pandas
      numpy
      scipy
      sympy
      matplotlib
    ]))

    # Dev.
    godot_4
  ];

  wm.i3.enable = true;

  programs = {
    zsh'.enable = true;
    tmux'.enable = true;

    neovim'.enable = true;

    firefox'.enable = true;
    thunderbird'.enable = true;
    kitty'.enable = true;
    zathura'.enable = true;

    gpg'.enable = true;

    # Credential helper for github.
    gh.enable = true;
    git = {
      enable = true;
      settings = {
        init.defaultBranch = "main";
        url."https://github.com/".insteadOf = "github:";
        user = {
          name = "Ben Matthies";
          email = "ben@matthsch.de";
        };
      };
    };

    password-store.enable = true;
  };

  services.gnome-keyring.enable = true;

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme.name = "Adwaita";
    iconTheme.name = "Adwaita";
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };

  fonts.fontconfig = {
    enable = true;
    configFile.terminess-no-antialiasing.text = /* xml */ ''
      <?xml version="1.0"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <description>
          Disable antialiasing for Terminess NerdFont since it is a bitmap font
        </description>
        <match target="pattern">
          <test compare="eq" name="family" qual="any">
            <string>Terminess Nerd Font</string>
          </test>
          <edit mode="assign" name="antialias">
            <bool>false</bool>
          </edit>
        </match>
      </fontconfig>
    '';
  };

  home.file.".xscreensaver".source = ./.xscreensaver;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  accounts = {
    email.accounts = {
      "1 personal" = {
        primary = true;
        thunderbird.enable = true;
        address = "ben@matthsch.de";
        userName = "ben@matthsch.de";
        realName = "Ben Matthies";
        gpg = {
          key = "C32CE25A032EB2AF";
          encryptByDefault = true;
          signByDefault = true;
        };

        smtp = {
          host = "mail.your-server.de";
          port = 465;
        };
        imap = {
          host = "mail.your-server.de";
          port = 993;
        };

        signature = {
          showSignature = "append";
          text = ''
            Ben Matthies
            Physikstudent, Webentwickler, Läufer, Open-Source-Enthusiast

            GitHub @Wunst
            Web www.matthsch.de
              o
            \_~\
             T|T

            PGP www.matthsch.de/pgp/ben
            C3F1 9D1E 74B5 B8CD 7DD9 34FD C32C E25A 032E B2AF
          '';
        };
      };

      "2 school" = {
        thunderbird.enable = true;
        address = "ben.matthies@mps-ki.de";
        userName = "ben.matthies";
        realName = "Ben Matthies";
        smtp = {
          host = "mps-ki.de";
          port = 465;
        };
        imap = {
          host = "mps-ki.de";
          port = 993;
        };
        signature = {
          showSignature = "append";
          text = ''
            Ben Matthies
            Admin AG
            Max-Planck-Schule Kiel
            Winterbeker Weg 1, 24114 Kiel
          '';
        };
      };

      "3 uni" = {
        thunderbird.enable = true;
        address = "ben.matthies@stu.uni-kiel.de";
        realName = "Ben Matthies";
        userName = "stu249890";
        gpg = {
          key = "C32CE25A032EB2AF";
          encryptByDefault = true;
          signByDefault = true;
        };
        smtp = {
          host = "smtps.mail.uni-kiel.de";
          port = 465;
        };
        imap = {
          host = "imap.mail.uni-kiel.de";
          port = 993;
        };
        signature = {
          showSignature = "append";
          text = ''
            Ben Matthies
            Student der Physik (1Ba)
            4. Fachsemester
            Tutorien für die Physik I und II (UB)
          '';
        };
      };

      "4 webmaster" = {
        thunderbird.enable = true;
        address = "webmaster@matthsch.de";
        userName = "webmaster@matthsch.de";
        realName = "Webmaster";
        gpg = {
          key = "C32CE25A032EB2AF";
          encryptByDefault = true;
          signByDefault = true;
        };
        smtp = {
          host = "mail.your-server.de";
          port = 465;
        };
        imap = {
          host = "mail.your-server.de";
          port = 993;
        };
      };
    };

    calendar.accounts = {
      "1 personal" = {
        primary = true;
        thunderbird.enable = true;
        remote = {
          type = "caldav";
          url = "https://webmail.your-server.de/rpc/calendars/ben@matthsch.de/calendar~VhZ4s7KVMpZA_pYAsglCIMG/";
          userName = "ben@matthsch.de";
        };
      };

      "2 tasks" = {
        thunderbird.enable = true;
        remote = {
          type = "caldav";
          url = "https://webmail.your-server.de/rpc/calendars/ben@matthsch.de/tasks~yEfMegBoUJQmutECCEV2L4j/";
          userName = "ben@matthsch.de";
        };
      };
    };

    contact.accounts."1 personal" = {
      thunderbird.enable = true;
      remote = {
        type = "carddav";
        url = "https://webmail.your-server.de/rpc/addressbooks/ben@matthsch.de/contacts~p8B7toNbt5p5nPUAiL3NP-E/";
        userName = "ben@matthsch.de";
      };
    };
  };

  home.stateVersion = "25.11";
}
