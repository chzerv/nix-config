{
  pkgs,
  config,
  lib,
  username,
  ...
}: let
  cfg = config.system.podman;
in {
  options.system.podman = {
    enable = lib.mkEnableOption "Enable and configure podman";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      podman-compose
      docker-compose
      podman-tui
      slirp4netns
      aardvark-dns
      dive
    ];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    # Rootless podman
    users.users.${username} = {
      subUidRanges = [
        {
          count = 65536;
          startUid = 100000;
        }
      ];
      subGidRanges = [
        {
          count = 65536;
          startGid = 100000;
        }
      ];
    };
  };
}
