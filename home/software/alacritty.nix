{
  config,
  type,
  ...
}: let
  opts = config.custom.hm;
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.alacritty = {
    enable = opts.term.alacritty && type != "server";
  };

  xdg.configFile."alacritty/alacritty.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/alacritty/alacritty.toml";
  };

  xdg.configFile."alacritty/gruvbox_dark.toml" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/gruvbox_dark.toml";
      sha256 = "sha256:19vf24a1v9qjapmyblvq94gr0pi5kqmj6d6kl6h9pf1cffn5xnl5";
    };
  };
}
