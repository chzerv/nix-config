{outputs, ...}: {
  nix = {
    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      # Keep the last 5 generations
      options = "--delete-older-than +5";
    };

    # Automatically optimise the store
    optimise.automatic = true;

    settings = {
      auto-optimise-store = true;
      # Enable flakes
      experimental-features = ["nix-command" "flakes"];

      # Avoid garbage collection when using nix-direnv
      keep-outputs = true;
      keep-derivations = true;
    };
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      outputs.overlays.nixpkgs-stable
      outputs.overlays.gnome-triple-buffering
    ];
  };

  # Disable unneeded docs
  documentation = {
    enable = true;
    nixos.enable = false;
    man.enable = true;
    info.enable = false;
    doc.enable = false;
  };

  # https://github.com/Mic92/nix-ld
  # programs.nix-ld.enable = true;
}
