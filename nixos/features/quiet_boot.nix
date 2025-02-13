{
  config,
  lib,
  ...
}: let
  opts = config.features.nix;
in {
  config = lib.mkIf opts.quiet_boot {
    boot = {
      initrd = {
        systemd.enable = true;
        verbose = false;
      };
      kernelParams = lib.mkBefore [
        "quiet"
        "systemd.show_status=auto" # supress successful systemd messages
        "loglevel=3"
        "rd.udev.log_level=3" # stop systemd from printing its version number
        "vt.global_cursor_default=0" # Remove blinking console cursor
        "splash"
      ];
      consoleLogLevel = 3;

      plymouth = {
        enable = true;
        # The default theme is "bgrt", which shows the usually ugly OEM logo
        theme = "spinner";
      };
    };
  };
}
