switch:
  git add .
  sudo nixos-rebuild switch --flake .

  # Symlink neovim config for quick iteration without rebuilding.
  ln -rs nvim ~/.config/nvim

edit-secrets file:
  SOPS_AGE_KEY_CMD="age-plugin-fido2-hmac -m" sops {{file}}

update-secrets:
  SOPS_AGE_KEY_CMD="age-plugin-fido2-hmac -m" sops updatekeys `find secrets -type f`
