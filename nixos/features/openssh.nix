{
  config,
  lib,
  ...
}: let
  cfg = config.system.openssh;
in {
  options.system.openssh = {
    enable = lib.mkEnableOption "Enable and configure OpenSSH";
  };

  config = {
    services.openssh = {
      enable = cfg.enable;
      ports = [42749];
      openFirewall = true;
      settings = {
        PermitRootLogin = lib.mkDefault "no";
        UseDns = false;
        X11Forwarding = false;
        PasswordAuthentication = lib.mkForce false;
        KbdInteractiveAuthentication = false;
      };
    };
  };
}
