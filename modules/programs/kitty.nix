{ config, lib, ... }: let
  cfg = config.programs.kitty';
in {
  options.programs.kitty'.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf cfg.enable {
    home-manager.users.ben = {
      programs.kitty = {
        enable = true;
        settings = {
          cursor_trail = 100;
          window_padding_width = 16;
        };
      };

      home.sessionVariables = {
        TERMINAL = "kitty";
      };
    };
  };
}
