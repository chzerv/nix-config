{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    services.mako = {
      enable = true;
      settings = {
        width = "350";
        height = "150";
        padding = "10";
        margin = "5";
        border-size = "1";
        border-radius = "5";
        border-color = "#45475a";
        default-timeout = "4000";
        actions = "true";
        icons = "true";
        markup = "true";
        background-color = "#1f2329";
        text-color = "#fafbfc";
      };
    };
  };
}
