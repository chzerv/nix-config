# Packages that should be installed on every host
{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vim
    rsync
    git
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
    util-linux # device info: lscpu, lsblk and more
    sysstat # iostat, sar and more
    tcpdump # network sniffer
    bcc # bcc eBPF tools for performance analysis, tracing and more
    python3 # useful for scripting. Also needed for Ansible to work
    config.boot.kernelPackages.cpupower

    # required for using DNS options in `tcpconnect`
    python312Packages.dnslib
    python312Packages.cachetools
  ];
}
