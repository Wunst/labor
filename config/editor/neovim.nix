{ config, pkgs, lib, ... }: let
  themeCfg = config.theme;
in {
  home-manager.users.ben = { config, ... }: let
    mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  in {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = false;
      withRuby = false;
      
      # Runtime dependencies.
      extraPackages = with pkgs; [
        xsel
        fd
        ripgrep
        tree-sitter
      ];

      # Pass colors by environment.
      extraWrapperArgs = lib.flatten
        (lib.mapAttrsToList
          (name: value: [
            "--set" name "#${value}"
          ]) themeCfg.colors);
    };

    # Only link neovim config for quick iteration without rebuilding.
    home.file.".config/nvim".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/labor/nvim";

    home.shellAliases.v = "nvim";
  };
}
