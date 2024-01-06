{pkgs ? (import <nixpkgs>) {}}: {
  default = pkgs.mkShell {
    name = "dotfiles";
    NIX_CONFIG = "experimental-features = nix-command flakes";

    nativeBuildInputs = with pkgs; [
      nix
      git
      sops
      ssh-to-age
      age
      nil
      # home-manager
      # vim
    ];
  };
}
