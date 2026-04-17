{ config, lib, ... }:
let
  cfg = config.programs.tmux';
in {
  options.programs.tmux'.enable = lib.mkEnableOption "Terminal multiplexer";

  config = lib.mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shortcut = "a";
      keyMode = "vi";
      terminal = "tmux-256color";
      mouse = true;
      baseIndex = 1;
      escapeTime = 100;
    };
  };
}
