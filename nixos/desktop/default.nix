{lib, ...}: {
  imports = [
    ./plymouth.nix
    ./flatpak.nix
    ./gaming.nix
    ./gnome.nix
    ./fonts.nix
  ];

  # Setup a graphical environment
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

  # Make electron apps use Wayland when possible
  environment.variables.NIXOS_OZONE_WL = "1";

  # https://archlinux.org/news/making-dbus-broker-our-default-d-bus-daemon/
  services.dbus.implementation = "broker";
}
