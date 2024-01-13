{
  lib,
  config,
  pkgs,
  ...
}: let
  opts = config.local.sys;

  enable-power-saving = pkgs.writeShellScript "enable-power-saving" ''
    if [[ $1 == true ]]; then
      ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
    elif [[ $1 == false ]]; then
      ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced
    else
      echo "Unknown argument" >&2
    fi

  '';
in {
  config = lib.mkIf opts.services.ppd {
    services.power-profiles-daemon.enable = true;

    services.udev.extraRules = ''
      SUBSYSTEM=="power_supply", ATTR{online}=="0", RUN+="${enable-power-saving} true"
      SUBSYSTEM=="power_supply", ATTR{online}=="1", RUN+="${enable-power-saving} false"
    '';
  };
}
