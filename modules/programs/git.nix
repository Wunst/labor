{ config, lib, ... }: let
  cfg = config.programs.git';
in {
  options.programs.git' = with lib; {
    enable = mkEnableOption "Git";
    userName = mkOption {
      type = types.str;
      description = "full name used for commits";
    };
    userEmail = mkOption {
      type = types.str;
      description = "email address used for commits";
    };
  };

  config = lib.mkIf cfg.enable {
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
              name = cfg.userName;
              email = cfg.userEmail;
            };
          };
        };
      };
    };
  };
}
