{
  config,
  username,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.desktop.mount_smb_share {
    sops.secrets = {
      smb_user = {};
      smb_password = {};
      smb_domain = {};
    };

    # Use a template to create a file containing the necessary credentials for connecting to my SMB share
    # See: https://github.com/Mic92/sops-nix#templates
    sops.templates."smb_secrets" = {
      content = ''
        username=${config.sops.placeholder.smb_user}
        domain=${config.sops.placeholder.smb_domain}
        password=${config.sops.placeholder.smb_password}
      '';
      path = "/etc/nixos/smb-secrets";
    };

    systemd.tmpfiles.rules = [
      "d /media 0755 ${username} users"
      "d /media/smb 0755 ${username} users"
    ];

    fileSystems."/media/smb" = {
      device = "//truenas/data";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };
  };
}
