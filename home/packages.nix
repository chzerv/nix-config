{
  pkgs,
  lib,
  type,
  ...
}: {
  home.packages = with pkgs;
    [
      unzip
      ripgrep
      vgrep
      fd
      jq
      jqp
      yq-go
      just
      dogdns
      httpie
      duf
      dua
      ncdu
      gping
      glow
      rsync
      git
      chafa
      python3
    ]
    ++ lib.optionals (type != "server") [
      firefox
      obsidian
      chromium
      bitwarden
      bitwarden-cli
      keepassxc
      wl-clipboard
      webcord
      libreoffice-fresh
      thunderbird
      treefmt
      alejandra
      shfmt
      shellcheck
      stylua
      desktop-file-utils
      translate-shell
      ffmpeg
      vlc
      nurl
      note # Built in pkgs/note
    ];

  programs.yt-dlp = {
    enable = type != "server";
    settings = {
      embed-thumbnail = true;
    };
  };
}
