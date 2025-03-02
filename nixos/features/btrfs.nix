{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.features.nix;
in {
  config = lib.mkIf opts.btrfs {
    services.btrfs.autoScrub.enable = true;
    services.btrfs.autoScrub.interval = "weekly";

    environment.systemPackages = [pkgs.btrfs-progs];
    boot.initrd.supportedFilesystems = ["btrfs"];
  };
}
