{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.local.hm;
in {
  config = lib.mkIf opts.desktop.sway {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        ignore-empty-password = false;
        font = "Hack Nerd Font Mono";
        indicator-radius = "100";
        indicator-thickness = "10";
        clock = true;
        timestr = "%H:%M";
        datestr = "%A, %d %B";
        effect-blur = "30x2";
        effect-vignette = "0.5:0.5";
        fade-in = "0.2";
      };
    };
  };
}
