{
  lib,
  type,
  ...
}: {
  imports =
    [
      ./options.nix
      ./core
      ./features
      ./packages
    ]
    # If the host is not a server, setup a graphical environment and other programs
    ++ lib.optionals (type == "desktop" || type == "laptop") [./desktop]
    ++ lib.optionals (type == "wsl") [./wsl.nix];
}
