{ config, lib, pkgs, ... }: 
let
  cfg = config.programs.neovim';
in {
  options.programs.neovim'.enable = lib.mkEnableOption "Neovim";

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = false;
      withRuby = false;

      viAlias = true;
      vimAlias = true;
      
      # Runtime dependencies.
      extraPackages = with pkgs; [
        xsel
        fd
        ripgrep
        tree-sitter
      ];
    };

    home.shellAliases.v = "nvim";
  };
}

