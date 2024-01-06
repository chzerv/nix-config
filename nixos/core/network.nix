{
  hostname,
  lib,
  ...
}: {
  # Network configuration
  networking = {
    hostName = hostname;
    enableIPv6 = false;

    networkmanager.enable = lib.mkDefault true;

    # Set up hostnames for devices in the LAN
    extraHosts = ''
      192.168.1.1     router
      192.168.1.4     rpi3
      192.168.1.10    pve
      192.168.1.11    truenas
      192.168.1.12    andromeda
      192.168.1.13    mon
    '';

    useDHCP = lib.mkDefault true;
    firewall.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
