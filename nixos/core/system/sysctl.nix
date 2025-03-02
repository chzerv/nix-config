{
  boot.kernel.sysctl = {
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_background_bytes" = 67108864;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.page-cluster" = 0;
    "vm.swappiness" = 100;
    "kernel.nmi_watchdog" = 0;
  };
}
