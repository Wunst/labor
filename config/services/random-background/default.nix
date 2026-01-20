{
  home-manager.users.ben = {
    services.random-background = {
      enable = true;
      interval = "1h";
      imageDirectory = "${./solarized}";
    };
  };
}
