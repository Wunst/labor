{ config, lib, ... }: let
  cfg = config.services.random-background';
in {
  options.services.random-background' = with lib; {
    enable = mkEnableOption "random desktop background";
    theme = mkOption {
      description = "Which theme to select background from";
      type = types.enum [
        "solarized"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ben = {
      services.random-background = {
        enable = true;
        interval = "1h";
        imageDirectory = "${./${cfg.theme}}";
      };
    };
  };
}
