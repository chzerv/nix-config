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
      kitty = true;
      alacritty = true;
      default = "alacritty";
    };

    services = {
      syncthing = true;
    };
  };
}
