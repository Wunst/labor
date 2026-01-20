{
  home-manager.users.ben = {
    programs = {
      # Credential helper for github.
      gh.enable = true;
      git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";

          # Abbreviate github URLs, as in Nix.
          url."https://github.com/".insteadOf = "github:";
          user = {
            name = "Ben Matthies";
            email = "ben@matthsch.de";
          };
        };
      };
    };
  };
}

