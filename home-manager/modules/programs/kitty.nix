{ config, lib, ... }: let
  cfg = config.programs.kitty';
in {
  options.programs.kitty'.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;

    # Set kitty as the default terminal.
    home.sessionVariables = {
      TERMINAL = "kitty";
    };
  };
}
