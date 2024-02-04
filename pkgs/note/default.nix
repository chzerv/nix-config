{
  fetchFromGitHub,
  buildGoModule,
  pkgs,
  ...
}:
buildGoModule {
  pname = "note";
  version = "v0.1.0";
  src = ./.;

  vendorHash = "sha256-Aw/A2eZ30qcxiyVwu8e/Di6rzjaPtKtMt6UgeEKq/Uk=";
}
