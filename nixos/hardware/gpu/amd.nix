{pkgs, ...}: {
  imports = [./opengl.nix];
  boot.initrd.kernelModules = ["amdgpu"];

  hardware.opengl = {
    extraPackages = with pkgs; [
      libva
      vaapiVdpau
      libvdpau-va-gl
      rocmPackages.clr.icd

      # Vulkan stuff
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      vulkan-tools
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  environment.systemPackages = with pkgs; [
    clinfo
    nvtop-amd
  ];
}
