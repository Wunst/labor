{
  # We can allow auto-login as a password is already entered for decryption.
  services = {
    xserver.enable = true;
    displayManager = {
      enable = true;
      autoLogin.user = "ben";
    };
  };
}
