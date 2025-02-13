{pkgs, ...}: {
  imports = [
    ./gnome.nix
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
}
