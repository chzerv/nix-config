{
  pkgs,
  config,
  lib,
  username,
  ...
}: let
  cfg = config.system.docker;
in {
  options.system.docker = {
    enable = lib.mkEnableOption "Enable Docker";
    addUserToGroup = lib.mkEnableOption "Add the current user to the docker group";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [docker-compose];

    # Docker can also be run rootless
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };

    # Add user to the "docker" group
    users.users.${username}.extraGroups = lib.optionals (cfg.addUserToGroup) ["docker"];
  };
}
