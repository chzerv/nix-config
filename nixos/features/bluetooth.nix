{config, ...}: let
  opts = config.features.nix;
in {
  hardware.bluetooth = {
    enable = opts.bluetooth;

    # Power on the bluetooth controller on boot
    powerOnBoot = true;
  };
}
