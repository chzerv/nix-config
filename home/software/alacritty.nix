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

  xdg.configFile."alacritty/kanagawa_dragon.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/alacritty/kanagawa_dragon.toml";
  };
}
