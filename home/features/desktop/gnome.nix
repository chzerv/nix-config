{
  pkgs,
  lib,
  config,
  type,
  ...
}: let
  cfg = config.hm.gnome;
in {
  options.hm.gnome = {
    enable = lib.mkEnableOption "Configure GNOME";
  };

  config = lib.mkIf cfg.enable {
    dconf.settings =
      {
        # Disable mouse acceleration
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };

        "org/gnome/desktop/applications/terminal" = {
          exec = "${pkgs.ghostty}/bin/ghostty";
        };

        # Custom keybindings gnome default
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>Return";
          command = "footclient";
          name = "Open Terminal";
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
          #button-layout = "appmenu:minimize,maximize,close";
          resize-with-right-button = true;
        };

        "org/gnome/desktop/interface" = {
          gtk-theme = "adw-gtk3";
        };

        "org/gnome/desktop/search-providers" = {
          disabled = ["org.gnome.Contacts.desktop" "org.gnome.Calendar.desktop" "org.gnome.Characters.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.clocks.desktop"];
          sort-order = ["org.gnome.Nautilus.desktop" "org.gnome.Settings.desktop" "org.gnome.Calculator.desktop" "org.gnome.Contacts.desktop"];
        };

        "org/gtk/settings/file-chooser" = {
          sort-directories-first = true;
        };

        "org/gnome/mutter" = {
          edge-tiling = true;
          attach-modal-dialogs = false;
          dynamic-workspaces = false;
          experimental-features = ["scale-monitor-framebuffer" "autoclose-xwayland"];
        };

        "org/gnome/nautilus" = {
          show-delete-permanently = true;
        };
      }
      # Laptop specific settings
      // lib.attrsets.optionalAttrs (type == "laptop") {
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
        };
      };

    # home.pointerCursor = {
    # gtk.enable = true;
    # x11.enable = true;
    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Classic";
    # size = 24;
    # };
  };
}
