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
      nh
    ]
    ++ lib.optionals (type != "server") [
      bitwarden-cli
      treefmt
      alejandra
      shfmt
      shellcheck
      stylua
      desktop-file-utils
      translate-shell
      nurl
      gh
      note # Built in pkgs/note
    ]
    ++ lib.optionals (type != "server" && type != "wsl") [
      firefox
      obsidian
      chromium
      bitwarden
      keepassxc
      wl-clipboard
      webcord
      libreoffice-fresh
      thunderbird
      vlc
    ];

  programs.yt-dlp = {
    enable = type != "server";
    settings = {
      embed-thumbnail = true;
    };
  };
}
