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

  xdg.configFile."foot/vague" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/vague2k/vague.nvim/refs/heads/main/extras/foot/vague";
      sha256 = "sha256:0ldzmbq3nk9gkvzm7igd6lwzxr7m59q4gzymfm85ndf52cknch6s";
    };
  };
}
