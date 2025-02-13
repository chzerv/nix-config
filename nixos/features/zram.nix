{
  config,
  lib,
  pkgs,
  ...
}: let
  opts = config.features.nix;
in {
  config = lib.mkIf opts.zram {
    # https://www.reddit.com/r/Fedora/comments/mzun99/new_zram_tuning_benchmarks/
    zramSwap = {
      enable = true;
      algorithm = "lz4";
    };
    boot.kernel.sysctl = {"vm.page-cluster" = 1;};

    # https://docs.kernel.org/next/admin-guide/mm/multigen_lru.html
    systemd.services."mglru" = {
      enable = true;
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
  };
}
