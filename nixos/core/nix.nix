{
  inputs,
  outputs,
  lib,
  ...
}: {
  nix = {
    settings = {
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Keep the last 5 generations
      options = "--delete-older-than +5";
    };

    # https://nixos-and-flakes.thiscute.world/best-practices/nix-path-and-flake-registry
    # https://lgug2z.com/articles/set-your-nix-path-to-your-system-flakes-nixpkgs-for-a-more-predictable-nix-shell/
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
    ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = builtins.attrValues outputs.overlays;
  };
}
