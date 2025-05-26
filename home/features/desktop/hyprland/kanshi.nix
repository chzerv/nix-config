{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    services.kanshi = {
      enable = true;
      # systemdTarget = "hyprland-session.target";

      settings = [
        {
          output.criteria = "eDP-1";
          output.scale = 1.5;
        }

        {
          profile.name = "undocked";

          profile.outputs = [
            {
              criteria = "eDP-1";
              mode = "2880x1800@90Hz";
              scale = 1.5;
              status = "enable";
            }
          ];
        }

        {
          profile.name = "docked";
          profile.outputs = [
            {
              criteria = "DP-1";
              position = "0,0";
              mode = "3840x2160@60Hz";
              scale = 1.25;
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        }
      ];
    };
  };
}
