{
  config,
  type,
  ...
}: let
  opts = config.local.hm;
in {
  programs.kitty = {
    enable = opts.term.kitty && type != "server";
    shellIntegration.enableFishIntegration = false;
    font = {
      name = "Monaspace Argon";
      size = 11;
    };
    themeFile = "Catppuccin-Macchiato";
    settings = {
      # Performance tuning
      sync_to_monitor = "no";
      repaint_delay = "10";
      input_delay = "2";

      hide_window_decorations = "yes";
      background_opacity = "0.95";

      confirm_os_window_close = "0";

      shell_integration = "enabled";
      paste_actions = "quote-urls-at-prompt";
      scrollback_lines = "10000";

      # "leader" key
      kitty_mod = "ctrl+shift";
    };
    keybindings = {
      "kitty_mod+t" = "launch --cwd=current --type=tab";
      "kitty_mod+f" = "launch --type overlay-main tmux-sessionizer";
      "kitty_mod+a" = "launch --type overlay-main tmux-sm";
    };
    extraConfig = ''
      # symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AA,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF,U+F0001-U+F1AF0 Symbols Nerd Font Mono
    '';
  };
}
