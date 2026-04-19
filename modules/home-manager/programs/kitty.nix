{ config, lib, ... }: 
let
  cfg = config.programs.kitty';
  colors = import ../lib/colors.nix;
in {
  options.programs.kitty'.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "Terminess Nerd Font";
        size = 18;
      };

      settings = {
        inherit (colors)
          background foreground cursor 
          color1 color2 color3 color4 color5 color6 color7
          color8 color9 color10 color11 color12 color13 color14 color15;

        cursor_trail = 100;
        window_padding_width = 16;
      };
    };

    home.sessionVariables.TERMINAL = "kitty";
  };
}
