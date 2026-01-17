{ config, pkgs, secrets, ... }: {
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

  home-manager.users.ben = {
    programs.bash.enable = true;
    home.stateVersion = "25.11";
  };
}
