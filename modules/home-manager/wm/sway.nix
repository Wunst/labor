{ config, lib, pkgs, ... }:
let
  cfg = config.wm.sway;
  colors = import ../lib/colors.nix;
in {
  options.wm.sway.enable = lib.mkEnableOption "I3-compatible tiling Wayland compositor";

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = [ "gtk" ];
    };

    # Media keys.
    services.playerctld.enable = true;

    wayland.windowManager.sway = {
      enable = true;
      config = {
        terminal = "$TERMINAL";

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

          Print = "exec ${pkgs.mate-utils}/bin/mate-screenshot";

          "Mod1+l" = "exec ${pkgs.xscreensaver}/bin/xscreensaver-command -activate";
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

          { criteria = { class = "^(Thunar|Eom|Engrampa)$"; };
            command = "floating enable"; }
        ];
      };
    };

    services = {
      network-manager-applet.enable = true;
      polybar = {
        enable = true;
        script = "polybar bar &";
        config = {
          "bar/bar" = {
            inherit (colors) background foreground;
            #font-0 = "${fontCfg.name}:size=${toString fontCfg.size}:antialias=false;5";

            modules-left = "workspaces";
            modules-center = "title";
            modules-right = "sound tray date battery";

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
            label-active-background = colors.color3;
            label-active-foreground = colors.background;

            label-occupied = " %icon% ";
            label-empty = " %icon% ";

            label-urgent = " %icon% ";
            label-urgent-background = colors.color4;
            label-urgent-foreground = colors.background;
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
            bar-volume-fill-foreground = colors.color3;
            bar-volume-empty = "━";
            bar-volume-empty-foreground = colors.color8;
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

          "module/battery" = {
            type = "internal/battery";
            battery = "BAT0";
            adapter = "AC0";
          };
        };

        package = pkgs.polybar.override {
          pulseSupport = true;
        };
      };
    };

    # Start sway on login.
    programs.zsh.loginExtra = ''
      if [ "$TTY" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
  };
}
