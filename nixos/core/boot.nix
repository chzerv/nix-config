{lib, ...}: {
  boot = {
    # Blacklist the speaker module
    blacklistedKernelModules = ["pcspkr"];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      timeout = lib.mkDefault 2;
    };
    # Clean /tmp on boot
    tmp.cleanOnBoot = true;
  };
}
