{
  lib,
  spotify,
  util-linux,
  perl,
  unzip,
  zip,
  curl,
  fetchurl,
}: let
  spotx = fetchurl {
    url = "https://raw.githubusercontent.com/SpotX-Official/SpotX-Bash/b70121d23c0ca9ddc13dec4d3addcba2799a1a4b/spotx.sh";
    hash = "sha256-i0LorEywe/xaB4Cc/ryNg4ZtL8QhC6oPJQCcGrPTFjY=";
  };
in spotify.overrideAttrs (old: {
  nativeBuildInputs = old.nativeBuildInputs ++ [
    util-linux
    perl
    unzip
    zip
    curl
  ];

  unpackPhase =
    builtins.replaceStrings
      [ "runHook postUnpack" ]
      [
        ''
          patchShebangs --build ${spotx}
          runHook postUnpack
        ''
      ]
      old.unpackPhase;

  installPhase =
    builtins.replaceStrings
      [ "runHook postInstall" ]
      [
        ''
          bash ${spotx} -f -P "$out/share/spotify"
          runHook postInstall
        ''
      ]
      old.installPhase;

  meta = with lib; {
    description = "Spotify with adblock by SpotX-Bash";
    homepage = "https://github.com/SpotX-Official/SpotX-Bash";
    license = licenses.unfree;
    maintainers = [ ];
    mainProgram = "spotify";
    platforms = platforms.linux;
  };
})
