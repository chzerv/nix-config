{
  config,
  type,
  ...
}: let
  opts = config.custom.nix;
in {
  services.psd = {
    enable = opts.services.psd && type != "server";
    resyncTimer = "10m";
  };
}
