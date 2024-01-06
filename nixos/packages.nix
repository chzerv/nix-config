{
  pkgs,
  username,
  lib,
  config,
  ...
}: let
  opts = config.local.sys;
in {
  environment.systemPackages = with pkgs;
    [
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
    ]
    # If we have a graphical environment..
    ++ lib.optionals opts.type.workstation [
      firefox
      wl-clipboard
    ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.${username}.extraGroups = ["wireshark"];
}
