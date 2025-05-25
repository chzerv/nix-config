{
  pkgs,
  config,
  lib,
  username,
  type,
  ...
}: let
  cfg = config.system.libvirt;
in {
  options.system.libvirt = {
    enable = lib.mkEnableOption "Setup virtualisation using libvirt";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };

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
      ++ lib.optionals (type == "laptop" || type == "desktop") [
        virt-manager
      ];
  };
}
