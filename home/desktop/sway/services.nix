{
  services = {
    clipman.enable = true;

    gnome-keyring = {
      enable = true;
      components = ["secrets"];
    };

    udiskie = {
      enable = true;
    };
  };
}
