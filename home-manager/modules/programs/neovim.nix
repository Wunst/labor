{ config, lib, pkgs, ... }: let
  cfg = config.programs.neovim';
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in {
  options.programs.neovim'.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf cfg.enable {
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
}
