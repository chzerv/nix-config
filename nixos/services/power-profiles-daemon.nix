{
  lib,
  config,
  pkgs,
  ...
}: let
  opts = config.local.sys;

  enable-power-saving = pkgs.writeShellScriptBin "enable-power-saving" ''
    if [[ $1 == true ]]; then
      /usr/bin/powerprofilesctl set power-saver &&
        echo 0 >/sys/devices/system/cpu/cpufreq/boost
    elif [[ $1 == false ]]; then
      /usr/bin/powerprofilesctl set balanced &&
        echo 1 >/sys/devices/system/cpu/cpufreq/boost
    else
      echo "Unknown argument" >&2
    fi

  '';
in {
  config = lib.mkIf opts.services.ppd {
    services.power-profiles-daemon.enable = true;

    environment.systemPackages = [enable-power-saving];

    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="enable-power-saving true"
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="enable-power-saving false"
    '';
  };
}
