{
  config,
  lib,
  type,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.features.nix = {
    bluetooth = mkEnableOption "Enable bluetooth";
    openssh = mkEnableOption "Enable and configure OpenSSH";
    ppd = mkEnableOption "Use power-profiles-daemon for power-saving";

    adguard = mkEnableOption "Setup AdGuard Home";
    node_exporter = mkEnableOption "Setup node_exporter";

    docker = mkEnableOption "Enable docker";
    podman = mkEnableOption "Enable podman";
    libvirt = mkEnableOption "Enable libvirt";
    vagrant = mkEnableOption "Enable vagrant";

    gaming = mkEnableOption "Install steam and setup gamemode";
    flatpak = mkEnableOption "Enable Flatpak";
    quiet_boot = mkEnableOption "Setup quiet boot and enable Plymouth";

    firewall = mkEnableOption "Enable the firewall";
    sysctl_hardening = mkEnableOption "Add kernel hardening tweaks";
    amd_gpu = mkEnableOption "Enable this if the system has an AMD GPU";
    btrfs = mkEnableOption "Enable this if the system uses BTRFS as the filesystem";
    efi = mkEnableOption "Enable this if the system uses EFI";
    zram = mkEnableOption "Enable and configure ZRam";

    mount_smb_share = mkEnableOption "Mount SMB share from my TrueNAS";

    tailscale = {
      enable = mkEnableOption "Enable tailscale";
      routingFeatures = mkOption {
        type = types.nullOr (types.enum ["client" "server" "none" "both"]);
        default = "client";
      };
    };
  };

  config = {
    assertions = [
      {
        assertion = with config.features.nix; !(gaming && type == "server");
        message = "A server can't be a gaming machine!";
      }
      {
        assertion = with config.features.nix; !(docker && podman);
        message = "Can't install both Podman and Docker";
      }
    ];
  };
}
