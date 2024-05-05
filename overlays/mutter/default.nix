{inputs, ...}:
# GNOME 46: triple-buffering-v4-46
# https://nixos.wiki/wiki/GNOME#Dynamic_triple_buffering
(final: prev: {
  gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
    mutter = gnomePrev.mutter.overrideAttrs (old: {
      src = prev.fetchgit {
        url = "https://gitlab.gnome.org/vanvugt/mutter.git";
        rev = "663f19bc02c1b4e3d1a67b4ad72d644f9b9d6970";
        sha256 = "sha256-I1s4yz5JEWJY65g+dgprchwZuPGP9djgYXrMMxDQGrs=";
      };
    });
  });
})
