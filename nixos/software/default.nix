{
  pkgs,
  lib,
  type,
  ...
}: {
  imports = [
    ./adb.nix
    ./wireshark.nix
  ];

  environment.systemPackages = with pkgs;
    [
      vim
      rsync
      git
      libnotify
      inotify-info
      ntfs3g
      cifs-utils
      file
      killall
      wget
      usbutils
      lm_sensors
      htop
      pciutils
      man-pages
      iperf3
      lsof
      wireguard-tools
      pv
      cachix
      nfs-utils
      ffmpeg-full
      qmk
      solaar
      logitech-udev-rules
      util-linux # device info: lscpu, lsblk and more
      sysstat # iostat, sar and more
      tcpdump # network sniffer
      bcc # bcc eBPF tools for performance analysis, tracing and more
      python3 # useful for scripting. Also needed for Ansible to work

      # required for using DNS options in `tcpconnect`
      python312Packages.dnslib
      python312Packages.cachetools
    ]
    ++ lib.optionals (type == "wsl") [
      wsl-open # open files with xdg-open from WSL in Windows apps
      wslu # utilities for WSL
    ];
}
