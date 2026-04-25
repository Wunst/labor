{ lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "spotify"
    "steam"
    "steam-unwrapped"
    "synology-drive-client"
  ];
 }
