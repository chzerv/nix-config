{config, ...}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.navi = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.dataFile."navi/cheats/my" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/navi-cheats";
    recursive = true;
  };
}
