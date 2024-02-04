{
  config,
  type,
  ...
}: let
  opts = config.local.hm;
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  programs.alacritty = {
    enable = opts.term.alacritty && type != "server";
  };

  xdg.configFile."alacritty/alacritty.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${configDir}/alacritty/alacritty.toml";
  };

  xdg.configFile."alacritty/catppuccin-mocha.toml" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-mocha.toml";
      sha256 = "061yalrzpqivr67k2f8hsqixr77srgd8y47xvhp5vg0sjmh5lrcy";
    };
  };

  xdg.configFile."alacritty/catppuccin-macchiato.toml" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-macchiato.toml";
      sha256 = "sha256:1iq187vg64h4rd15b8fv210liqkbzkh8sw04ykq0hgpx20w3qilv";
    };
  };
}
