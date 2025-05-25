{
  lib,
  type,
  ...
}: {
  imports =
    [
      ./cli
      ./services
      ./neovim.nix
    ]
    ++ lib.optionals (type == "desktop" || type == "laptop") [./desktop ./terminals];
}
