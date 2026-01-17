{ config, lib, ... }: let
  cfg = config.programs.zsh';
in {
  options.programs.zsh'.enable = lib.mkEnableOption "zsh";

  config = lib.mkIf cfg.enable {
    # Add zsh to the list of allowed login shells.
    programs.zsh.enable = true;

    home-manager.users.ben = {
      programs.zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          theme = "junkfood";
          plugins = [
            "tmux"
            "git"
            "ssh"
          ];
        };
      };
    };
  };
}
