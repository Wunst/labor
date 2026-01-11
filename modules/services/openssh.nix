{ config, lib, ... }: let
  cfg = config.services.openssh';
in {
  options.services.openssh'.enable = lib.mkEnableOption "the OpenSSH server";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";

        # Force public key authentication.
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
