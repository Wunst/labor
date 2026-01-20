{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vlc
    spotify-spotx
    yt-dlp
  ];
}
