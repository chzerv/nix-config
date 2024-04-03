{
  config,
  type,
  ...
}: let
  opts = config.local.hm;
in {
  programs.wezterm = {
    enable = opts.term.wezterm && type != "server";
    enableZshIntegration = false;
    enableBashIntegration = true;
    extraConfig = ''
        return {
            audible_bell = "Disabled",
            check_for_updates = false,

            color_scheme = "Catppuccin Macchiato",
            inactive_pane_hsb = {
                hue = 1.0,
                saturation = 1.0,
                brightness = 1.0,
            },
            window_decorations = "RESIZE",
            window_background_opacity = 0.95,

            font = wezterm.font_with_fallback {
              "Monaspace Argon",
              "Jetbrains Mono",
            },
            font_size = 11.0,

            -- Disable ligatures
            -- harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

            launch_menu = {},
            hide_tab_bar_if_only_one_tab = true,

            -- Tmux will be used inside wezterm, so disable all the keybinds except some
            -- very basic ones.
            disable_default_key_bindings = true,

            keys = {
                { key = 'v', mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
                { key = 'c', mods = "SHIFT|CTRL", action = wezterm.action.CopyTo("Clipboard") },
                { key = 't', mods = "SHIFT|CTRL", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
                { key = ' ', mods = "SHIFT|CTRL", action = wezterm.action.QuickSelect },
                { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
                { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
                { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
                { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
                { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },

                -- Custom scripts
                { key = 'a', mods = "SHIFT|CTRL", action = wezterm.action.SendString("tmux-sm\n") },
                { key = 'f', mods = "SHIFT|CTRL", action = wezterm.action.SendString("tmux-sessionizer\n") },

            }
      }
    '';
  };
}
