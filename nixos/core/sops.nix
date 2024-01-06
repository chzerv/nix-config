{
  username,
  hostname,
  ...
}: {
  sops = {
    defaultSopsFile = ../../hosts/${hostname}/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  };
}
