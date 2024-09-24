{lib, ...}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.custom.hm = {
    editor = {
      neovim = mkEnableOption "Setup Neovim";
      vscode = mkEnableOption "Setup VSCode";
    };

    term = {
      alacritty = mkEnableOption "Setup alacritty";
      default = mkOption {
        type = types.nullOr (types.enum ["alacritty"]);
        description = "Default terminal to use";
        default = "alacritty";
      };
    };

    services = {
      syncthing = mkEnableOption "Enable syncthing as a user service";
    };

    desktop = {
      gnome = mkEnableOption "Apply GNOME user tweaks";
      sway = mkEnableOption "Setup Sway WM";
      hidpi = mkEnableOption "Apply tweaks for HiDPI monitors";
    };
  };
}
