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
        assertion = with config.my.sys-opts;
          (desktop || server) && !(desktop && server);
        message = "The system can either be a desktop or a server!";
      }
    ];
  };
}
