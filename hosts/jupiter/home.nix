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
      foot = true;
      default = "foot";
    };

    services = {
      syncthing = true;
    };

    desktop.gnome = false;
  };
}
