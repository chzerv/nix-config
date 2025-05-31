{
  pkgs,
  config,
  lib,
  ...
}: let
  fuzzelClipboard = pkgs.writeShellApplication {
    name = "fuzzel-clipboard";
    text = "cliphist list | fuzzel  --match-mode fzf --dmenu --prompt '󱘢 ' --width 56 | cliphist decode | wl-copy --trim-newline";
  };

  fuzzelHyprshot = pkgs.writeShellApplication {
    name = "fuzzel-hyprshot";
    runtimeInputs = with pkgs; [
      gnugrep
      hyprshot
      jq
      pulseaudio
      satty
      slurp
      wl-screenrec
    ];
    text = builtins.readFile ./fuzzel-hyprshot.sh;
  };

  fuzzelLauncher = pkgs.writeShellApplication {
    name = "fuzzel-launcher";
    text = "fuzzel --prompt '󱓞 '";
  };

  fuzzelWindowSwitcher = pkgs.writeShellApplication {
    name = "fuzzel-window-switcher";
    text = builtins.readFile ./fuzzel-window-switcher.sh;
  };
in {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    home.packages = with pkgs; [
      fuzzelClipboard
      fuzzelHyprshot
      fuzzelLauncher
      fuzzelWindowSwitcher
      bemoji
    ];

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          filter-desktop = true;
          lines = 10;
          terminal = "footclient";
          dpi-aware = "yes";
          use-bold = "yes";
          tabs = 2;
          width = 32;
          horizontal-pad = 20;
          vertical-pad = 20;
          inner-pad = 20;
        };

        border = {
          width = 3;
          radius = 10;
        };

        colors = {
          background = "1b1b1bff";
          text = "d4be98ff";
          selection = "3c3836ff";
          selection-text = "7daea3ff";
          border = "6c782eff";
          match = "a9b665ff";
          selection-match = "d3869bff";
        };
      };
    };

    services = {
      cliphist = {
        enable = true;
      };
    };
  };
}
