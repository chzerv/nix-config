{
  lib,
  config,
  pkgs,
  type,
  username,
  ...
}: {
  config = lib.mkIf (type == "wsl") {
    wsl = {
      enable = true;
      wslConf.automount.root = "/mnt";
      wslConf.interop.appendWindowsPath = false;
      wslConf.network.generateHosts = false;
      defaultUser = username;
      startMenuLaunchers = true;

      # Enable integration with Docker Desktop (needs to be installed)
      docker-desktop.enable = true;
    };

    services.vscode-server.enable = true;
  };
}
