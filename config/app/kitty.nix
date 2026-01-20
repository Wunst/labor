{
  home-manager.users.ben = {
    programs.kitty = {
      enable = true;
      settings = {
        cursor_trail = 100;
        window_padding_width = 16;
      };
    };

    home.sessionVariables.TERMINAL = "kitty";
  };
}
