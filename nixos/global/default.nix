# Configuration used on EVERY host.
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./network.nix
    ./nix-ld.nix
    ./nix.nix
    ./performance.nix
    ./sops.nix
    ./udev-rules.nix
  ];
}
