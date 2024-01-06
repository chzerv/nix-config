# System related options that can be enabled/disabled in the top-level configuration and imported modules can react to them. For example, if options.virt.vagrant is enabled, enable vagrant.
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.local.sys = {
    type = {
      workstation = mkEnableOption "Setup a graphical environment";
      server = mkEnableOption "Setup a headless server";
    };

    services = {
      bluetooth = mkEnableOption "Enable bluetooth";
      psd = mkEnableOption "Enable profile-sync-daemon";
      opensnitch = mkEnableOption "Enable the Opensnitch application firewall";
      openssh = mkEnableOption "Enable OpenSSH";
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
      plasma = mkEnableOption "Use KDE Plasma as the Desktop Environment";
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
        assertion = with config.local.sys.type;
          (workstation || server) && !(workstation && server);
        message = "The system can either be a workstation or a server!";
      }
      {
        assertion = with config.local.sys; !(desktop.gaming && type.server);
        message = "A server can't be a gaming machine!";
      }
      {
        assertion = with config.local.sys; !(desktop.plasma && type.server);
        message = "KDE Plasma cannot be installed on a headless server!";
      }
    ];
  };
}
