{config, ...}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.alacritty = {
    enable = true;
  };

  xdg.configFile."alacritty/alacritty.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/alacritty/alacritty.toml";
  };

  xdg.configFile."alacritty/kanagawa_dragon.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/alacritty/kanagawa_dragon.toml";
  };
}
