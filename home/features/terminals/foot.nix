{config, ...}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.foot = {
    enable = true;
    server.enable = true;
  };

  xdg.configFile."foot/foot.ini" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/foot/foot.ini";
  };

  xdg.configFile = {
    "foot/vague" = {
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/vague2k/vague.nvim/refs/heads/main/extras/foot/vague";
        sha256 = "sha256:0ldzmbq3nk9gkvzm7igd6lwzxr7m59q4gzymfm85ndf52cknch6s";
      };
    };
    "foot/gruvbox-dark" = {
      source = builtins.fetchurl {
        url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/gruvbox-dark";
        sha256 = "sha256:1qmxb6z4vd2ji6sw7abr47cn1yxrc09na784mz6nng6400pfgfxr";
      };
    };
  };
}
