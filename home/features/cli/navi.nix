{config, ...}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.navi = {
    enable = true;
    enableFishIntegration = config.programs.fish.enable;
    enableZshIntegration = config.programs.zsh.enable;
  };

  xdg.dataFile."navi/cheats/my" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/navi-cheats";
    recursive = true;
  };
}
