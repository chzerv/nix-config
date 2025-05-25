{
  imports = [
    ./gnome.nix
    ./fonts.nix
    ./peripherals.nix
  ];

  # services = {
  #   libinput.enable = true;
  # };

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

  # Allow non-root users to mount FUSE filesystems with `allow_other`
  programs = {
    fuse.userAllowOther = true;
  };

  boot = {
    kernel.sysctl."fs.inotify.max_user_watches" = 524288;
  };
}
