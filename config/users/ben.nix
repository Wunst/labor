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
      "dialout"
    ];
  };

  # Include home-manager configuration.
  home-manager = {
    # Use allowUnfree and overlays from system.
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ben = {
      programs.bash.enable = true;
      home.stateVersion = "25.11";
    };
  };
}
