{ pkgs, ... }: {
  home-manager.users.ben = { config, ... }: {
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
    };

    # Only link neovim config for quick iteration without rebuilding.
    home.file.".config/nvim".source = with config; 
      lib.file.mkOutOfStoreSymlink "${home.homeDirectory}/labor/nvim";

    home.shellAliases.v = "nvim";
  };
}
