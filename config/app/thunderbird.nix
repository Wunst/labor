{
  home-manager.users.ben = {
    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        settings = {
          "mail.openpgp.allow_external_gnupg" = true;
          "mail.spellcheck.inline" = false;
        };
      };
    };
  };
}
