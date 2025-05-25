{
  pkgs,
  lib,
  config,
  ...
}: {
  systemd.oomd = {
    enable = lib.mkDefault true;

    # Fedora defaults
    enableRootSlice = true;
    enableUserSlices = true;

    extraConfig = {
      # Let the OOM-killer kick in 15s after a unit's memory pressure limits have been exceeded. Default is 20s.
      DefaultMemoryPressureDurationSec = "15s";
    };
  };

  # Enable and configure zram
  # https://www.reddit.com/r/Fedora/comments/mzun99/new_zram_tuning_benchmarks/
  zramSwap = {
    enable = lib.mkDefault true;
    algorithm = "lz4";
  };

  # https://docs.kernel.org/next/admin-guide/mm/multigen_lru.html
  systemd.services."mglru" = {
    enable = config.zramSwap.enable;
    wantedBy = ["basic.target"];
    script = ''
      ${pkgs.coreutils-full}/bin/echo 1000 > /sys/kernel/mm/lru_gen/min_ttl_ms
    '';
    serviceConfig = {
      Type = "oneshot";
    };
    unitConfig = {
      ConditionPathExists = "/sys/kernel/mm/lru_gen/enabled";
      Description = "Configure Enable Multi-Gen LRU";
    };
  };

  boot.kernel.sysctl = {
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_background_bytes" = 67108864;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.page-cluster" = 0;
    "vm.swappiness" = 100;
    "kernel.nmi_watchdog" = 0;
  };
}
