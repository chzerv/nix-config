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
}
