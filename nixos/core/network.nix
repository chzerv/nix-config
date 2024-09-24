{
  hostname,
  lib,
  ...
}: {
  # Network configuration
  networking = {
    hostName = hostname;

    networkmanager.enable = lib.mkDefault true;

    # Set up hostnames for devices in the LAN
    extraHosts = ''
      192.168.1.1     router
      192.168.1.10    pve
      192.168.1.11    truenas
    '';

    useDHCP = lib.mkDefault true;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  ## TCP/IP stack optimizations
  boot = {
    kernel.sysctl = {
      # TCP Fast Open is a TCP extension that reduces network latency by packing
      # data in the sender’s initial TCP SYN. Use it for both incoming and
      # outgoing connections
      "net.ipv4.tcp_fastopen" = 3;

      # Use the BBR congestion control algorithm which can help achieve
      # higher bandwidths and lower latencies
      # https://github.com/google/bbr/
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "cake";
    };
    kernelModules = ["tcp_bbr"];
  };
}
