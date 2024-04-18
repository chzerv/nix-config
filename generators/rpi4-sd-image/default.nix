{
  inputs,
  modulesPath,
  ...
}: let
  system = "aarch64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  imports = [
    (modulesPath + "/installer/sd-card/sd-image-aarch64-installer.nix")
  ];

  system.stateVersion = "23.11";

  environment.systemPackages = with pkgs; [
    vim
    rsync
  ];

  # This is just temporary, so we can access the RPi without needing a monitor.
  # It will be properly configured later.
  services.openssh.enable = true;

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

  # Static IP
  networking = {
    usePredictableInterfaceNames = false;
    interfaces.eth0.ip4 = [
      {
        address = "192.168.1.20";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.1.1";
    nameservers = ["1.1.1.1"];
  };
}
