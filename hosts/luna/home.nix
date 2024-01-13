{config, ...}: {
  imports = [
    ../../home
  ];

  # DO NOT CHANGE!!
  config.home.stateVersion = "23.11";

  config.local.hm = {
    type.workstation = true;
    desktop.gnome = true;
    editor = {
      neovim = true;
      vscode = true;
    };

    term = {
      kitty = true;
      alacritty = true;
      default = "alacritty";
    };

    services = {
      syncthing = true;
    };
  };
}
