{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    # Enables a basic set of fonts providing several font styles and families and reasonable coverage of Unicode
    enableDefaultPackages = lib.mkForce false;
    fontDir.enable = true; # Store fonts in /run/current-system/sw/share/X11/fonts
    packages = with pkgs; [
      fira
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      ubuntu_font_family
      (nerdfonts.override {fonts = ["FiraCode" "SourceCodePro" "JetBrainsMono"];})
    ];

    fontconfig = {
      defaultFonts = lib.mkDefault {
        monospace = ["FiraCode Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
