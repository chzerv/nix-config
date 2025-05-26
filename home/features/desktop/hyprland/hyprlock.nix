{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };
        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];
        input-field = [
          {
            size = "200, 50";
            halign = "center";
            valign = "center";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            hide_input = false;
            outline_thickness = 5;
            shadow_passes = 3;
            fail_timeout = 2000;
            fail_transition = 300;
          }
        ];
      };
    };
  };
}
