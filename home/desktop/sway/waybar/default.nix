{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.local.hm;
in {
  programs.waybar = {
    enable = opts.desktop.sway;
    style = pkgs.lib.readFile ./waybar.css;
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 29;
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-center = ["sway/window"];
        modules-right = [
          "pulseaudio"
          "battery"
          "network"
          "sway/language"
          "tray"
          "clock"
        ];

        "sway/workspaces" = {
          all-outputs = false;
          disable-scroll-wraparound = true;
        };

        "sway/mode" = {
          tooltip = false;
        };

        "sway/window" = {
          format = "{}";
          max-length = 25;
          align = true;
        };

        "tray" = {
          icon-size = 14;
          spacing = 5;
        };

        "clock" = {
          format = "{:%b-%d %H:%M}";
        };

        "pulseaudio" = {
          scroll-step = 1;
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon}  {volume}%";
          format-muted = "muted ";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click = "${pkgs.alacritty}/bin/alacritty --title float -e $HOME/Projects/rust/audio_switcher/target/release/audio_switcher";
        };

        "battery" = {
          states = {
            good = 95;
            warning = 45;
            critical = 25;
          };
          format = "{icon}  {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        "network" = {
          format-wifi = " ";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          tooltip = false;
        };

        "sway/language" = {
          "format" = "  {}";
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
        };
      }
    ];
  };
}
