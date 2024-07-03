{
  pkgs,
  lib,
  ...
}: {
  services.xserver.videoDrivers = lib.mkDefault ["modesetting"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl

      # OpenCL
      rocmPackages.clr.icd
    ];
  };

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };

  # Work arround for hard-coded HIP libraries
  systemd.tmpfiles.rules = let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
  ];

  environment.systemPackages = with pkgs; [
    lact # Linux AMDGPU controller

    libva-utils
    vdpauinfo
    clinfo
  ];
}
