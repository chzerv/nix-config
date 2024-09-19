{
  pkgs,
  lib,
  type,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = type == "desktop"; # 32bit is only useful for gaming
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Work around for hardcoded HIP libraries
  # https://wiki.nixos.org/wiki/AMD_GPU#HIP
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

  hardware.amdgpu = {
    # Load the `amdgpu` kernel mode as early as possible
    initrd.enable = true;

    # OpenCL support
    opencl.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
    clinfo
  ];
}
