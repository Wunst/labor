{ pkgs, ... }: {
  networking.networkmanager.plugins = [
    pkgs.networkmanager-fortisslvpn
  ];
}
