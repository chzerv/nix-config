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
      jetbrains-mono
      monaspace

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      material-symbols

      liberation_ttf
      dejavu_fonts
      ubuntu_font_family

      (google-fonts.override {fonts = ["Inter"];})
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "NerdFontsSymbolsOnly" "Monaspace"];})
    ];

    fontconfig = {
      defaultFonts = lib.mkDefault {
        monospace = ["JetBrains Mono"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
