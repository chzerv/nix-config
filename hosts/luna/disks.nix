{...}: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            BOOT = {
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "fmask=0077"
                ];
              };
            };
            luks = {
              size = "100%";
              label = "luks";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/secret.key"; # Interactive
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "nixos" "-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "subvol=root"
                        "defaults"
                        "noatime"
                        "space_cache=v2"
                        "compress-force=zstd:1"
                        "commit=120"
                        "ssd"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "subvol=home"
                        "defaults"
                        "noatime"
                        "space_cache=v2"
                        "compress-force=zstd:1"
                        "commit=120"
                        "ssd"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "subvol=nix"
                        "defaults"
                        "noatime"
                        "space_cache=v2"
                        "compress-force=zstd:1"
                        "commit=120"
                        "ssd"
                      ];
                    };
                    "/log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "subvol=log"
                        "defaults"
                        "noatime"
                        "space_cache=v2"
                        "compress-force=zstd:1"
                        "commit=120"
                        "ssd"
                      ];
                    };
                    "/cache" = {
                      mountpoint = "/var/cache";
                      mountOptions = [
                        "subvol=cache"
                        "defaults"
                        "noatime"
                        "space_cache=v2"
                        "compress-force=zstd:1"
                        "commit=120"
                        "ssd"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
