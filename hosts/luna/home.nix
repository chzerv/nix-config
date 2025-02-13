{config, ...}: {
  imports = [
    ../../home
  ];

  # DO NOT CHANGE!!
  config.home.stateVersion = "23.11";

  config.features.hm = {
    services = {
      syncthing = true;
    };

    desktop = {
      hidpi = true;
    };
  };
}
