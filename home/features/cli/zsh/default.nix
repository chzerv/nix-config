{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.zsh = {
    enable = false;
    dotDir = ".config/zsh";

    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    autosuggestion = {
      enable = true;
      # highlight = "fg=#808080,bg=none,underline";
      # strategy = ["history" "completion"];
    };

    # enableCompletion = true;
    envExtra = builtins.readFile ./zshenv;
    completionInit = builtins.readFile ./completion.zsh;
    initContent = builtins.readFile ./zshrc;
  };

  xdg.configFile = lib.mkIf config.programs.zsh.enable {
    "zsh/aliases.zsh".text = builtins.readFile ./aliases.zsh;
    "zsh/functions" = {
      source = ./functions;
      recursive = true;
    };
  };

  home.packages = lib.mkIf config.programs.zsh.enable [
    pkgs.zsh-completions
  ];
}
