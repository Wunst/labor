{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "wunstpc";
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1";
    content = {
      type = "gpt";
      partitions = {
        # EFI system partition.
        esp = {
          priority = 1;
          type = "EF00";
          start = "1M";
          end = "512M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "umask=0077"
            ];
          };
        };

        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypt-main";
            settings = {
              # Pass through trim commands to disk.
              allowDiscards = true;
            };

            content = {
              type = "btrfs";
              subvolumes = {
                "/rootfs" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                  ];
                };

                "/var" = {
                  mountpoint = "/var";
                  mountOptions = [
                    "compress=zstd"
                  ];
                };

                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "compress=zstd"
                  ];
                };

                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  # Use the proprietary nvidia drivers for my 1050.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;

  system.stateVersion = "25.11";
}
