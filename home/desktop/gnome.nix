{
  pkgs,
  lib,
  config,
  type,
  ...
}: let
  opts = config.custom.hm;
in {
  config = lib.mkIf opts.desktop.gnome {
    dconf.settings =
      {
        # Disable mouse acceleration
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };

        # By default, these keybindings are 'Super + 1, Super + 2' etc
        # which I want to rebind, so, disable them
        "org/gnome/shell/keybindings" = {
          switch-to-application-1 = [""];
          switch-to-application-2 = [""];
          switch-to-application-3 = [""];
          switch-to-application-4 = [""];
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = ["<Super>q"];
          switch-to-workspace-1 = ["<Super>1"];
          switch-to-workspace-2 = ["<Super>2"];
          switch-to-workspace-3 = ["<Super>3"];
          switch-to-workspace-4 = ["<Super>4"];
          move-to-workspace-1 = ["<Shift><Super>1"];
          move-to-workspace-2 = ["<Shift><Super>2"];
          move-to-workspace-3 = ["<Shift><Super>3"];
          move-to-workspace-4 = ["<Shift><Super>4"];
          switch-windows = ["<Super>Tab"];
          switch-windows-backward = ["<Shift><Super>Tab"];
          switch-applications = ["<Alt>Tab"];
          switch-applications-backward = ["<Shift><Alt>Tab"];
        };

        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
          resize-with-right-button = true;
        };
      }
      # Laptop specific settings
      // lib.attrsets.optionalAttrs (type == "laptop") {
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
        };
      }
      # HiDPI tweaks
      // lib.attrsets.optionalAttrs (opts.desktop.hidpi) {
        "org/gnome/mutter" = {
          # Fractional scaling and logical monitor layour for HiDPI screens
          experimental-features = ["scale-monitor-framebuffer" "xwayland-native-scaling"];
        };
      };

    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
