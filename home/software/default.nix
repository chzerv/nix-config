{
  pkgs,
  lib,
  type,
  ...
}: {
  imports = [
    ./neovim.nix
    ./vscode.nix
    ./alacritty.nix
  ];

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
      ncdu
      rsync
      git
      python3
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
      dogdns
      httpie
      duf
      dua
      gping
      glow
      chafa
      nh
    ]
    ++ lib.optionals (type != "server" && type != "wsl") [
      firefox
      chromium
      obsidian
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

  xdg.desktopEntries = lib.optionals (type != "server" && type != "wsl") {
    obsidian = {
      name = "obsidian";
      exec = "obsidian --ozone-platform=wayland --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations %U";
    };
  };
}
