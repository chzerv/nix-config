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
        include = "~/.config/foot/gruvbox-dark.ini";
        term = "xterm-256color";

        font = "JetBrainsMono Nerd Font Mono:size=11";
        font-bold = "JetBrainsMono Nerd Font Mono:size=11:style=Bold";
        font-italic = "JetBrainsMono Nerd Font Mono:size=11:style=Italic";
        font-bold-italic = "JetBrainsMono Nerd Font Mono:size=11:style=Bold Italic";
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
        alpha = 0.98;
      };

      text-bindings = {
        "tmux-sm\\x0a" = "Control+Shift+a";
        "tmux-sessionizer\\x0a" = "Control+Shift+f";
      };
    };
  };

  xdg.configFile."foot/gruvbox-dark.ini" = {
    source = builtins.fetchurl {
      url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/gruvbox-dark";
      sha256 = "sha256:1qmxb6z4vd2ji6sw7abr47cn1yxrc09na784mz6nng6400pfgfxr";
    };
  };

  # Temporary fix for huge cursors in HiDPI screens
  # https://codeberg.org/dnkl/foot/issues/1426
  systemd.user.services.foot = lib.mkIf (opts.desktop.hidpi) {
    Service.Environment = "XCURSOR_SIZE=12";
  };
}
