{pkgs, ...}: {
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "ntfs3-by-default";
      text = ''
        SUBSYSTEM=="block", TEST!=${pkgs.ntfs3g}/bin/ntfs-3g, ENV{ID_FS_TYPE}=="ntfs", ENV{ID_FS_TYPE}="ntfs3"
      '';
      destination = "/etc/udev/rules.d/80-ntfs3-by-default.rules";
    })

    (pkgs.writeTextFile {
      name = "io-schedulers";
      text = ''
        # HDD
        ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"

        # SSD
        ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"

        # NVMe SSD
        ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"
      '';

      destination = "/etc/udev/rules.d/60-ioschedulers.rules";
    })
  ];
}
