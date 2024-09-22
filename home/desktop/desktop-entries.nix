{
  type,
  lib,
  ...
}: {
  xdg.desktopEntries = lib.optionals (type != "server" && type != "wsl") {
    obsidian = {
      name = "obsidian";
      exec = "obsidian --ozone-platform=wayland --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations %U";
    };
  };
}
