{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    synology-drive-client

    keepassxc
  ];
}
