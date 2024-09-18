{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
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
