{
  programs.git = {
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
      find = "!f() { cd `git rev-parse --show-toplevel` && git ls-files | rg \"$@\"; }; f";
      # Show the most recent commit matching a query
      query = "!f() { git show :/\"$@\"; }; f";
    };
    extraConfig = {
      commit.verbose = true;
      init.defaultBranch = "main";
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
      "*.auto.tfvars"
      "*.log"
      ".env"
    ];
  };
}
