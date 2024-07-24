{
  lib,
  type,
  ...
}: {
  imports =
    [
      ./options.nix

      ./core
      ./virt
      ./services
      ./security
      ./packages.nix
    ]
    # If the host is not a server, setup a graphical environment and other programs
    ++ lib.optionals (type != "server")
    [./desktop]
    # If the host is a WSL instance, setup WSL specifics
    ++ lib.optionals (type == "wsl")
    [./wsl];
}
