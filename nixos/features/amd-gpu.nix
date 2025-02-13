{
  pkgs,
  lib,
  type,
  username,
  config,
  ...
}: let
  opts = config.features.nix;
in {
  config = lib.mkIf opts.amd_gpu {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = type == "desktop"; # 32bit is only useful for gaming
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
      amdgpu = {
        # Load the `amdgpu` kernel mode as early as possible
        initrd.enable = true;

        # OpenCL support
        opencl.enable = true;
      };
    };

    services.xserver.videoDrivers = [
      "amdgpu"
    ];

    boot = {
      # Allow GPU overclocking
      kernelParams = lib.optionals (type == "desktop") ["amdgpu.ppfeaturemask=0xfff7ffff"];
    };

    environment.systemPackages = with pkgs;
      [
        libva-utils
        vdpauinfo
        clinfo
        vulkan-tools
      ]
      ++ lib.optionals config.hardware.amdgpu.opencl.enable [
        rocmPackages.rocminfo
        rocmPackages.rocm-smi
      ];

    users.users.${username}.extraGroups = ["video" "render"];
  };
}
