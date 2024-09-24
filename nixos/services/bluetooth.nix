{config, ...}: let
  opts = config.custom.nix;
in {
  hardware.bluetooth = {
    enable = opts.services.bluetooth;

    # Power on the bluetooth controller on boot
    powerOnBoot = true;
  };
}
