{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.vagrant;
in {
  options.system.vagrant = {
    enable = lib.mkEnableOption "Enable vagrant";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vagrant
    ];

    environment.variables = lib.mkIf config.virtualisation.libvirtd.enable {
      VAGRANT_DEFAULT_PROVIDER = lib.mkDefault "libvirt";
    };
  };
}
