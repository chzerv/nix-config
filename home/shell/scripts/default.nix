{pkgs, ...}: {
  home.packages = [
    (pkgs.stdenv.mkDerivation {
      name = "scripts";
      version = "unstable";
      src = ./bin;
      installPhase = ''
        mkdir -p $out/bin
        cp * $out/bin
        ln -sf $out/bin/open $out/bin/xdg-open
      '';
    })
  ];
}
