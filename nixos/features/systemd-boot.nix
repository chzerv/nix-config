{
  config,
  lib,
  ...
}: let
  cfg = config.system.systemd-boot;
in {
  options.system.systemd-boot = {
    enable = lib.mkEnableOption "Use systemd-boot as the bootloader (EFI systems only)";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = lib.mkDefault 2;
    };
  };
}
