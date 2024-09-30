{
  pkgs,
  config,
  ...
}: let
  opts = config.custom.hm;
in {
  programs.waybar = {
    enable = opts.desktop.sway;
    style = pkgs.lib.readFile ./waybar.css;
    settings = [
      {
        layer = "top";
        position = "top";
        mode = "dock";
        margin = "7 9 0 9";
        height = 30;

        modules-left = ["custom/launcher" "sway/workspaces" "sway/mode" "custom/media"];
        modules-center = ["sway/window"];
        modules-right = ["idle_inhibitor" "pulseaudio" "battery" "power-profiles-daemon" "sway/language" "keyboard-state" "network" "tray" "clock" "custom/power-menu"];

        "sway/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
          format = "{name}";
        };

        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        "custom/media" = {
          format = "{icon}{}";
          return-type = "json";
          format-icons = {
            Playing = " ";
            Paused = " ";
          };
          max-length = 50;
          exec = "playerctl -i firefox -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl -i firefox play-pause";
          on-scroll-up = "playerctl -i firefox previous";
          on-scroll-down = "playerctl -i firefox next";
        };

        "sway/window" = {
          format = "{}";
          max-length = 25;
          align = true;
        };

        "idle_inhibitor" = {
          format = "{icon} ";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        "pulseaudio" = {
          scroll-step = 5;
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

        "power-profiles-daemon" = {
          format = "{icon}";
          tooltip-format = "Active profile: {profile}";
          tooltip = true;
          format-icons = {
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };

        "sway/language" = {
          format = "  {}";
          on-click = "swaymsg input type:keyboard xkb_switch_layout next";
        };

        "keyboard-state" = {
          capslock = true;
          format = "{name} {icon} ";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        "network" = {
          format-wifi = " ";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ Disconnected";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          tooltip = false;
        };

        "clock" = {
          format = "{:%b-%d %H:%M}";
        };

        "tray" = {
          icon-size = 16;
          spacing = 0;
        };

        "custom/launcher" = {
          format = "  ";
          tooltip = false;
          on-click = "${config.programs.rofi.package}/bin/rofi -show drun";
        };

        "custom/power-menu" = {
          format = " ⏻ ";
          tooltip = false;
          on-click = "rofi-power-menu";
        };
      }
    ];
  };
}
