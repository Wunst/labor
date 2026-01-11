{ config, lib, pkgs, secrets, ... }: let
  cfg = config.users'.ben;
in {
  options.users'.ben.enable = lib.mkEnableOption "my user account";

  config = lib.mkIf cfg.enable {
    # Add zsh to the list of allowed login shells.
    programs.zsh.enable = true;

    sops.secrets.hashedPassword = {
      sopsFile = "${secrets}/hashedPassword";
      neededForUsers = true;
    };
    users.users.ben = {
      isNormalUser = true;
      description = "Ben";
      shell = pkgs.zsh;
      hashedPasswordFile = config.sops.secrets.hashedPassword.path;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}
