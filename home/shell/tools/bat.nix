{pkgs, ...}: {
  programs.bat = {
    enable = true;
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "main";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-mocha.tmTheme";
      };
    };
    config = {
      theme = "catppuccin";
      italic-text = "always";
      color = "always";
      style = "numbers,changes,header,grid";
      paging = "never";
      pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
      tabs = false;
      map-syntax = [
        "*.ino:C++"
        ".ignore:Git Ignore"
      ];
    };
  };
}
