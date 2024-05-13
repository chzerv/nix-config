# Home related options that can be enabled/disabled in the top-level configuration and imported modules can react to them. For example, if options.editor.vscode is enabled, enable and configure VSCode.
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.local.hm = {
    editor = {
      neovim = mkEnableOption "Setup Neovim";
      vscode = mkEnableOption "Setup VSCode";
    };

    term = {
      kitty = mkEnableOption "Setup kitty";
      wezterm = mkEnableOption "Setup wezterm";
      foot = mkEnableOption "Setup foot";
      default = mkOption {
        type = types.nullOr (types.enum ["kitty" "wezterm" "foot"]);
        description = "Default terminal to use";
        default = "foot";
      };
    };

    services = {
      syncthing = mkEnableOption "Enable syncthing as a user service";
    };

    desktop = {
      gnome = mkEnableOption "Apply GNOME user tweaks";
      hidpi = mkEnableOption "Apply tweaks for HiDPI monitors";
    };
  };
}
