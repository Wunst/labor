{
  # Decrypt backup drive when connected. Courtesy of <https://blog.pankajraghav.com/2024/09/17/AUTOMOUNT.html>.
  environment.etc.crypttab.text = ''
    crypt-backup PARTUUID=e1b2ad26-ada4-443e-958a-e916874154ee /backup_key noauto
  '';
  services.udev.extraRules = ''
    SUBSYSTEM=="block" ENV{ID_WWN}=="0x50014ee2693af387",\
    ENV{SYSTEMD_WANTS}="systemd-cryptsetup@crypt-backup.service"
  '';

  fileSystems."/mnt/backup" = {
    device = "/dev/mapper/crypt-backup";
    fsType = "btrfs";
    options = [
      "compress=zstd"
      "x-systemd.automount"
      "x-systemd.device-timeout=5"
      "noauto"
    ];
  };

  services.btrbk.instances.btrbk = {
    onCalendar = "*-*-* 17:00:00"; # Default "daily" would fire at midnight, while my desktop is down.
    settings = {
      snapshot_preserve = "14d";
      snapshot_preserve_min = "2d";
      subvolume."/home" = {};
      target."/mnt/backup" = {};
    };
  };
}
