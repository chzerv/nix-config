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
in {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    home.packages = with pkgs; [
      fuzzelClipboard
      fuzzelHyprshot
      fuzzelLauncher
      bemoji
    ];

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          filter-desktop = true;
          lines = 10;
          terminal = "ghostty";
          dpi-aware = "yes";
          use-bold = "yes";
          tabs = 2;
          width = 32;
          horizontal-pad = 20;
          vertical-pad = 20;
          inner-pad = 20;
        };

        border = {
          width = 4;
          radius = 10;
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
