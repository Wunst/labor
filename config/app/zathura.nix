{ config, ... }: let
  fontCfg = config.font;
  colors = config.theme.colors;
in {
  home-manager.users.ben = {
    programs.zathura = {
      enable = true;
      options = {
        recolor = true;
        recolor-keephue = true;
        recolor-lightcolor = "#${colors.base00}";
        recolor-darkcolor = "#${colors.base05}";
        default-bg = "#${colors.base00}";
        default-fg = "#${colors.base05}";
        font = with fontCfg; "${name} normal ${toString size}";
      };
    };
  };
}
