switch:
  git add .
  sudo nixos-rebuild switch --flake .

edit-secrets file:
  SOPS_AGE_KEY_CMD="age-plugin-fido2-hmac -m" sops {{file}}

update-secrets:
  SOPS_AGE_KEY_CMD="age-plugin-fido2-hmac -m" sops updatekeys secrets/*
