{ config, ... }: let
  themeCfg = config.theme;
in {
  home-manager.users.ben = {
    programs.kitty = {
      enable = true;
      inherit (config) font;
      settings = with themeCfg.colors; {
        cursor_trail = 100;
        window_padding_width = 16;
        background = "#${base00}";
        color0 = "#${base00}";
        color1 = "#${base08}";
        color2 = "#${base0B}";
        color3 = "#${base0D}";
        color4 = "#${base0A}";
        color5 = "#${base0C}";
        color6 = "#${base09}";
        color7 = "#${base05}";
        foreground = "#${base05}";
      };
    };

    home.sessionVariables.TERMINAL = "kitty";
  };
}
