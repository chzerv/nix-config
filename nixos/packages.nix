{
  pkgs,
  username,
  lib,
  type,
  ...
}: {
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
    lsof
    wireguard-tools
    pv
    cachix
  ];

  programs.wireshark = {
    enable = type != "server";
    package = pkgs.wireshark;
  };

  users.users.${username} = lib.mkIf (type != "server") {
    extraGroups = ["wireshark"];
  };
}
