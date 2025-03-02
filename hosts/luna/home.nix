{config, ...}: {
  imports = [
    ../../home
  ];

  # DO NOT CHANGE!!
  config.home.stateVersion = "24.11";

  config.features.hm = {
    services = {
      syncthing = true;
    };
  };
}
