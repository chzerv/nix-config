# System related options that can be enabled/disabled in the top-level configuration and imported modules can react to them. For example, if options.virt.vagrant is enabled, enable vagrant.
{
  config,
  lib,
  type,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.local.sys = {
    security = {
      firewall = mkEnableOption "Enable the firewall";
      sysctl_hardening = mkEnableOption "Add kernel hardening tweaks";
    };

    services = {
      bluetooth = mkEnableOption "Enable bluetooth";
      psd = mkEnableOption "Enable profile-sync-daemon";
      opensnitch = mkEnableOption "Enable the Opensnitch application firewall";
      openssh = mkEnableOption "Enable OpenSSH";
      snapper = mkEnableOption "Enable Snapper for BTRFS snapshots";
      tlp = mkEnableOption "Use TLP for power-saving";
      ppd = mkEnableOption "Use power-profiles-daemon for power-saving";
      tailscale = {
        enable = mkEnableOption "Enable tailscale";
        routingFeatures = mkOption {
          type = types.nullOr (types.enum ["client" "server" "none" "both"]);
          default = "client";
        };
      };
    };

    desktop = {
      gaming = mkEnableOption "Enable if the host is used for gaming";
      flatpak = mkEnableOption "Enable flatpak and install Flathub";
      plymouth = mkEnableOption "Setup silent boot and enable Plymouth";
    };

    virt = {
      docker = mkEnableOption "Enable docker";
      podman = mkEnableOption "Enable podman";
      libvirt = mkEnableOption "Enable libvirt";
      vagrant = mkEnableOption "Enable vagrant";
    };
  };

  config = {
    assertions = [
      {
        assertion = with config.local.sys; !(desktop.gaming && type == "server");
        message = "A server can't be a gaming machine!";
      }
      {
        assertion = with config.local.sys; !(virt.docker && virt.podman);
        message = "Can't install both Podman and Docker";
      }
      {
        assertion = with config.local.sys; !(services.tlp && services.ppd);
        message = "Can't use both TLP and power-profiles-daemon!";
      }
    ];
  };
}
