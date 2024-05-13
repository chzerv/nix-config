{
  config,
  type,
  lib,
  ...
}: let
  opts = config.local.hm;
in {
  programs.foot = {
    enable = opts.term.foot && type != "server";
    server.enable = true;
    settings = {
      main = {
        include = "~/.config/foot/catppuccin-macchiato.ini";
        term = "xterm-256color";

        font = "Hasklug Nerd Font Mono:size=11";
        font-bold = "Hasklug Nerd Font Mono:size=11:style=Bold";
        font-italic = "Hasklug Nerd Font Mono:size=11:style=Italic";
        font-bold-italic = "Hasklug Nerd Font Mono:size=11:style=Bold Italic";
      };

      key-bindings = {
        scrollback-up-page = "Control+Shift+Page_Up";
        scrollback-down-page = "Control+Shift+Page_Down";

        scrollback-up-line = "Control+Shift+k";
        scrollback-down-line = "Control+Shift+j";

        clipboard-copy = "Control+Shift+c XF86Copy";
        clipboard-paste = "Control+Shift+v XF86Paste";
        primary-paste = "Shift+Insert";
      };

      scrollback = {
        lines = 5000;
        multiplier = 3.0;
      };

      mouse = {
        hide-when-typing = "yes";
      };

      csd = {
        preferred = "none";
      };

      colors = {
        # Opacity
        alpha = 0.95;
      };

      text-bindings = {
        "tmux-sm\\x0a" = "Control+Shift+a";
        "tmux-sessionizer\\x0a" = "Control+Shift+f";
      };
    };
  };

  xdg.configFile."foot/catppuccin-macchiato.ini" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/foot/main/catppuccin-macchiato.ini";
      sha256 = "0p0zcbd7422956618kwznx91bnz1bagprc0045a5gd6y30w7z38d";
    };
  };

  # Temporary fix for huge cursors in HiDPI screens
  # https://codeberg.org/dnkl/foot/issues/1426
  systemd.user.services.foot = lib.mkIf (opts.desktop.hidpi) {
    Service.Environment = "XCURSOR_SIZE=12";
  };
}
