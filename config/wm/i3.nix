{ pkgs, ... }: {
  services.xserver.windowManager.i3.enable = true;

  home-manager.users.ben = {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = "Mod1"; # Alt.
        defaultWorkspace = "workspace number 1";
        bars = [
          { command = "i3bar";
            statusCommand = "${pkgs.i3status}/bin/i3status"; }
        ];
        gaps = {
          inner = 8;
          outer = 4;
        };
      };
    };
  };
}
