{
  config,
  lib,
  type,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.custom.nix = {
    system = {
      firewall = mkEnableOption "Enable the firewall";
      sysctl_hardening = mkEnableOption "Add kernel hardening tweaks";
      efi = mkEnableOption "Enable this if the system uses EFI";
      amd_gpu = mkEnableOption "Enable this if the system has an AMD GPU";
      btrfs = mkEnableOption "Enable this if the system uses BTRFS as the filesystem";
      mount_smb_share = mkEnableOption "Mount SMB share from TrueNAS";
    };

    services = {
      bluetooth = mkEnableOption "Enable bluetooth";
      psd = mkEnableOption "Enable profile-sync-daemon";
      openssh = mkEnableOption "Enable OpenSSH";
      ppd = mkEnableOption "Use power-profiles-daemon for power-saving";
      adguard = mkEnableOption "Setup AdGuard Home";
      node_exporter = mkEnableOption "Setup node_exporter";
      tailscale = {
        enable = mkEnableOption "Enable tailscale";
        routingFeatures = mkOption {
          type = types.nullOr (types.enum ["client" "server" "none" "both"]);
          default = "client";
        };
      };
    };

    virt = {
      docker = mkEnableOption "Enable docker";
      podman = mkEnableOption "Enable podman";
      libvirt = mkEnableOption "Enable libvirt";
      vagrant = mkEnableOption "Enable vagrant";
    };

    desktop = {
      gaming = mkEnableOption "Enable if the host is used for gaming";
      flatpak = mkEnableOption "Enable flatpak and install Flathub";
      plymouth = mkEnableOption "Setup silent boot and enable Plymouth";
      gnome = mkEnableOption "Use GNOME as the Desktop Environment";
      sway = mkEnableOption "Use Sway as the Window Manager";
      plasma = mkEnableOption "Use KDE Plasma 6 as the Desktop Environment";
    };

    software = {
      wireshark = mkEnableOption "Setup Wireshark";
      adb = mkEnableOption "Setup ADB";
    };
  };

  config = {
    assertions = [
      {
        assertion = with config.custom.nix; !(desktop.gaming && type == "server");
        message = "A server can't be a gaming machine!";
      }
      {
        assertion = with config.custom.nix; !(virt.docker && virt.podman);
        message = "Can't install both Podman and Docker";
      }
    ];
  };
}
