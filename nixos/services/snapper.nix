{
  lib,
  pkgs,
  config,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.services.snapper {
    environment.systemPackages = [pkgs.snapper];

    # They way our BTRFS subvolumes are setup (see hosts/jupiter/disks.nix)
    # allow us to snapshot only selected subvolumes.
    services.snapper = {
      # snapshotRootOnBoot = true;
      cleanupInterval = "7d";
      snapshotInterval = "daily";
      configs = {
        # root = {
        #   TIMELINE_CREATE = true;
        #   TIMELINE_CLEANUP = true;
        #   SUBVOLUME = "/";
        # };
        home = {
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
          SUBVOLUME = "/home";
        };
        # nix = {
        #   TIMELINE_CREATE = true;
        #   TIMELINE_CLEANUP = true;
        #   SUBVOLUME = "/nix";
        # };
      };
    };
  };
}
