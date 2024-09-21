{lib, ...}: {
  imports = [
    ./plymouth.nix
    ./flatpak.nix
    ./gaming.nix
    ./gnome.nix
    ./sway.nix
    ./plasma.nix
    ./fonts.nix
    ./smb_mount.nix
  ];

  # Setup a graphical environment
  services = {
    libinput.enable = true;
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
  services.geoclue2.enable = lib.mkDefault true;
  location.provider = "geoclue2";

  # Make electron apps use Wayland when possible
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  # https://archlinux.org/news/making-dbus-broker-our-default-d-bus-daemon/
  services.dbus.implementation = "broker";
}
