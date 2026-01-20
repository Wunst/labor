{
  nix = {
    channel.enable = false;
    gc.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
