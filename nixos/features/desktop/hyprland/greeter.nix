{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.hyprland.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd uwsm start -- hyprland-uwsm.desktop";
          user = "greeter";
        };
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
