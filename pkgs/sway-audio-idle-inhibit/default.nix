{
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
stdenv.mkDerivation (finalAttrs: {
  name = "SwayAudioIdleInhibit";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "ErikReider";
    repo = "SwayAudioIdleInhibit";
    rev = "main";
    hash = "sha256-MKzyF5xY0uJ/UWewr8VFrK0y7ekvcWpMv/u9CHG14gs=";
  };

  nativeBuildInputs = with pkgs; [meson ninja cmake wayland wayland-protocols pkg-config];
  buildInputs = with pkgs; [libpulseaudio];
})
