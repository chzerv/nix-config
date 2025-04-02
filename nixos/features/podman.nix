{
  pkgs,
  config,
  lib,
  username,
  ...
}: let
  opts = config.features.nix;
in {
  config = lib.mkIf opts.podman {
    environment.systemPackages = with pkgs; [
      podman-compose
      docker-compose
      podman-tui
      slirp4netns
      aardvark-dns
      dive
      distrobox
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
