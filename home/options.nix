# Home related options that can be enabled/disabled in the top-level configuration and imported modules can react to them. For example, if options.editor.vscode is enabled, enable and configure VSCode.
{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  options.local.hm = {
    type = {
      workstation = mkEnableOption "Setup a workstation machine";
      server = mkEnableOption "Setup a headless server";
    };

    desktop = {
      gnome = mkEnableOption "Apply per-user GNOME configurations";
    };

    editor = {
      neovim = mkEnableOption "Setup Neovim";
      vscode = mkEnableOption "Setup VSCode";
    };

    term = {
      kitty = mkEnableOption "Setup kitty";
      alacritty = mkEnableOption "Setup alacritty";
      default = mkOption {
        type = types.nullOr (types.enum ["kitty" "alacritty"]);
        description = "Default terminal to use";
        default = "alacritty";
      };
    };

    services = {
      syncthing = mkEnableOption "Enable syncthing as a user service";
    };
  };

  config = {
    assertions = [
      {
        assertion = with config.local.hm.type;
          (workstation || server) && !(workstation && server);
        message = "The system can either be a workstation or a server!";
      }
      {
        assertion = with config.local.hm; !(desktop.gnome && type.server);
        message = "Can't setup up a DE/WM on a headless server!";
      }
    ];
  };
}
