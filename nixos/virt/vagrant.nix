{
  pkgs,
  config,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.virt.vagrant {
    environment.systemPackages = with pkgs; [
      vagrant
    ];

    environment.variables = lib.mkIf opts.virt.libvirt {
      VAGRANT_DEFAULT_PROVIDER = lib.mkDefault "libvirt";
    };
  };
}
