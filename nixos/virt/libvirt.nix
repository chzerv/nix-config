{
  pkgs,
  config,
  lib,
  username,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.virt.libvirt {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };

    services.spice-vdagentd.enable = true;

    # Add user to the "libvirt" group
    users.users.${username}.extraGroups = ["libvirtd"];

    environment.systemPackages = with pkgs;
      [
        spice
        spice-gtk
        spice-protocol
        win-virtio
        win-spice
      ]
      # Install virt-manager if there is a graphical environment
      ++ lib.optionals (opts.type.workstation) [
        virt-manager
      ];
  };
}
