{ config, secrets, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "wunstasus";

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/nvme0n1p2";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "4G";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        luks = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypted";
            settings = {
              allowDiscards = true;
            };
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/@root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                  ];
                };

                "/@home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "compress=zstd"
                  ];
                };

                "/@nix" = {
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

  # Wireguard VPN back home.
  networking.wg-quick.interfaces.wg0 = {
    address = [ "192.168.99.9/24" ];
    dns = [ "192.168.98.2" ];
    privateKeyFile = config.sops.secrets.wireguard-key.path;
    peers = [
      {
        publicKey = "C3UEz3gojSQKnorZMzExarpQ5E7Vx3Hcx1KWMadAVlk=";
        allowedIPs = [
          "192.168.98.0/23"
        ];
        endpoint = "toenderup.no-ip.org:51820";
      }
    ];
  };

  sops.secrets.wireguard-key.sopsFile = ../../secrets/wunstasus/wireguardKey;

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  system.stateVersion = "25.11";
}
