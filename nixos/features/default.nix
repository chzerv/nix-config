# Import every file fould in the current directory.
# Credits: https://github.com/wimpysworld/nix-config/blob/main/nixos/_mixins/features/default.nix
{lib, ...}: let
  currentDir = ./.;
  isDirectory = name: type: type == "directory";
  directories = lib.filterAttrs isDirectory (builtins.readDir currentDir);
  importDirectory = name: import (currentDir + "/${name}");
in {
  imports = lib.mapAttrsToList (name: _: importDirectory name) directories;
}
