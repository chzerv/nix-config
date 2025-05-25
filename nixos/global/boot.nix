{lib, ...}: {
  boot = {
    blacklistedKernelModules = ["pcspkr"]; # PC speaker module
    tmp.cleanOnBoot = true;
    kernelParams = lib.mkBefore ["nowatchdog"];
  };
}
