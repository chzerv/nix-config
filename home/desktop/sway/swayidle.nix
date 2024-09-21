{
  pkgs,
  config,
  ...
}: let
  opts = config.local.hm;
  swaylock = "${config.programs.swaylock.package}/bin/swaylock -fk";
in {
  services.swayidle = {
    enable = opts.desktop.sway;
    events = [
      {
        event = "before-sleep";
        command = swaylock;
      }
    ];
    timeouts = [
      {
        timeout = 5 * 60;
        command = "${pkgs.playerctl}/bin/playerctl pause && ${swaylock}";
      }

      {
        timeout = 6 * 60;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };
}
