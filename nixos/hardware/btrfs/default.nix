{pkgs, ...}: {
  imports = [
    ../../services/snapper.nix
  ];

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  environment.systemPackages = [pkgs.btrfs-progs];
  boot.initrd.supportedFilesystems = ["btrfs"];
}
