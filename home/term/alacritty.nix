{
  config,
  type,
  ...
}: let
  opts = config.local.hm;
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.alacritty = {
    enable = opts.term.alacritty && type != "server";
  };

  xdg.configFile."alacritty/alacritty.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/alacritty/alacritty.toml";
  };

  xdg.configFile."alacritty/bamboo.toml" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/ribru17/bamboo.nvim/master/extras/alacritty/bamboo.toml";
      sha256 = "sha256:1zbsc2j8yi84nvja7rs30zpns1ysi5y6i508h69w88a8ip4sl0s1";
    };
  };
}
