{inputs, ...}:
# The system is running on nixpkgs-unstable, but we might want to install
# packages from nixpkgs-stable. This overlays makes it so stable packages
# are accessible via `pkgs.stable`.
(final: prev: {
  stable = import inputs.nixpkgs-stable {
    inherit (final) system;
    config.allowUnfree = true;
  };
})
