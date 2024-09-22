{config, ...}: let
  opts = config.local.hm;
in {
  services.mako = {
    enable = opts.desktop.sway;
    defaultTimeout = 4000;
    actions = true;
    icons = true;
    markup = true;

    width = 300;
    height = 150;
    padding = "10";
    margin = "5";
    borderSize = 1;
    backgroundColor = "#3c3836";
    borderColor = "#7daea3";
    textColor = "#d4be98";

    extraConfig = ''
      [urgency=high]
      border-color=#ea6962
      ignore-timeout=1
    '';
  };
}
