{
  pkgs,
  username,
  lib,
  config,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkMerge [
    {
      environment.systemPackages = with pkgs; [
        vim
        rsync
        git
        libnotify
        ntfs3g
        cifs-utils
        file
        killall
        usbutils
        lm_sensors
        pciutils
        man-pages
        iperf3
      ];
    }

    (
      lib.mkIf opts.type.workstation {
        programs.wireshark = {
          enable = true;
          package = pkgs.wireshark;
        };

        users.users.${username}.extraGroups = ["wireshark"];
      }
    )
  ];
}
