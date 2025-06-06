{
  pkgs,
  lib,
  config,
  type,
  ...
}: let
  cfg = config.system.power-profiles;

  # This script uses power-profiles-daemon and amd_pstate_epp (energy performance preference) to change power modes depending
  # on whether the system is powered on or not.
  #
  # Supported EPP hints can be found using 'cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences'
  use-power-saver-on-battery = pkgs.writeShellScript "change-mode-on-power" ''
    if [[ $1 == true ]]; then
      ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
      echo "power" | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    elif [[ $1 == false ]]; then
      ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
      echo "balance_performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference
    else
      echo "Unknown argument" >&2
    fi
  '';

  run-fast = pkgs.writeShellScriptBin "run-fast" ''
    ${pkgs.power-profiles-daemon}/bin/powerprofilesctl launch -p performance -- "$@"
  '';
in {
  options.system.power-profiles = {
    enable = lib.mkEnableOption "Enable and configure power-profiles-daemon";
  };

  config = lib.mkIf cfg.enable {
    services.power-profiles-daemon = {
      enable = true;
    };

    # TODO: Proper testing for 'active' VS 'guided' for both performance, battery life and temperatures
    boot.kernelParams = ["amd_pstate=active"];

    services.udev.extraRules = lib.optionals (type == "laptop") ''
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${use-power-saver-on-battery} true"
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${use-power-saver-on-battery} false"
    '';

    environment.systemPackages = [
      run-fast
    ];
  };
}
