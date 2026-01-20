{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gimp
    inkscape
    krita
    blender
    audacity
    musescore
    obs-studio
    kicad
    freecad
  ];
}
