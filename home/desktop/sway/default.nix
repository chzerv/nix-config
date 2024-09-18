{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.local.hm;
in {
  imports = [
    ./rofi.nix
    ./swaylock.nix
    # ./theming.nix
    ./services.nix
    ./waybar.nix
  ];

  config = lib.mkIf opts.desktop.sway {
    home.packages = with pkgs; [
      wl-clipboard
      kooha
      libnotify
      sway-contrib.grimshot
      swayidle
      swappy
      sway-contrib.grimshot
      qalculate-gtk
      mpv
      blueman
    ];

    wayland.windowManager.sway = let
      mod = "Mod4";
    in {
      enable = true;
      checkConfig = false;

      extraConfigEarly = ''
        output eDP-1 scale 1.5
        output eDP-1 mode 2880x1800@90.001Hz

        seat seat0 xcursor_theme Bibata-Modern-Classic 24
      '';

      config = rec {
        modifier = mod;
        workspaceAutoBackAndForth = true;
        defaultWorkspace = "workspace number 1";

        terminal = opts.term.default;
        menu = lib.getExe config.programs.rofi.package;

        window = {
          titlebar = false;
          hideEdgeBorders = "none";
          border = 2;
        };

        gaps = {
          inner = 2;
          outer = 2;
          bottom = 2;
          top = 2;
          smartGaps = true;
        };

        focus = {
          wrapping = "yes";
          mouseWarping = false;
          followMouse = false;
        };

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
            command = ''
              swayidle -w \
              timeout 300 'swaymsg "output * dpms off"' \
              resume 'swaymsg "output * dpms on"' \
              before-sleep 'swaylock -f'
            '';
            always = true;
          }
          {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";}
          {
            command = "${pkgs.swayosd}/bin/swayosd-server";
            always = true;
          }
        ];

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

        keybindings = {
          "${mod}+Return" = "Exec ${terminal}";
          "${mod}+Shift+Return" = "Exec ${terminal}";

          # Kill the focus window
          "${mod}+q" = "kill";

          # Focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # Move workspace to other monitor
          "${mod}+greater" = "move workspace to output right";
          "${mod}+less" = "move workspace to output left";

          # Toggle fullscreen
          "${mod}+f" = "fullscreen toggle";

          # Change container layout (stacked, tabbed, split)
          "${mod}+w" = "layout toggle";

          # Toggle tiling/floating
          "${mod}+Shift+Space" = "floating toggle";

          # Change focus between floating/tiled container
          "${mod}+Space" = "focus mode_toggle";

          # Focus parent container
          "${mod}+a" = "focus parent";

          # Move container to scratchpad
          "${mod}+Shift+s" = "move scratchpad";
          # Show the scratchpad
          "${mod}+s" = "scratchpad show";

          # Jump between windowsa
          "${mod}+Tab" = "exec ${pkgs.swayr}/bin/swayr switch-to-urgent-or-lru-window";

          # Switch to workspace
          "${mod}+1" = "workspace 1";
          "${mod}+2" = "workspace 2";
          "${mod}+3" = "workspace 3";
          "${mod}+4" = "workspace 4";
          "${mod}+5" = "workspace 5";
          "${mod}+6" = "workspace 6";
          "${mod}+7" = "workspace 7";
          "${mod}+8" = "workspace 8";
          "${mod}+9" = "workspace 9";
          "${mod}+0" = "workspace 10";

          # Move to workspace with focused container
          "${mod}+Shift+1" = "move container to workspace 1;  workspace 1";
          "${mod}+Shift+2" = "move container to workspace 2;  workspace 2";
          "${mod}+Shift+3" = "move container to workspace 3;  workspace 3";
          "${mod}+Shift+4" = "move container to workspace 4;  workspace 4";
          "${mod}+Shift+5" = "move container to workspace 5;  workspace 5";
          "${mod}+Shift+6" = "move container to workspace 6;  workspace 6";
          "${mod}+Shift+7" = "move container to workspace 7;  workspace 7";
          "${mod}+Shift+8" = "move container to workspace 8;  workspace 8";
          "${mod}+Shift+9" = "move container to workspace 9;  workspace 9";
          "${mod}+Shift+0" = "move container to workspace 10; workspace 10";

          # Move window to other screen
          "${mod}+x" = "move container to output right";
          "${mod}+Shift+x" = "move container to output left";

          # rofi
          "${mod}+d" = "exec --no-startup-id ${menu} -show drun -dpi $dpi";

          # audio
          "XF86AudioRaiseVolume" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume 5";
          "XF86AudioLowerVolume" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume -5";
          "XF86AudioMute" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle";
          "XF86MonBrightnessUp" = "exec ${pkgs.swayosd}/bin/swayosd-client --brightness raise";
          "XF86MonBrightnessDown" = "exec ${pkgs.swayosd}/bin/swayosd-client --brightness lower";
          "XF86AudioNext" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioPrev" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
          "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";

          "${mod}+Right" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
          "${mod}+Left" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
          "${mod}+Up" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
          "${mod}+Down" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";

          # Screenshots
          "Control+Print" = "exec grimshot --notify save area - | swappy -f -";
          "Shift+Print" = "exec grimshot --notify save output - | swappy -f -";
          "Print" = "exec grimshot --notify save window - | swappy -f -";

          # modes
          "${mod}+r" = "mode \"resize\"";

          "F12" = ''exec ${lib.getExe config.programs.rofi.package} -show power-menu -modi "power-menu:${lib.getExe pkgs.rofi-power-menu} --choices=logout/lockscreen/suspend/shutdown/reboot"'';
        };

        floating = {
          # Use Super+mouse to move a floating window
          modifier = mod;

          criteria = [
            {window_role = "float";}
            {app_id = "float";}
            {class = "float";}
            {app_id = "udiskie";}
            {app_id = "qalculate-gtk";}
            {app_id = "mpv";}
          ];
        };

        colors = let
          color_normal_white = "#a89984";
          color_bright_white = "#ebdbb2";
          color_normal_gray = "#282828";
          color_bright_gray = "#3c3836";
          color_bright_yellow = "#d79921";
          color_normal_black = "#1d2021";
          color_unused = "#ff0000";
        in {
          focused = {
            border = color_bright_gray;
            background = color_bright_gray;
            text = color_bright_white;
            indicator = color_bright_gray;
            childBorder = color_normal_black;
          };
          focusedInactive = {
            border = color_bright_gray;
            background = color_bright_gray;
            text = color_bright_white;
            indicator = color_bright_gray;
            childBorder = color_normal_black;
          };
          unfocused = {
            border = color_normal_gray;
            background = color_normal_gray;
            text = color_normal_white;
            indicator = color_normal_gray;
            childBorder = color_normal_black;
          };
          urgent = {
            border = color_bright_yellow;
            background = color_bright_yellow;
            text = color_normal_black;
            indicator = color_unused;
            childBorder = color_unused;
          };
          placeholder = {
            border = color_unused;
            background = color_unused;
            text = color_unused;
            indicator = color_unused;
            childBorder = color_unused;
          };
        };
      };

      extraConfig = ''
        bindgesture swipe:right workspace prev
        bindgesture swipe:left workspace next

        bindgesture pinch:inward+up move up
        bindgesture pinch:inward+down move down
        bindgesture pinch:inward+left move left
        bindgesture pinch:inward+right move right

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

        bar {
          swaybar_command waybar
        }
      '';

      systemd = {
        enable = true;
        xdgAutostart = true;
      };

      xwayland = true;
    };
  };
}
