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
    [./desktop];
}
