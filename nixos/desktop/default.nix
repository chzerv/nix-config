{
  config,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  imports = [
    ./plymouth.nix
    ./flatpak.nix
    ./gaming.nix
    ./plasma.nix
  ];

  # Setup a graphical environment
  config = lib.mkIf opts.types.workstation {
    services.xserver = {
      enable = true;
      libinput.enable = true;
      layout = "us";
    };

    # Enable Pipewire
    hardware.pulseaudio.enable = lib.mkForce false;

    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        jack.enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };

    # Provide location
    services.geoclue2.enable = true;
    location.provider = "geoclue2";
  };
}