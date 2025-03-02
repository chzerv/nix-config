{
  inputs,
  outputs,
  ...
}: {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    optimise = {
      automatic = true;
      dates = ["daily"];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 15d";
    };
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

  # https://github.com/NixOS/nixpkgs/pull/338181
  systemd.services.nix-daemon = {
    environment.TMPDIR = "/var/tmp";
  };
}
