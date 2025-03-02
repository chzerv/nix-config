# Configuration used on EVERY host.
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./network.nix
    ./nix-ld.nix
    ./nix.nix
    ./sops.nix
    ./memory-management.nix
  ];
}
