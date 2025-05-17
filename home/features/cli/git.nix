{
  programs = {
    git = {
      enable = true;
      delta.enable = true;
      userName = "Chris Zervakis";
      userEmail = "xrist.zerv@protonmail.com";
      aliases = {
        st = "status";
        co = "checkout";
        cm = "commit --verbose";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        graph = "log --oneline --graph --all --decorate";
        lg = "log --oneline";
        lgu = "log --color --graph --abbrev-commit HEAD --not @{u}^@"; # git log "until upstream", including the latest upstream commit
        find = "!f() { cd `git rev-parse --show-toplevel` && git ls-files | rg \"$@\"; }; f";
        # Show the most recent commit matching a query
        query = "!f() { git show :/\"$@\"; }; f";
        unstage = "reset HEAD --"; # git unstage path/to/file
        vi = "!nvim -c 'Git | wincmd o' ."; # Open git fugitive in Neovim
      };
      extraConfig = {
        # Inspired by: https://blog.gitbutler.com/how-git-core-devs-configure-git/
        init.defaultBranch = "main";
        commit.verbose = true;
        branch.sort = "-committerdate";
        tag.sort = "version:refname";
        rerere.enabled = true;
        core.editor = "nvim";
        delta = {
          features = "line-numbers decorations";
          whitespace-error-style = "22 reverse";
          syntax-theme = "TwoDark";
          side-by-side = "false";
        };
      };
      ignores = [
        ".DS_Store"
        ".svn"
        "*~"
        "*.swp"
        "*.orig"
        "*.rbc"
        "*.iml"
        ".project"
        ".settings"
        ".vscode/"
        "*.log"
        ".env"
        ".direnv"
        ""
      ];
    };
  };
}
