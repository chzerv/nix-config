{
  lib,
  type,
  ...
}: {
  imports =
    [
      ./adguard.nix
      ./bluetooth.nix
      ./btrfs.nix
      ./docker.nix
      ./firewall.nix
      ./flatpak.nix
      ./gaming.nix
      ./libvirt.nix
      ./node_exporter.nix
      ./openssh.nix
      ./plymouth.nix
      ./podman.nix
      ./power-profiles-daemon.nix
      ./smb-mount.nix
      ./sysctl-hardening.nix
      ./systemd-boot.nix
      ./tailscale.nix
      ./vagrant.nix
      ./nextcloud.nix
    ]
    # If the host is not a server, setup a graphical environment and other programs
    ++ lib.optionals (type == "desktop" || type == "laptop") [./desktop]
    ++ lib.optionals (type == "wsl") [./wsl.nix];
}
