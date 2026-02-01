{ pkgs, ... }: {
  # All of this only works for a single backup drive because of the way incremental backups are handled!
  disko.devices.disk.backup = {
    type = "disk";
    device = "/dev/disk/by-id/usb-WD_Elements_2620_575847324541303455325633-0:0";
    content = {
      type = "gpt";
      partitions = {
        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypt-backup";
            content = {
              type = "btrfs";
              mountpoint = "/mnt/backup";
              mountOptions = [
                "compress=zstd"
              ];
              subvolumes."/daily" = {};
            };
          };
        };
      };
    };
  };

  systemd.services.snapshot-and-backup-home = {
    startAt = "*-*-* 18:00:00";
    path = with pkgs; [ btrfs-progs ];
    after = [ "local-fs.target" ];
    script = ''
      btrfs su sn -r /home /backup-new
      sync

      if [ -e /backup ] ; then
        echo Doing incremental backup...
        btrfs send --compressed-data -p /backup /backup-new | btrfs receive /mnt/backup
      else
        echo Doing full backup...
        btrfs send --compressed-data /backup-new | btrfs receive /mnt/backup
      fi

      mv /mnt/backup/backup-new /mnt/backup/backup
      btrfs su sn -r /mnt/backup/backup /mnt/backup/backup.$(date +%Y-%m-%d.%H:%M:%S)

      btrfs su de /backup || true
      mv /backup-new /backup
    '';
  };
}
