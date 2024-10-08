{
  config,
  lib,
  ...
}: let
  opts = config.custom.nix;
in {
  services.openssh = {
    enable = opts.services.openssh;
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
}
