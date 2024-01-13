{...}: {
  disko.devices = {
    disk = {
      nvme0 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            BOOT = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  # In case of "boot is world accessible error", add these:
                  # "fmask=0077"
                  # "dmask=0077"
                ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "/rootfs" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  # This is where storage drives will be mounted and we don't want snapshots
                  # for these drives
                  "/storage" = {
                    mountpoint = "/storage";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/swap" = {
                    mountpoint = "/.swapfile";
                    swap.swapfile.size = "8G";
                  };
                  "/var/lib" = {
                    mountpoint = "/var/lib";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/var/log" = {
                    mountpoint = "/var/lib";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/rootfs/.snapshots" = {
                    mountpoint = "/root/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/home/.snapshots" = {
                    mountpoint = "/home/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/nix/.snapshots" = {
                    mountpoint = "/nix/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/var/lib/.snapshots" = {
                    mountpoint = "/var/lib/.snapshots";
                    mountOptions = ["compress=zstd" "noatime"];
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
