{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.local.hm;
in {
  wayland.windowManager.sway = {
    enable = opts.desktop.sway;
    checkConfig = false;

    wrapperFeatures = {
      base = false;
      gtk = true;
    };

    systemd = {
      enable = true; # experimental
      xdgAutostart = true;
    };

    xwayland = true;

    extraConfigEarly = ''
      seat seat0 xcursor_theme Bibata-Modern-Classic 24
    '';

    config = rec {
      # Defaults
      modifier = "Mod4";
      terminal = opts.term.default;
      menu = lib.getExe config.programs.rofi.package;

      # Window appearance
      window = {
        titlebar = false;
        hideEdgeBorders = "none";
        border = 1;
      };

      gaps = {
        inner = 4;
        outer = 4;
        bottom = 4;
        top = 4;
        smartGaps = false;
        smartBorders = "off";
      };

      colors = let
        _urgent = "#D18616";
        _bg = "#1d2021";
        _focused = "#45475a";
        _unfocused = "#1d2021";
      in {
        "focused" = {
          border = _focused;
          background = _focused;
          text = _bg;
          indicator = _focused;
          childBorder = _focused;
        };

        "unfocused" = {
          border = _unfocused;
          background = _unfocused;
          text = _focused;
          indicator = _unfocused;
          childBorder = _unfocused;
        };

        "urgent" = {
          border = _urgent;
          background = _urgent;
          text = _bg;
          indicator = _urgent;
          childBorder = _urgent;
        };
      };

      # Handle focus
      focus = {
        wrapping = "yes";
        mouseWarping = false;
        followMouse = false;
      };

      # Autostart
      startup = [
        {
          command = "nm-applet --indicator";
          always = false;
        }

        {
          command = "blueman-applet";
          always = false;
        }

        {
          command = "${lib.getExe pkgs.autotiling} -l2";
          always = true;
        }

        {
          command = "${pkgs.swayosd}/bin/swayosd-server";
          always = true;
        }

        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
      ];

      # Configure input devices (keyboard, mouse, touchpad)
      input = {
        "type:keyboard" = {
          xkb_options = "grp:win_space_toggle,caps:swapescape";
          xkb_layout = "us,gr";
          xkb_variant = ",extended";

          repeat_delay = "300";
          repeat_rate = "30";
        };

        "type:touchpad" = {
          natural_scroll = "enabled";
          pointer_accel = "0.1";
          drag = "enabled";
          tap = "enabled";
          dwt = "enabled";
        };

        "type:pointer" = {
          accel_profile = "flat";
        };
      };

      # Configure monitors
      output = {
        "*" = {
          background = "~/Pictures/Wallpapers/drone.png fill";
        };

        # Laptop screen
        "Samsung Display Corp. 0x4152 Unknown" = {
          scale = "1.75";
          mode = "2880x1800@90.001Hz";
        };

        # External 4K monitor
        "LG Electronics LG HDR 4K 401NTHM7E985" = {
          scale = "1.25";
          mode = "3840x21860@60.000Hz";
        };
      };

      # Don't use the default bar
      bars = [];

      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+Return" = "exec ${terminal} --title float";

        "${modifier}+q" = "kill";

        "${modifier}+Delete" = "exec ${config.programs.swaylock.package}/bin/swaylock -fk";

        "Ctrl+Alt+Delete" = "exec swaymsg exit";
        "${modifier}+F12" = "swaymsg reload";

        "${modifier}+d" = "exec --no-startup-id ${menu} -show drun";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        # Jump between the last two used workspaces
        "${modifier}+Tab" = "workspace back_and_forth";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+a" = "focus parent";

        "${modifier}+t" = "layout tabbed";
        "${modifier}+y" = "layout stacked";
        "${modifier}+i" = "layout toggle split";

        "${modifier}+Shift+Space" = "floating toggle";
        "${modifier}+Space" = "focus mode_toggle";

        "${modifier}+o" = "sticky toggle";

        "${modifier}+Shift+grace" = "move scratchpad";
        "${modifier}+grave" = "scratchpad show";

        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";

        "${modifier}+Shift+1" = "move container to workspace 1;  workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2;  workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3;  workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4;  workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5;  workspace 5";
        "${modifier}+Shift+6" = "move container to workspace 6;  workspace 6";
        "${modifier}+Shift+7" = "move container to workspace 7;  workspace 7";
        "${modifier}+Shift+8" = "move container to workspace 8;  workspace 8";
        "${modifier}+Shift+9" = "move container to workspace 9;  workspace 9";
        "${modifier}+Shift+0" = "move container to workspace 10; workspace 10";

        "${modifier}+x" = "move container to output right";
        "${modifier}+Shift+x" = "move container to output left";
        "${modifier}+greater" = "move workspace to output right";
        "${modifier}+less" = "move workspace to output left";

        "XF86AudioRaiseVolume" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume -5";
        "XF86AudioMute" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle";
        "XF86MonBrightnessUp" = "exec ${pkgs.swayosd}/bin/swayosd-client --brightness raise";
        "XF86MonBrightnessDown" = "exec ${pkgs.swayosd}/bin/swayosd-client --brightness lower";
        "XF86AudioNext" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
        "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";

        "${modifier}+Right" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
        "${modifier}+Left" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
        "${modifier}+Up" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
        "${modifier}+Down" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";

        "Control+Print" = "exec grimshot --notify save area - | swappy -f -";
        "Shift+Print" = "exec grimshot --notify save output - | swappy -f -";
        "Print" = "exec grimshot --notify save window - | swappy -f -";

        "${modifier}+r" = "mode \"resize\"";
      };

      floating = {
        # Use Super+mouse to move a floating window
        modifier = "${modifier}";

        criteria = [
          {title = "float";}
          {title = "^Open File$";}
          {title = "Save File";}
          {title = "About Mozilla Firefox";}
          {
            app_id = "(?i)Thunderbird";
            title = ".*Reminder";
          }
          {app_id = "udiskie";}
          {app_id = "qalculate-gtk";}
          {app_id = "org.gnome.Calculator";}
          {app_id = "mpv";}
          {app_id = "org.gnome.Loupe";}
          {app_id = "task_dialog";}
          {app_id = "blueman-manager";}
          {app_id = "blueman-applet";}
          {window_role = "Preferences";}
          {window_role = "task_dialog";}
        ];
      };

      window.commands = [
        {
          criteria = {title = "^Picture-in-Picture$";};
          command = "floating enable ,resize set height 280, resize set width 500, border none, sticky toggle, move position 1420 800, opacity 0.7";
        }

        {
          criteria = {title = "File Operation Progress";};
          command = "floating enable, border pixel 1, sticky enable, resize set width 40 ppt height 30 ppt";
        }
        {
          criteria = {window_role = "GtkFileChooserDialog";};
          command = "resize set 590 340";
        }
        {
          criteria = {window_role = "GtkFiileChooserDialog";};
          command = "move position center";
        }

        {
          criteria = {app_id = "mpv";};
          command = "floating enable, resize set 1250 750, position center";
        }
      ];

      # Assign applications to workspaces
      assigns = {
        "9" = [
          {class = "^steam_app";}
          {class = "^steam$";}
          {class = "^Steam$";}
          {app_id = "^Steam$";}
        ];

        "10" = [
          {class = "^slack";}
          {app_id = "im.riot.Riot";}
        ];
      };
    };

    extraConfig = ''
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next

      bindgesture pinch:inward+up move up
      bindgesture pinch:inward+down move down
      bindgesture pinch:inward+left move left
      bindgesture pinch:inward+right move right

      # Turn off the laptop screen when the lid is closed
      bindswitch lid:on  exec swaymsg output eDP-1 disable
      bindswitch lid:off exec swaymsg output eDP-1 enable

      set $mode_resize "Resize container"
      mode $mode_resize {
        bindsym --to-code {
          h            exec swaymsg resize grow   left 10 || swaymsg resize shrink right 10
          Ctrl+h       exec swaymsg resize grow   left 1  || swaymsg resize shrink right 1
          j            exec swaymsg resize shrink up   10 || swaymsg resize grow   down  10
          Ctrl+j       exec swaymsg resize shrink up   1  || swaymsg resize grow   down  1
          k            exec swaymsg resize grow   up   10 || swaymsg resize shrink down  10
          Ctrl+k       exec swaymsg resize grow   up   1  || swaymsg resize shrink down  1
          l            exec swaymsg resize shrink left 10 || swaymsg resize grow   right 10
          Ctrl+l       exec swaymsg resize shrink left 1  || swaymsg resize grow   right 1

          Escape mode default
        }
      }

    '';
  };
}
