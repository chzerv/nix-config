# profile-sync-daemon
{config, ...}: let
  opts = config.local.sys;
in {
  services.psd = {
    enable = opts.services.psd && opts.type.workstation;
    resyncTimer = "10m";
  };
}
