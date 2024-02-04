{pkgs, ...}: rec {
  # sway-audio-idle-inhibit = pkgs.callPackage ./sway-audio-idle-inhibit {};
  note = pkgs.callPackage ./note {};
}
