{
  config,
  pkgs,
  lib,
  ...
}: let
  opts = config.features.nix;
in {
  config = lib.mkIf opts.gaming {
    programs = {
      steam.enable = true;
      gamemode = {
        enable = true;
        settings = {
          general = {
            softrealtime = "on";
            renice = 10;
          };

          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
            amd_performance_level = "high";
          };

          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          };
        };
      };
    };

    environment.systemPackages = with pkgs; [
      # Make wine available to Lutris, but don't polute the entire system
      (lutris.override {
        extraPkgs = _pkgs: [
          wineWowPackages.staging
          wineWowPackages.waylandFull
          winetricks
        ];
      })
    ];
  };
}
