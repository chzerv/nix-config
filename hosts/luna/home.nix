{config, ...}: {
  imports = [
    ../../home
  ];

  # DO NOT CHANGE!!
  config.home.stateVersion = "23.11";

  config.custom.hm = {
    editor = {
      neovim = true;
    };

    term = {
      alacritty = true;
      default = "alacritty";
    };

    services = {
      syncthing = true;
    };

    desktop = {
      gnome = false;
      sway = true;
      hidpi = true;
    };
  };
}
