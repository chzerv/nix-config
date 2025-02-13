{
  inputs,
  pkgs,
  ...
}: {
  # Use nixos-generators to generate ISOs, VM images and more.
  generators = {
    pve-lxc-docker = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "proxmox-lxc";
      modules = [
        ../generators/pve-lxc-docker
      ];
      specialArgs = {inherit inputs;};
    };

    pve-vm-template = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "proxmox";
      modules = [
        ../generators/pve-vm-template
      ];
      specialArgs = {inherit inputs;};
    };

    iso = inputs.nixos-generators.nixosGenerate {
      system = "x86_64-linux";
      format = "iso";
      modules = [
        ../generators/iso
      ];
      specialArgs = {inherit inputs;};
    };

    rpi4-sd-image = inputs.nixos-generators.nixosGenerate {
      system = "aarch64-linux";
      format = "sd-aarch64-installer";
      modules = [
        ../generators/rpi4-sd-image
      ];
      specialArgs = {inherit inputs;};
    };
  };

  note = pkgs.callPackage ./note {};
}
