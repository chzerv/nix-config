{pkgs, ...}: {
  hardware.opengl = {
    enable = true;
    package = pkgs.mesa.drivers;
    package32 = pkgs.pkgsi686Linux.mesa.drivers;
    driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
  ];
}
