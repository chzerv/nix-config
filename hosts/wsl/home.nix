{config, ...}: {
  imports = [
    ../../home
  ];

  config.home.stateVersion = "24.05";

  config.local.hm = {
    editor = {
      neovim = true;
    };
  };
}
