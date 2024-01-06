{
  lib,
  pkgs,
  config,
  ...
}: let
  opts = config.local.sys;
in {
  # Install the GUI app when on a desktop
  config = lib.mkIf opts.services.opensnitch {
    environment.systemPackages = [] ++ lib.optionals opts.type.workstation [pkgs.opensnitch-ui];

    # https://github.com/evilsocket/opensnitch/wiki/Rules
    services.opensnitch = {
      enable = true;
    };
  };
}
