{
  lib,
  username,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./features
  ];

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    # Add ~/.local/bin to the $PATH
    sessionPath = ["$HOME/.local/bin"];
  };

  # Disable home-manager news
  news.display = "silent";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = builtins.attrValues outputs.overlays;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  # https://sr.ht/~rycee/sd-switch/
  systemd.user.startServices = "sd-switch";

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
