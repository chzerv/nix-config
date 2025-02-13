{
  lib,
  pkgs,
  config,
  type,
  username,
  ...
}: {
  # Packages that should be installed on every host.
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
      nfs-utils
      ffmpeg-full
      util-linux # device info: lscpu, lsblk and more
      sysstat # iostat, sar and more
      tcpdump # network sniffer
      bcc # bcc eBPF tools for performance analysis, tracing and more
      python3 # useful for scripting. Also needed for Ansible to work

      # required for using DNS options in `tcpconnect`
      python312Packages.dnslib
      python312Packages.cachetools
    ]
    # Packages that should be installed only on desktop/laptop systems.
    ++ lib.optionals (type == "desktop" || type == "laptop") [
      ntfs3g
      cifs-utils
      ffmpeg-full
    ];

  programs.adb = lib.mkIf (type == "desktop" || type == "laptop") {
    enable = true;
  };

  programs.wireshark = lib.mkIf (type == "desktop" || type == "laptop") {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.${username}.extraGroups = lib.optionals config.programs.wireshark.enable ["wireshark"];
}
