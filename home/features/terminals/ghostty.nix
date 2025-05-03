{config, ...}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.ghostty = {
    enable = true;
  };

  xdg.configFile."ghostty/config" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/ghostty/config";
  };
}
