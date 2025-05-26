{pkgs, ...}: {
  imports = [
    ./gnome.nix
    ./hyprland
  ];

  home.packages = with pkgs; [
    firefox
    chromium
    bitwarden
    keepassxc
    wl-clipboard
    webcord
    libreoffice-fresh
    thunderbird
    vlc
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
