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

      # Enable integration with Docker Desktop
      # https://github.com/nix-community/NixOS-WSL/issues/235#issuecomment-1937424376
      docker-desktop.enable = false;

      extraBin = with pkgs; [
        # Binaries for Docker Desktop wsl-distro-proxy
        {src = "${coreutils}/bin/mkdir";}
        {src = "${coreutils}/bin/cat";}
        {src = "${coreutils}/bin/whoami";}
        {src = "${coreutils}/bin/ls";}
        {src = "${busybox}/bin/addgroup";}
        {src = "${su}/bin/groupadd";}
        {src = "${su}/bin/usermod";}
      ];
    };

    ## patch the script
    systemd.services.docker-desktop-proxy.script = lib.mkForce ''${config.wsl.wslConf.automount.root}/wsl/docker-desktop/docker-desktop-user-distro proxy --docker-desktop-root ${config.wsl.wslConf.automount.root}/wsl/docker-desktop "C:\Program Files\Docker\Docker\resources"'';

    # VSCode server workaround
    services.vscode-server.enable = true;
  };
}
