{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.local.hm;
in {
  config = lib.mkIf opts.desktop.sway {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Hack Nerd Font Mono 14";
      terminal = opts.term.default;
    };
  };
}
