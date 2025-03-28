{config, ...}: let
  opts = config.features.hm;
in {
  services.syncthing = {
    enable = opts.services.syncthing;
    extraOptions = [
      "--config=${config.home.homeDirectory}/.config/syncthing"
      "--data=${config.home.homeDirectory}/.config/syncthing"
      "--gui-address=0.0.0.0:8384"
      "--no-default-folder"
    ];
  };
}
