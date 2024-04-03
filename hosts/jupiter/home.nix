{config, ...}: {
  imports = [
    ../../home
  ];

  # DO NOT CHANGE!!
  config.home.stateVersion = "23.11";

  config.local.hm = {
    editor = {
      neovim = true;
      vscode = true;
    };

    term = {
      wezterm = true;
      kitty = true;
      default = "wezterm";
    };

    services = {
      syncthing = true;
    };

    desktop.gnome = false;
  };
}
