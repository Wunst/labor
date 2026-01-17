{ config, lib, ... }: let
  cfg = config.programs.neovim';
in {
  options.programs.neovim'.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf cfg.enable {
    home-manager.users.ben = { config, pkgs, ... }: let
        mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
    in {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        withNodeJs = false;
        withRuby = false;
        
        # Runtime dependencies.
        extraPackages = with pkgs; [
          # Clipboard provider.
          xsel
          fd
          ripgrep

          tree-sitter
        ];
      };

      # Only link neovim config for quick iteration without rebuilding.
      home.file.".config/nvim" = {
        source = mkOutOfStoreSymlink "${config.home.homeDirectory}/labor/nvim";
      };

      home.shellAliases = {
        v = "nvim";
      };
    };
  };
}
