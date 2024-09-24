{
  lib,
  config,
  ...
}: let
  opts = config.custom.nix.system;
in {
  config = lib.mkMerge [
    {
      boot = {
        blacklistedKernelModules = ["pcspkr"]; # PC speaker module

        tmp.cleanOnBoot = true;

        initrd = {
          supportedFilesystems = ["nfs"];
          kernelModules = ["nfs"];
        };
      };
    }

    (lib.mkIf opts.efi {
      boot.loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
        timeout = lib.mkDefault 2;
      };
    })
  ];
}
