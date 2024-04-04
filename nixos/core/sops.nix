{
  lib,
  username,
  hostname,
  ...
}: {
  sops = {
    defaultSopsFile = ../../hosts/${hostname}/secrets.yaml;
    defaultSopsFormat = "yaml";
    # Allow overriding `age.keyFile`
    # This is especially useful when we are deploying to a new machine and we want to use
    # it's SSH keys as AGE keys
    age.keyFile = lib.mkDefault /etc/sops/age/keys.txt;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  };
}
