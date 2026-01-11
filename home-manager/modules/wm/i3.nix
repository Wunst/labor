{ config, lib, ... }: let
  cfg = config.wm.i3;
in {
  options.wm.i3.enable = lib.mkEnableOption "i3";

  config = lib.mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod1";
        defaultWorkspace = "workspace number 1";
        startup = [
          # Bind to systemd graphical session target.
          { notification = false;
            command = ''
              systemctl --user import-environment DISPLAY XAUTHORITY && systemd-run --user -p BindsTo=graphical-session.target i3-msg -t subscribe -m '[ "shutdown" ]'
            ''; }
        ];
      };
    };

    # Start i3 on login.
    programs.zsh.loginExtra = ''
      if [ -z "$DISPLAY" ] && [ "$TTY" = "/dev/tty1" ] ; then
        exec sx i3 --
      fi
    '';
  };
}
