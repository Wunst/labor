{ config, lib, pkgs, ... }:
let
  cfg = config.programs.gpg';
in {
  options.programs.gpg'.enable = lib.mkEnableOption "GnuPG + gpg-agent with graphical interface";

  config = lib.mkIf cfg.enable {
    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentry = {
        package = pkgs.pinentry-gnome3;
        program = "pinentry-gnome3";
      };
    };

    home.packages = [ pkgs.gcr ];
  };
}
