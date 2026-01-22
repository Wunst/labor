{ config, lib, pkgs, ... }: let
  cfg = config.font;
in {
  options.font = with lib; {
    name = mkOption {
      type = types.str;
      default = "Terminess NerdFont";
    };
    size = mkOption {
      type = types.int;
      default = 18;
    };
    package = mkOption {
      type = types.package;
      default = pkgs.nerd-fonts.terminess-ttf;
    };
  };

  config = {
    fonts = {
      enableDefaultPackages = false;
      packages = with pkgs; [
        freefont_ttf
        liberation_ttf
        noto-fonts
        cfg.package
      ];
    };
  };
}
