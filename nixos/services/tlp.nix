{
  lib,
  config,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.services.tlp {
    services.power-profiles-daemon.enable = lib.mkForce false;

    services.tlp = {
      enable = true;
      settings = {
        # Disable NMI watchdogs
        NMI_WATCHDOG = 0;

        # Power down idle devices when on battery
        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";

        # PCIE Active State Power Management (ASPM)
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";

        # amd-pstate
        # TODO: Test "active" vs "guided"
        # NOTE: "guided" requires kernel >= 6.4 and is basically "active" with frequency
        # range enforced
        CPU_DRIVER_OPMODE_ON_AC = "active";
        CPU_DRIVER_OPMODE_ON_BAT = "active";

        # When using amd-pstate active mode, this defaults to "powersave"
        # as it is the only P-State scaling governor that allows for the
        # energy vs performance hints to be taken into consideration
        # See: https://gitlab.freedesktop.org/upower/power-profiles-daemon#operations-on-amd-based-machines
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        # CPU_SCALING_GOVERNOR_ON_AC = "performance";

        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 70;

        # Disable CPU turbo when on battery
        CPU_BOOST_ON_BAT = 0;

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # AMD GPU Dynamic Power Management
        RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
        RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "battery";

        # Ideapad conservation mode sets the charge limit to 60%
        START_CHARGE_THRESH_BAT0 = 50;
        STOP_CHARGE_THRESH_BAT0 = 59;
      };
    };
  };
}
