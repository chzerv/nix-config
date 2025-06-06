{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#808080,bg=none,underline";
      strategy = ["history" "completion"];
    };

    enableCompletion = true;
    envExtra = builtins.readFile ./zshenv;
    completionInit = builtins.readFile ./completion.zsh;
    initContent = builtins.readFile ./zshrc;
    loginExtra = builtins.readFile ./zlogin;
  };

  xdg.configFile = {
    "zsh/aliases.zsh".text = builtins.readFile ./aliases.zsh;
    "zsh/functions" = {
      source = ./functions;
      recursive = true;
    };
  };
}
