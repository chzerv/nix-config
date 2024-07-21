{pkgs, ...}: {
  programs.bat = {
    enable = true;
    themes = {
      bamboo = {
        src = pkgs.fetchFromGitHub {
          owner = "ribru17";
          repo = "bamboo.nvim";
          rev = "master";
          sha256 = "sha256-VlKpWt8ZpSj8KLTbk87XGieRObxwnSCoeq2NHv/Hwlk=";
        };
        file = "extras/bat/bamboo.tmTheme";
      };
    };
    config = {
      theme = "bamboo";
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
