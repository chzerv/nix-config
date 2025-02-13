{
  lib,
  type,
  ...
}: {
  imports =
    [
      ./cli
      ./neovim
      ./services
    ]
    ++ lib.optionals (type == "desktop" || type == "laptop") [./desktop ./terminals];
}
