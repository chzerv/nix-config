{pkgs, ...}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "nix.fish";
        src = pkgs.fetchFromGitHub {
          owner = "kidonng";
          repo = "nix.fish";
          rev = "ad57d970841ae4a24521b5b1a68121cf385ba71e";
          sha256 = "13x3bfif906nszf4mgsqxfshnjcn6qm4qw1gv7nw89wi4cdp9i8q";
        };
      }
      {
        name = "fifc";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "2ee5beec7dfd28101026357633616a211fe240ae";
          sha256 = "00f6vklsknnav09abrsfy2m577r30m0pphy0hr86b1w0nnvspdin";
        };
      }
      {
        name = "bd";
        src = pkgs.fetchFromGitHub {
          owner = "0rax";
          repo = "fish-bd";
          rev = "master";
          # Find out with: 'nurl https://github.com/0rax/fish-bd master'
          sha256 = "sha256-GeWjoakXa0t2TsMC/wpLEmsSVGhHFhBVK3v9eyQdzv0=";
        };
      }
    ];

    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # <Alt>+e -> open command buffer in vim
      bind \ee edit_command_buffer

      # $PATH
      fish_add_path "$HOME/.cargo/bin"
      fish_add_path "$HOME/.node_modules/bin"
      fish_add_path "$HOME/go/bin"

      # fifc setup: Use neovim and C-x instead of TAB
      set -Ux fifc_editor nvim
      set -U fifc_keybinding \cx

      set -x EDITOR nvim
      set -x MANPAGER 'nvim --clean +Man!'
      set -x npm_config_prefix "$HOME/.node_modules/"
      # set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    '';

    shellAbbrs = {
      rsync = "rsync --progress";
      cp = "cp -i -v";
      rm = "rm -i -v";
      dd = "dd status=progress";
      lg = "lazygit";
      ":q" = "exit";
      ":Q" = "exit";
      sshfs = "sshfs - o idmap=user,ServerAliveInterval=5,ServerAliveCountMax=3,reconnect";

      g = "git";
      ga = "git add";
      gaf = "git add-fzf";
      glo = "git log --oneline";
      gs = "git status";
      gst = "git stash";
      gco = "git checkout (git branch | tr -d ' ' | fzf --height 20% --reverse)";
      gc = "git commit -v";
      gcm = "git commit -m";
      gca = "git commit -v --amend";
      gcan = "git commit --amend --no-edit";
      gd = "git diff";

      k = "kubectl";

      tree = "eza --tree";
    };

    shellAliases = {
      tmux = "tmux -2";
      ls = "eza";
    };

    functions = {
      mkd = ''
        mkdir --parents $argv; and cd $argv
      '';

      mktmp = ''
        mkd /tmp/(date "+%d-%m")
      '';

      kubectx = {
        wraps = "kubectl";
        description = "Show Kubernetes contexts, highlighting the current one";
        body = ''
          kubectl config get-contexts | awk '{ if ($1 == "*") { print "\033[32m→ " $2 } else { print $2 } }' | tail -n +2
        '';
      };

      cheat = ''
        curl --silent "cheat.sh/:list" \
            | fzf-tmux \
            -p 70%,60% \
            --layout=reverse --multi \
            --preview \
            "curl --silent cheat.sh/{}\?style=rtt" \
            --bind "?:toggle-preview" \
            --preview-window 60%
      '';

      bind_bang = ''
        switch (commandline -t)
        case "!"
          commandline -t -- $history[1]
          commandline -f repaint
        case "*"
          commandline -i !
        end
      '';

      bind_dollar = ''
        switch (commandline -t)
        case "*!"
          commandline -f backward-delete-char history-token-search-backward
        case "*"
          commandline -i '$'
        end
      '';

      fish_user_key_bindings = ''
        bind ! bind_bang
        bind '$' bind_dollar

        # https://github.com/fish-shell/fish-shell/issues/7152#issuecomment-663575001
        bind \cz 'fg 2>/dev/null; commandline -f repaint'
      '';
    };
  };

  xdg.configFile."fish/themes/Catppuccin Mocha.theme" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Mocha.theme";
      sha256 = "MlI9Bg4z6uGWnuKQcZoSxPEsat9vfi5O1NkeYFaEb2I=";
    };
  };
}
