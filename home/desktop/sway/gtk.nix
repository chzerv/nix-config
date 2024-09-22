{pkgs, ...}: {
  gtk = {
    enable = true;

    font = {
      package = pkgs.noto-fonts;
      name = "NotoSans";
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "Adwaita";
    };

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
