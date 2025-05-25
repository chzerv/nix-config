{
  lib,
  pkgs,
  type,
  ...
}: {
  imports = [
    ./fish
    ./bat.nix
    ./bottom.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./distrobox.nix
    ./kubernetes.nix
    ./navi.nix
    ./nix-index.nix
    ./pfetch.nix
    ./ripgrep.nix
    ./starship.nix
    ./tldr.nix
    ./tmux.nix
    ./yazi.nix
    ./yt-dlp.nix
    ./zoxide.nix

    ./scripts
  ];

  home.packages = with pkgs;
    [
      unzip
      ncdu
      fd
      jq
      jqp
      yq-go
      rsync
      git
      python3
      nh
      just
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
      dogdns
      httpie
      duf
      dua
      gping
      glow
      chafa
    ];
}
