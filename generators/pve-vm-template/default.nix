# Proxmox VE NixOS template
{...}: {
  system.stateVersion = "23.11";

  # Services to be enabled inside the VM
  services = {
    # Enable SSH
    openssh.enable = true;

    # Enable QEMU guest agent
    qemuGuest.enable = true;
  };

  # Proxmox configuration
  proxmox = {
    qemuConf = {
      name = "nixos-template";
      bios = "ovmf";
      boot = "c";
      scsihw = "virtio-scsi-single";
      cores = 2;
      memory = 4096;
      diskSize = "auto";
      additionalSpace = "40G";
      agent = true;
      virtio0 = "fast:base-150-disk-1,iothread=0";
    };
    qemuExtraConf = {
      # For whatever reason, setting an EFI disk makes the VM unbootable..
      # efidisk0 = "local-lvm:base-150-disk-0,efitype=4m,pre-enrolled-keys=0,size=4M";
      machine = "q35";
      ide2 = "none,media=cdrom";
      smbios1 = "uuid=17006b9c-a419-0000-0000-000000000000";
      cpu = "x86-64-v2-AES";
      kvm = 1;
      # Cloud-init drive
      ide0 = "local-lvm:vm-150-cloudinit,media=cdrom";
    };
  };

  # Use cloud-init for network initialization
  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
  };

  # Note that creating a user through the Proxmox UI using cloud-init will NOT work
  services.cloud-init = {
    enable = true;
    network.enable = true;
  };

  # Set a dummy password for the root user and add my SSH keys as authorized keys
  # This is just so we can SSH into the VM and will be overwritten by nixos-rebuild
  users.users.root = {
    password = "changeme";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
    ];
  };
}
