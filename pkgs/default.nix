pkgs: with pkgs; {
  freecad-fix-gsettings-schemas = callPackage ./fr/freecad-fix-gsettings-schemas/package.nix {};
  spotify-spotx = callPackage ./sp/spotify-spotx/package.nix {};
}
