{ config, lib, ... }: let
  cfg = config.theme;

  # Named base16 colorschemes.
  themes = {
    solarized = {
      base00 = "002b36";
      base01 = "073642";
      base02 = "657b83";
      base03 = "586e75";
      base04 = "93a1a1";
      base05 = "839496";
      base06 = "eee8d5";
      base07 = "fdf6e3";
      base08 = "dc322f";
      base09 = "2aa198";
      base0A = "b58900";
      base0B = "859900";
      base0C = "d33682";
      base0D = "268bd2";
      base0E = "cb4b16";
      base0F = "6c71c4";
    };
  };
in {
  options.theme = with lib; {
    name = mkOption {
      type = types.str;
      description = "Theme name.";
      default = "solarized";
    };

    colors = mkOption {
      type = types.attrsOf types.str;
      description = "Theme base16 colors.";
      default = themes.${cfg.name};
    };
  };

  config = {
    # Required to set gtk configuration.
    programs.dconf.enable = true;

    home-manager.users.ben = {
      gtk = {
        enable = true;
        colorScheme = "dark";
      };
      qt = {
        enable = true;
        platformTheme.name = "gtk3";
        style.name = "adwaita-dark";
      };
    };
  };
}
