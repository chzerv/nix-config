{config, ...}: {
  imports = [
    ../../home
  ];

  config.home.stateVersion = "24.05";

  config.custom.hm = {
    editor = {
      neovim = true;
    };
  };
}
