{
  hostname,
  username,
  lib,
  config,
  ...
}: {
  # Network configuration
  networking = {
    hostName = hostname;

    networkmanager.enable = lib.mkDefault true;

    useDHCP = lib.mkDefault true;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  users.users.${username}.extraGroups = lib.optionals config.networking.networkmanager.enable [
    "networkmanager"
  ];

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
