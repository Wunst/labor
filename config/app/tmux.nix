{
  home-manager.users.ben = {
    programs.tmux = {
      enable = true;
      shortcut = "a";
      keyMode = "vi";
      terminal = "tmux-256color";
      baseIndex = 1;
      escapeTime = 100;
    };
  };
}
