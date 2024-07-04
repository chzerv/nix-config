{ lib, config, pkgs, type, username, ... }: {
   config = lib.mkIf (type == "wsl") {
	   wsl = {
	    enable = true;
	    wslConf.automount.root = "/mnt";
	    wslConf.interop.appendWindowsPath = false;
	    wslConf.network.generateHosts = false;
	    defaultUser = username;
	    startMenuLaunchers = true;

	    # Enable integration with Docker Desktop (needs to be installed)
	    docker-desktop.enable = false;
	  }; 

    systemd.user = {
      paths.vscode-remote-workaround = {
        wantedBy = ["default.target"];
        pathConfig.PathChanged = "%h/.vscode-server/bin";
      };

      services.vscode-remote-workaround.script = ''
        for i in ~/.vscode-server/bin/*; do
          echo "Fixing vscode-server in $i..."
          ln -sf ${pkgs.nodejs_18}/bin/node $i/node
        done
      '';
    };
  };
}
