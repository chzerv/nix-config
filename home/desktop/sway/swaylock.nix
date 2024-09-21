{
  pkgs,
  config,
  ...
}: let
  opts = config.local.hm;
in {
  programs.swaylock = {
    enable = opts.desktop.sway;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = false;
      font = "Hack Nerd Font Mono";
      indicator-radius = "100";
      indicator-thickness = "7";
      clock = true;
      timestr = "%H:%M";
      effect-blur = "30x2";
      effect-vignette = "0.5:0.5";
      fade-in = "0.2";
      grace = "1";
      screenshots = true; # requires swaylock-effects
    };
  };
}
