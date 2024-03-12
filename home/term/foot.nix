{
  config,
  type,
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

        font = "Monaspace Argon:size=11";
        font-bold = "Monaspace Argon:size=11:style=Bold";
        font-italic = "Monaspace Argon:size=11:style=Italic";
        font-bold-italic = "Monaspace Argon:size=11:style=Bold Italic";
      };

      key-bindings = {
        scrollback-up-page = "Control+Shift+Page_Up";
        scrollback-up-line = "Control+Shift+k";
        scrollback-down-page = "Control+Shift+Page_Down";
        scrollback-down-line = "Control+Shift+j";

        clipboard-copy = "Control+Shift+c XF86Copy";
        clipboard-paste = "Control+Shift+v XF86Paste";
        primary-paste = "Shift+Insert";
      };

      mouse = {
        hide-when-typing = "yes";
      };

      csd = {
        preferred = "none";
      };
    };
  };

  xdg.configFile."foot/catppuccin-macchiato.ini" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/foot/main/catppuccin-macchiato.ini";
      sha256 = "0p0zcbd7422956618kwznx91bnz1bagprc0045a5gd6y30w7z38d";
    };
  };
}
