{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.local.hm;
in {
  home.packages = with pkgs;
    [
      desktop-file-utils
      unzip
      ripgrep
      vgrep
      fd
      jq
      just
      bitwarden-cli
      xsel
      dogdns
      httpie
      duf
      dua
      ncdu
      gping
      glow
      rsync
      git
      translate-shell
      chafa
      python3
      ffmpeg
    ]
    ++ lib.optionals opts.type.workstation [
      firefox
      chromium
      bitwarden
      keepassxc
      wl-clipboard
      webcord
      libreoffice-fresh
      thunderbird
    ];

  programs.yt-dlp = {
    enable = opts.type.workstation;
    settings = {
      embed-thumbnail = true;
    };
  };
}
