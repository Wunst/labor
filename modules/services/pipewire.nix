{ config, lib, ... }: let
  cfg = config.services.pipewire';
in {
  options.services.pipewire'.enable = lib.mkEnableOption "Pipewire";

  config = lib.mkIf cfg.enable {
    # Allow real time scheduling for low latency applications.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
