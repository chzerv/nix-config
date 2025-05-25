# Packages that should be installed only on desktop systems
{
  pkgs,
  lib,
  username,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    libnotify
    inotify-info
    ntfs3g
    ffmpeg-full

    # https://discourse.nixos.org/t/tips-tricks-for-nixos-desktop/28488/2
    (let
      base = pkgs.appimageTools.defaultFhsEnvArgs;
    in
      pkgs.buildFHSEnv (base
        // {
          name = "fhs";
          targetPkgs = pkgs: (base.targetPkgs pkgs) ++ [pkgs.pkg-config];
          profile = "export FHS=1";
          runScript = "fish";
          extraOutputsToInstall = ["dev"];
        }))
  ];

  programs.adb.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.${username}.extraGroups = lib.optionals config.programs.wireshark.enable ["wireshark"];
}
