{config, ...}: let
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/zellij";
  };
}
