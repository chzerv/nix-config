{
  programs.distrobox = {
    enable = true;
    enableSystemdUnit = true;
    containers = {
      archlinux = {
        image = "archlinux:latest";
        entry = true;
        additional_packages = "gcc gcc-libs podman git base base-devel python3 make fzf ripgrep fd";
      };
    };
  };
}
