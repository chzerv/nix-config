{
  pkgs,
  lib,
  username,
  config,
  ...
}: let
  opts = config.custom.nix.software;
in {
  config = lib.mkIf opts.wireshark {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    users.users.${username}.extraGroups = ["wireshark"];
  };
}
