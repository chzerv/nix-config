{
  pkgs,
  lib,
  type,
  ...
}: {
  home.packages = with pkgs; [
    libappindicator
    libappindicator-gtk3
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.dash-to-dock
    gnomeExtensions.pano
    adw-gtk3
    dconf2nix
  ];

  dconf.settings =
    {
      # Extensions to use
      # Use `gnome-extensions list` for the names
      # "org/gnome/shell" = {
      #   enabled-extensions = [
      #     "appindicatorsupport@rgcjonas.gmail.com"
      #     "dash-to-dock@micxgx.gmail.com"
      #     "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      #   ];
      # };

      # Customize dash-to-dock
      "org/gnome/shell/extensions/dash-to-dock" = {
        always-center-icons = false;
        apply-custom-theme = false;
        background-opacity = 0.8;
        custom-background-color = false;
        custom-theme-shrink = true;
        dash-max-icon-size = 32;
        disable-overview-on-startup = false;
        dock-position = "LEFT";
        extend-height = true;
        height-fraction = 0.9;
        hot-keys = false;
        icon-size-fixed = false;
        running-indicator-style = "DEFAULT";
        transparency-mode = "DEFAULT";
      };

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
    // lib.attrsets.optionalAttrs (type == "laptop") {
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };
      "org/gnome/mutter" = {
        # Fractional scaling and logical monitor layour for HiDPI screens
        experimental-features = ["scale-monitor-framebuffer"];
      };
    };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
}
