{
  config,
  lib,
  type,
  ...
}: let
  cfg = config.system.sysctl_hardening;
in {
  options.system.sysctl_hardening = {
    enable = lib.mkEnableOption "Apply kernel hardening tweaks";
  };

  config = lib.mkIf cfg.enable {
    boot.kernel.sysctl = {
      # SysRq is a key combo which the kernel which respond to regardless of
      # whatever else it is doing. It can do stuff like reboot, crash the system,
      # kill all processes, remount filesystems and more, which can be a security
      # risk. See https://www.kernel.org/doc/html/latest/admin-guide/sysrq.html
      "kernel.sysrq" =
        if type == "desktop" || type == "laptop"
        then 1
        else 0;

      # Disable kexec, which allows replacing the current running kernel
      "kernel.kexec_load_disabled" = lib.mkDefault 1;

      # Disable core dumps
      "kernel.core_pattern" = "/dev/null";

      # TCP/IP stack hardening

      # Help against SYS flood attacks
      # https://www.cloudflare.com/learning/ddos/syn-flood-ddos-attack/
      "net.ipv4.tcp_syncookies" = lib.mkDefault 1;

      # Enable reverse path filtering, which lets the kernel do source validation
      # of all the received packets. Helps against IP spoofing
      "net.ipv4.conf.default.rp_filter" = lib.mkDefault 1;
      "net.ipv4.conf.all.rp_filter" = lib.mkDefault 1;

      # Log martian packets
      # https://en.wikipedia.org/wiki/Martian_packet
      "net.ipv4.conf.default.log_martians" = lib.mkDefault 1;
      "net.ipv4.conf.all.log_martians" = lib.mkDefault 1;

      # Disable ICMP redirects, we are not a router
      "net.ipv4.conf.all.send_redirects" = lib.mkDefault 0;
      "net.ipv4.conf.default.send_redirects" = lib.mkDefault 0;

      # Prevent bogus ICMP packets from filling up logs
      "net.ipv4.icmp_ignore_bogus_error_responses" = lib.mkDefault 1;

      # Ignore ICMP echo requests. Helps against DDoS
      "net.ipv4.icmp_echo_ignore_all" = lib.mkDefault 0;
    };
  };
}
