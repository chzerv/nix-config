{inputs, ...}: {
  # The system is running on nixpkgs-unstable, but we might want to install
  # packages from nixpkgs-stable. This overlays makes it so stable packages
  # are accessible via `pkgs.stable`.
  nixpkgs-stable = final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  gnome-triple-buffering = final: prev: {
    gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
      mutter = gnomePrev.mutter.overrideAttrs (old: {
        src = prev.fetchgit {
          url = "https://gitlab.gnome.org/vanvugt/mutter.git";
          # GNOME 45: triple-buffering-v4-45
          rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
          sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
        };
      });
    });
  };
}
