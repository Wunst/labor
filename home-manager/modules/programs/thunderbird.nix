{ config, lib, ... }: let
  cfg = config.programs.thunderbird';
in {
  options.programs.thunderbird'.enable = lib.mkEnableOption "Thunderbird";

  config = lib.mkIf cfg.enable {
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
