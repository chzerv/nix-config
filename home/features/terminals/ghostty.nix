{
  config,
  pkgs,
  ...
}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  home.packages = with pkgs; [
    ghostty
  ];

  xdg.configFile."ghostty/config" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/ghostty/config";
  };
}
