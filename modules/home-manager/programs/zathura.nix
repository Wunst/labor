{ config, lib, ... }:
let
  cfg = config.programs.zathura';
  colors = import ../lib/colors.nix;
in {
  options.programs.zathura'.enable = lib.mkEnableOption "Zathura";

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        recolor = true;
        recolor-keephue = true;
        recolor-lightcolor = colors.background;
        recolor-darkcolor = colors.foreground;
        default-bg = colors.background;
        default-fg = colors.foreground;
      };
    };
  };
}
