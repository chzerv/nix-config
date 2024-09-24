{
  pkgs,
  config,
  lib,
  username,
  ...
}: let
  opts = config.custom.nix;
in {
  config = lib.mkIf opts.virt.docker {
    environment.systemPackages = with pkgs; [docker-compose];

    # Docker can also be run rootless
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };

    # Add user to the "docker" group
    users.users.${username}.extraGroups = ["docker"];
  };
}
