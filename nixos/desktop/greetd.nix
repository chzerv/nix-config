{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.custom.nix;

  gtkgreet = pkgs.writeText "gtkgreet" ''
    exec ${pkgs.greetd.gtkgreet}/bin/gtkgreet -l; ${pkgs.sway}/bin/swaymsg exit
  '';

  launch-gtkgreet = pkgs.writeShellApplication {
    name = "launch-gtkgreet";
    runtimeInputs = [pkgs.sway];
    text = ''
      export XDG_SESSION_TYPE=wayland
      export HOME=/var/run/gtkgreet
      mkdir -p "$HOME/.cache"

      sway -c ${gtkgreet}
    '';
  };
in {
  config = lib.mkIf (opts.desktop.sway && !config.services.xserver.displayManager.gdm.enable) {
    services = {
      greetd = {
        enable = true;
        settings = {
          default_session = {
            command = lib.getExe launch-gtkgreet;
          };
        };
      };
    };

    environment.etc."greetd/environments".text = ''
      sway
    '';

    systemd.tmpfiles.rules = let
      inherit (config.services.greetd.settings.default_session) user;
    in [
      "d /run/gtkgreet 0755 greeter ${user} - -"
      "d /var/log/gtkgreet 0755 greeter ${user} - -"
      "d /var/cache/gtkgreet 0755 greeter ${user} - -"
    ];
  };
}
