{
  lib,
  config,
  ...
}: {
  # These might differ from host to host (e.g., a host is a cloud VPS). Using lib.mkDefault
  # means we can override them on a per-host basis
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = lib.mkDefault [
      (config.i18n.defaultLocale + "/UTF-8")
      "el_GR.UTF-8/UTF-8"
    ];
  };
  time.timeZone = lib.mkDefault "Europe/Athens";

  programs = {
    # Allow non-root users to mount FUSE filesystems with `allow_other`
    fuse.userAllowOther = true;
  };

  # systemd-oomd tweaks
  # Mostly follows Fedora's defaults
  systemd.oomd = {
    enable = lib.mkDefault true;

    # Fedora defaults
    enableRootSlice = true;
    enableUserSlices = true;

    extraConfig = {
      # Let the OOM-killer kick in 15s after a unit's memory pressure limits have been exceeded. Default is 20s.
      DefaultMemoryPressureDurationSec = "15s";
      # ManagedOOMMemoryPressure = "kill";
      # ManagedOOMMemoryPressureLimit = "60%";
    };
  };
}
