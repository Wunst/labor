{
  # Needed on all systems to generate host keys.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";

      # Force public key authentication.
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
