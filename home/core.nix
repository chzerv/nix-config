{
  lib,
  username,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  # Do these for every host!
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    # Add ~/.local/bin to the $PATH
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
  };

  # Disable home-manager news
  news.display = "silent";

  nixpkgs = {
    overlays = [
      inputs.neovim-nightly.overlay
      outputs.overlays.nixpkgs-stable
      outputs.overlays.alacritty
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
