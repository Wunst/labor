{ config, lib, pkgs, ... }: let
  cfg = config.services.printing';
in {
  options.services.printing'.enable = lib.mkEnableOption "printing";

  config = lib.mkIf cfg.enable {
    services = {
      # Discover printers on the network.
      avahi.enable = true;
      printing = {
        enable = true;
        startWhenNeeded = true;

        # cups-browsed auto-installs drivers from public networks, which can be a security issue.
        browsed.enable = false;
        drivers = [
          pkgs.hplip
        ];
      };
    };
  };
}
