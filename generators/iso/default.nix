{
  inputs,
  lib,
  ...
}: let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  system.stateVersion = "23.11";

  environment.systemPackages = with pkgs; [
    vim
    rsync
  ];

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Services to be enabled
  services = {
    # Enable SSH
    openssh.enable = true;
  };

  # Use cloud-init for network initialization
  networking = {
    networkmanager.enable = lib.mkDefault true;
    useDHCP = lib.mkDefault true;
  };

  # Set a dummy password for the root user and add my SSH keys as authorized keys
  # This is just so we can SSH into the machine where we're installing the ISO and
  # deploy our actual configuration
  users.users.root = {
    password = "password";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
    ];
  };
}
