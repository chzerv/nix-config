{
  lib,
  type,
  ...
}: {
  imports =
    [
      ./global-pkgs.nix
    ]
    # If the host is not a server, setup a graphical environment and other programs
    ++ lib.optionals (type == "desktop" || type == "laptop") [./desktop-pkgs.nix]
    ++ lib.optionals (type == "server") [./server-pkgs.nix];
}
