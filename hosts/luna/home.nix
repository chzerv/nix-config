{config, ...}: {
  imports = [
    ../../home
  ];

  # DO NOT CHANGE!!
  config.home.stateVersion = "24.11";

  config.hm = {
    gnome.enable = false;
    hyprland.enable = true;
  };
}
