{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.features.hm = {
    services = {
      syncthing = mkEnableOption "Enable syncthing as a user service";
    };

    desktop = {
      hidpi = mkEnableOption "Apply tweaks for HiDPI monitors";
    };
  };
}
