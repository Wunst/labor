{
  freecad,
  wrapGAppsHook3,
}:
freecad.overrideAttrs (old: {
  nativeBuildInputs = (old.nativeBuildInputs or []) ++ [wrapGAppsHook3];
})
