{
  pkgs,
  lib,
  config,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.services.gpg_agent {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      enableBrowserSocket = true;
      enableExtraSocket = true;
    };

    environment.systemPackages = with pkgs; [
      pinentry-curses
      gpg-tui
      gnupg
    ];
  };
}
