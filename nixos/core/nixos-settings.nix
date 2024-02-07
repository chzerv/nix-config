{
  outputs,
  config,
  ...
} @ args: {
  sops.secrets."attic/netrc" = {};

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
        "https://cache.nixos.org?priority=40" # default nixpkgs cache
        "https://attic.chrizer.xyz/system?priority=41"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "system:GBYio4lxWDHAX11RDHFd3CGOWy3FJ+F5bmIRwtv2Qdg="
      ];

      netrc-file = config.sops.secrets."attic/netrc".path;
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

  # https://github.com/Mic92/nix-ld
  # programs.nix-ld.enable = true;
}
