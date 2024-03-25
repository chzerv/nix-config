{
  pkgs,
  username,
  lib,
  type,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      vim
      rsync
      git
      libnotify
      ntfs3g
      cifs-utils
      file
      killall
      usbutils
      lm_sensors
      pciutils
      man-pages
      iperf3
      lsof
      wireguard-tools
      pv
      cachix
    ]
    ++ lib.optionals (type == "server") [
      util-linux # device info: lscpu, lsblk and more
      sysstat # iostat, sar and more
      tcpdump # network sniffer
      bcc # bcc eBPF tools for performance analysis, tracing and more

      # required for using DNS options in `tcpconnect`
      python312Packages.dnslib
      python312Packages.cachetools
    ];

  programs.wireshark = {
    enable = type != "server";
    package = pkgs.wireshark;
  };

  users.users.${username} = lib.mkIf (type != "server") {
    extraGroups = ["wireshark"];
  };
}
