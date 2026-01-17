{ config, lib, ... }: let
  cfg = config.services.window-manager.i3';
in {
  options.services.window-manager.i3'.enable = lib.mkEnableOption "i3";

  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        # Use xfce as a desktop session, to handle media keys, hotplugging...
        desktopManager.xfce = {
          enable = true;
          enableXfwm = false;
          noDesktop = true;
        };
        windowManager.i3.enable = true;
      };
      displayManager.defaultSession = "xfce+i3";
    };

    home-manager.users.ben = { pkgs, ... }: {
      # Media keys.
      services.playerctld.enable = true;

      xsession.windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod1";
          defaultWorkspace = "workspace number 1";
          bars = [ {
            command = "i3bar";
            statusCommand = "${pkgs.i3status}/bin/i3status";
          } ];
          keybindings = lib.mkOptionDefault {
            XF86AudioPlay = "exec playerctl play-pause";
            XF86AudioPause = "exec playerctl play-pause";
            XF86AudioPrev = "exec playerctl previous";
            XF86AudioNext = "exec playerctl next";
          };
          gaps = {
            inner = 8;
            outer = 4;
          };
        };
      };
    };
  };
}
