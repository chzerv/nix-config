{
  systemd.oomd = {
    enable = true;

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
