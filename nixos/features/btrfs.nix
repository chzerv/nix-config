{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.system.btrfs;
in {
  options.system.btrfs = {
    enable = lib.mkEnableOption "Apply BTRFS tweaks";
  };

  config = lib.mkIf cfg.enable {
    services.btrfs.autoScrub.enable = true;
    services.btrfs.autoScrub.interval = "weekly";

    environment.systemPackages = [pkgs.btrfs-progs];
    boot.initrd.supportedFilesystems = ["btrfs"];
  };
}
