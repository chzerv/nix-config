{pkgs, ...}: {
  # Peripherals
  environment.systemPackages = with pkgs; [
    qmk
    solaar
    logitech-udev-rules
  ];

  hardware = {
    keyboard.qmk.enable = true;
  };
}
