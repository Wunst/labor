{ config, lib, pkgs, ... }:
let
  cfg = config.programs.obs-studio';
in {
  options.programs.obs-studio'.enable = lib.mkEnableOption "OBS studio with hardware acceleration and virtual camera support";

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;

      # Optional nvidia hardware acceleration.
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-vaapi
      ];
    };
  };
}
