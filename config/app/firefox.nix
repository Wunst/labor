{ pkgs, ... }: {
  home-manager.users.ben = {
    programs.firefox = {
      enable = true;
      policies = {
        SanitizeOnShutdown = true;
        PromptForDownloadLocation = true;
        
        # Disable builtin password manager.
        OfferToSaveLogins = false;
      };

      profiles.default = {
        isDefault = true;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          keepassxc-browser
          ublock-origin
          privacy-badger
          canvasblocker
        ];

        search = {
          default = "ddg"; # DuckDuckGo.
          force = true;
        };

        settings = {
          # Firefox dumps PDF into my downloads folder without asking. Disable that.
          "browser.download.open_pdf_attachments_inline" =  true;

          "browser.translations.automaticallyPopup" = false;
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };
}
