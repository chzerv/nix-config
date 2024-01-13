{
  lib,
  pkgs,
  config,
  type,
  ...
}: let
  opts = config.local.sys;
in {
  # Install the GUI app when on a desktop
  config = lib.mkIf opts.services.opensnitch {
    environment.systemPackages = [] ++ lib.optionals (type != "server") [pkgs.opensnitch-ui];

    # https://github.com/evilsocket/opensnitch/wiki/Rules
    services.opensnitch = {
      enable = true;
    };
  };
}
