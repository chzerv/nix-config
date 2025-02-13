{
  imports = [
    ./gnome.nix
    ./fonts.nix
    ./peripherals.nix
  ];

  services = {
    libinput.enable = true;
  };

  # Enable Pipewire
  security.rtkit.enable = true;

  services = {
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  # Make electron apps use Wayland when possible
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  # https://archlinux.org/news/making-dbus-broker-our-default-d-bus-daemon/
  services.dbus.implementation = "broker";

  # Allow non-root users to mount FUSE filesystems with `allow_other`
  programs = {
    fuse.userAllowOther = true;
  };
}
