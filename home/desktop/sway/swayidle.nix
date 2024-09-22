{
  pkgs,
  config,
  ...
}: let
  opts = config.local.hm;
  swaylockCmd = "${config.programs.swaylock.package}/bin/swaylock -fk";
  swaymsgCmd = "${pkgs.sway}/bin/swaymsg";
in {
  services.swayidle = {
    enable = opts.desktop.sway;
    timeouts = [
      {
        timeout = 5 * 60;
        command = "${pkgs.playerctl}/bin/playerctl pause && ${swaylockCmd}";
      }

      {
        timeout = 6 * 60;
        command = "${swaymsgCmd} 'output * dpms off'";
        resumeCommand = "${swaymsgCmd} 'output * dpms on'";
      }

      {
        timeout = 8 * 60;
        command = "${pkgs.systemd}/bin/systemctl suspend";
        resumeCommand = "${swaymsgCmd} 'output * dpms on'";
      }
    ];

    events = [
      {
        event = "before-sleep";
        command = swaymsgCmd;
      }
    ];
  };
}
