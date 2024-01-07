{
  config,
  pkgs,
  ...
}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  home.packages = [
    pkgs.tmux
  ];

  xdg.configFile.tmux = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/tmux";
  };
}
