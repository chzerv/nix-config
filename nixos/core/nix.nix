{pkgs, ...} @ args: {
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

      substituters = [
        "https://chzerv.cachix.org?priority=41"
      ];
      trusted-public-keys = [
        "chzerv.cachix.org-1:coEmdQVVtyYQhqz/iCwREK+sfkw2eWo5ETHwObtbQmg="
      ];
    };
  };

  # Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = import ../../overlays args;
  };

  # Disable unneeded docs
  documentation = {
    enable = true;
    nixos.enable = false;
    man.enable = true;
    info.enable = false;
    doc.enable = false;
  };

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  # https://github.com/NixOS/nixpkgs/pull/338181
  systemd.services.nix-daemon = {
    environment.TMPDIR = "/var/tmp";
  };
}
