{ config, lib, pkgs, ... }: let
  cfg = config.programs.firefox';
in {
  options.programs.firefox'.enable = lib.mkEnableOption "Firefox";

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      policies = {
        SanitizeOnShutdown = true;
        PromptForDownloadLocation = true;
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
          default = "ddg";
          force = true;
        };

        settings = {
          # Always prompt for download location, even for PDF attachments.
          "browser.download.open_pdf_attachments_inline" = true;

          "browser.translations.automaticallyPopup" = false;
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };
}
