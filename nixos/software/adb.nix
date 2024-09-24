{
  lib,
  config,
  ...
}: let
  opts = config.custom.nix.software;
in {
  config = lib.mkIf opts.adb {
    programs.adb = {
      enable = true;
    };
  };
}
