{ config, lib, pkgs, ... }: let
  fontCfg = config.font;
  themeCfg = config.theme;
in {
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    xserver = {
      desktopManager.runXdgAutostartIfNone = true;
      windowManager.i3.enable = true;
    };
  };

  # Some essential DE utilities.
  environment.systemPackages = with pkgs; [
    thunar
    tumbler
    ffmpegthumbnailer
    mate.engrampa
    mate.eom
  ];

  # Enable XDG desktop portal.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  home-manager.users.ben = {
    # Media keys.
    services.playerctld.enable = true;

    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod1"; # Alt.
        defaultWorkspace = "workspace number 1";
        bars = [];
        gaps = {
          inner = 6;
          outer = 4;
        };
        window = {
          border = 4;
          titlebar = false;
        };

        keybindings = lib.mkOptionDefault {
          XF86AudioPlay = "exec playerctl play-pause";
          XF86AudioPause = "exec playerctl play-pause";
          XF86AudioPrev = "exec playerctl previous";
          XF86AudioNext = "exec playerctl next";

          XF86AudioRaiseVolume = "exec --no-startup-id ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
          XF86AudioLowerVolume = "exec --no-startup-id ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
          XF86AudioMute = "exec --no-startup-id ${pkgs.pulseaudioFull}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";

          Print = "exec ${pkgs.mate.mate-utils}/bin/mate-screenshot";
        };

        # Assign windows to workspaces.
        assigns = {
          "2" = [{ class = "^firefox$"; }];
          "4" = [
            { class = "^Gimp$"; }
            { class = "^Inkscape$"; }
            { class = "^krita$"; }
          ];
          "5" = [
            { class = "^KiCad$"; }
            { class = "^FreeCAD$"; }
          ];
          "6" = [{ class = "^Blender$"; }];
          "7" = [
            { class = "^Audacity$"; }
            { class = "^obs$"; }
          ];
          "8" = [
            { class = "^steam$"; }
            { class = "^PrismLauncher$"; }
          ];
          "9" = [
            { class = "^vlc$"; }
            { class = "^Spotify$"; }
          ];
          "10" = [
            { class = "^discord$"; }
            { class = "^thunderbird$"; } # Group communications related software together.
          ];
        };

        window.commands = [
          # We have to use `for_window` as libreoffice does not set class on first draw.
          { criteria = { class = "libreoffice"; };
            command = "move to workspace number 3"; }

          { criteria = { class = "^Thunar$"; };
            command = "floating enable"; }
        ];
      };
    };

    services = {
      network-manager-applet.enable = true;
      picom = {
        enable = true;
        # More efficient OpenGL backend.
        backend = "glx";

        activeOpacity = 1.0;
        inactiveOpacity = 0.9;
      };

      polybar = {
        enable = true;
        script = "polybar bar &";
        config = {
          "bar/bar" = {
            background = "#${themeCfg.colors.base01}";
            foreground = "#${themeCfg.colors.base05}";
            font-0 = "${fontCfg.name}:size=${toString fontCfg.size}:antialias=false;5";

            modules-left = "workspaces";
            modules-center = "title";
            modules-right = "sound tray date";

            padding = 1;
            module-margin = 1;
          };

          "module/workspaces" = {
            type = "internal/xworkspaces";

            icon-0 = "1;1  ";
            icon-1 = "2;2 󰈹 ";
            icon-2 = "3;3  ";
            icon-3 = "4;4  ";
            icon-4 = "5;5 󰻫 ";
            icon-5 = "6;6 󰂫 ";
            icon-6 = "7;7  ";
            icon-7 = "8;8 󰊴 ";
            icon-8 = "9;9 󰕼 ";
            icon-9 = "10;0  ";

            label-active = " %icon% ";
            label-active-background = "#${themeCfg.colors.base0A}";
            label-active-foreground = "#${themeCfg.colors.base01}";

            label-occupied = " %icon% ";
            label-empty = " %icon% ";

            label-urgent = " %icon% ";
            label-urgent-background = "#${themeCfg.colors.base0D}";
            label-urgent-foreground = "#${themeCfg.colors.base01}";
          };

          "module/title" = {
            type = "internal/xwindow";
            format = "<label>";
            label = "%title%";
            label-empty = "";
            label-maxlen = 50;
          };

          "module/sound" = {
            type = "internal/pulseaudio";
            format-volume = "<ramp-volume> <bar-volume>";
            label-muted = "  muted";

            ramp-volume-0 = "";
            ramp-volume-1 = "";
            ramp-volume-2 = "";
            bar-volume-width = 15;
            bar-volume-indicator = "";
            bar-volume-fill = "━";
            bar-volume-fill-foreground = "#${themeCfg.colors.base0A}";
            bar-volume-empty = "━";
            bar-volume-empty-foreground = "#${themeCfg.colors.base00}";
          };

          "module/tray" = {
            type = "internal/tray";
            tray-spacing = "1px";
            tray-size = "66%";
          };

          "module/date" = {
            type = "internal/date";
            date = "%Y-%m-%d%";
            time = "%H:%M";
            label = "%date% %time%";
          };
        };

        package = pkgs.polybar.override {
          pulseSupport = true;
        };
      };
    };
  };
}
