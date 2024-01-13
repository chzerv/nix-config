# profile-sync-daemon
{
  config,
  type,
  ...
}: let
  opts = config.local.sys;
in {
  services.psd = {
    enable = opts.services.psd && type != "server";
    resyncTimer = "10m";
  };
}
