{
  imports = [
    ./options.nix
    ./nix.nix

    ./packages.nix
    ./term
    ./editors
    ./services
    ./shell

    ./desktop/gnome.nix
    ./desktop/sway
  ];
}
