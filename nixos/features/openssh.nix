{
  config,
  lib,
  ...
}: let
  opts = config.features.nix;
in {
  services.openssh = {
    enable = opts.openssh;
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
