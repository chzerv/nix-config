{
  pkgs,
  lib,
  ...
}: {
  imports = [./opengl.nix];

  boot.initrd.kernelModules = ["i915"];

  hardware.opengl = {
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiIntel
    ];
  };

  environment.systemPackages = with pkgs; [
    nvtop-intel
  ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkDefault "va_gl";
  };
}
