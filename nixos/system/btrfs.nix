{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.custom.nix.system;
in {
  config = lib.mkIf opts.btrfs {
    services.btrfs.autoScrub.enable = true;
    services.btrfs.autoScrub.interval = "weekly";

    environment.systemPackages = [pkgs.btrfs-progs];
    boot.initrd.supportedFilesystems = ["btrfs"];

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
