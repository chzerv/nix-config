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
      enable = opts.desktop.sway;
      package = pkgs.rofi-wayland;
      font = "Hack Nerd Font Mono 14";
      terminal = opts.term.default;
      theme = "gruvbox-dark-hard";
    };
  };
}
