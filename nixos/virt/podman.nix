{
  pkgs,
  config,
  lib,
  username,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.virt.podman {
    environment.systemPackages = with pkgs; [
      podman-compose
      docker-compose
      podman-tui
      slirp4netns
      aardvark-dns
    ];

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
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
