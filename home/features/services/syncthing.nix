{config, ...}: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--config=${config.home.homeDirectory}/.config/syncthing"
      "--data=${config.home.homeDirectory}/.config/syncthing"
      "--gui-address=0.0.0.0:8384"
      "--no-default-folder"
    ];
  };
}
