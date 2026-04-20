{ config, lib, pkgs, osConfig, ... }:
let
  cfg = config.wm.sway;
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

        input."*" = {
          xkb_layout = osConfig.services.xserver.xkb.layout;
          xkb_options = osConfig.services.xserver.xkb.options;
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
        };
        window.commands = [
          { criteria = { app_id = "^(thunar|org.gnome.eog|engrampa)$"; };
            command = "floating enable"; }
        ];
      };
    };

    services.network-manager-applet.enable = true;

    # Start sway on login.
    programs.zsh.loginExtra = ''
      if [ "$TTY" = "/dev/tty1" ]; then
        exec sway
      fi
    '';
  };
}
