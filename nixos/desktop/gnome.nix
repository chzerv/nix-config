{pkgs, ...}: {
  services.xserver = {
    enable = true;
    excludePackages = [
      pkgs.xterm
    ];
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [pkgs.mutter];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer', 'variable-refresh-rate', 'xwayland-native-scaling']
      '';
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    gedit
    epiphany
    totem # video player
    simple-scan
    geary # email reader
    yelp # help
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    gnome-maps
    gnome-music
    gnome-software
    gnome-weather
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    adwaita-icon-theme
    ffmpegthumbnailer
    dconf-editor
    gsettings-desktop-schemas # collection of GSettings schemas for various GNOME components
    pinentry
    libappindicator
    libappindicator-gtk3
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    adw-gtk3
    dconf2nix
  ];

  services.udev.packages = with pkgs; [gnome-settings-daemon mutter];
}
