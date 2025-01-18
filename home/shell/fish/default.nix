{pkgs, ...}: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # <Alt>+e -> open command buffer in vim
      bind \ee edit_command_buffer

      # $PATH
      fish_add_path "$HOME/.cargo/bin"
      fish_add_path "$HOME/.node_modules/bin"
      fish_add_path "$HOME/go/bin"
      fish_add_path "$HOME/.krew/bin"

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
      ":q" = "exit";
      ":Q" = "exit";
      sshfs = "sshfs - o idmap=user,ServerAliveInterval=5,ServerAliveCountMax=3,reconnect";

      g = "git";
      ga = "git add";
      gaf = "git add-fzf";
      glo = "git log --oneline";
      gs = "git status";
      gst = "git stash";
      gc = "git commit -v";
      gcm = "git commit -m";
      gca = "git commit -v --amend";
      gcan = "git commit --amend --no-edit";
      gd = "git diff";
      gw = "git worktree";

      k = "kubectl";

      tree = "eza --tree";
    };

    shellAliases = {
      tmux = "tmux -2";
      ls = "eza";
      l = "eza";
      ll = "eza -l";
      la = "eza -la";
      tfw = "terraform workspace select (terraform workspace list | tr -d ' ' | fzf --height 20% --reverse)";
      gco = "git checkout (git branch | tr -d ' ' | fzf --height 20% --reverse)";
    };

    functions = {
      mkd = ''
        mkdir --parents $argv; and cd $argv
      '';

      mktmp = ''
        mkd /tmp/(date "+%d-%m")
      '';

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

      bd = ''
        set root (git rev-parse --show-toplevel)

        cd $root
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

  xdg.configFile."fish/conf.d/kanagawa.fish" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/rebelot/kanagawa.nvim/588227581b0412a239ec67da1ab3a7c8562ed44e/extras/fish/kanagawa.fish";
      sha256 = "sha256:0smmy783j41294gda1mpq8bqdy7h7j69zhh2i0dgxdg4gxqm7i6s";
    };
  };
}
