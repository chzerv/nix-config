<div align="center">
<h1>
  <img width="96" src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg"></img> <br>
  NixOS & Home Manager Configuration
<p></p>
  <img src="https://builtwithnix.org/badge.svg">
</h1>
</div>

# Disclaimer for the visitor

I have only recently dove into Nix, so the code might not be of the best quality or follow best practices and is always subject to change. Also note that these are **_my_** dotfiles. They are always evolving and are specifically made for my needs. They are **NOT** guaranteed to work for you! With that in mind, feel free to take a look around and pick anything you like!

# Features

- **Flake based**
- **Secrets Management** via [sops-nix](https://github.com/Mic92/sops-nix) for connecting to SMB shares and more
- [home-manager](https://github.com/nix-community/home-manager) is installed using the "standalone" method. This way, system and home configurations are separated
- Per-host customization via [options](https://nixos.wiki/wiki/Extend_NixOS)
- **GNOME** as the Desktop Environment
- `neovim`, `tmux` and `alacritty` configurations managed via their own config files, but still "deployed" via `home-manager`
- Automatically loaded **overlays** thanks to the [NixOS & Flakes](https://nixos-and-flakes.thiscute.world/nixpkgs/overlays) book
  - Super useful for updating or downgrading packages, adding patches and more
- Proxmox LXC and VM templates utilizing [nixos-generators](https://github.com/nix-community/nixos-generators)
- Self-hosted [attic](https://github.com/zhaofengli/attic) server for caching

# Structure

```shell
.
├── config          # Dotfiles for programs that I'm configuring using their own config files
├── home            # Home-manager configuration
│  ├── desktop      # Desktop related stuff, e.g., GNOME customizations
│  ├── editors      # Neovim and VSCode configurations
│  ├── services     # User services
│  ├── shell        # My shell setup
│  └── term         # Terminal emulator configurations
├── hosts           # Machine specific configurations like hardware, options (more later) etc.
├── generators      # Images built using nixos-generators for use in Proxmox, VMWare etc
├── lib             # Utility functions
├── nixos           # System-wide configurations
│  ├── core         # Applied to every host
│  ├── desktop      # Desktop related stuff
│  ├── hardware     # Hardware specific setup
│  ├── services     # System services
│  └── virt         # Setup virtualisation technologies e.g., docker, podman etc.
├── overlays        # Package overrides, patches and more
└── pkgs            # Custom packages
```

## Customization via options

[Options](https://nixos.wiki/wiki/Extend_NixOS) are used throughout the configuration to selectively apply configurations. These options are declared in [./nixos/options.nix](./nixos/options.nix) and [./home/options.nix](./home/options.nix) for system and home related options, respectively.

We can then customize a host by toggling these options in `./hosts/${hostname}/configuration.nix` and `./hosts/${hostname}/home.nix`.

# Proxmox images

In the `generators` subdirectory you'll find configurations for Proxmox LXCs and VM templates.

- [pve-lxc-docker](./generators/pve-lxc-docker) is an LXC template used to run a custom built API.
- [pve-vm-template](./generators/pve-vm-template) is a [VM template](https://pve.proxmox.com/wiki/VM_Templates_and_Clones) used to create NixOS VMs in Proxmox, with [cloud-init](https://cloud-init.io/) support for easy network configuration.
  - After creating a VM from the template, it can be configured as a normal host using `nixos-rebuild switch --flake .#host-name --target-host ${VM_HOST}`

To build these images, we are using [nixos-generators](https://github.com/nix-community/nixos-generators):

```shell
cd nix-config

# For the LXC template
nix build .#pve-lxc-docker

# For the VM template
nix build .#pve-vm-template
```

To use the LXC template, visit the Proxmox UI and upload the generated tarball wherever to your `CT Templates`.

For the VM template:

```shell
# Upload the generated VMA to the Proxmox server:
rsync --progress -a result/vzdump-qemu-nixos-template.vma.zst proxmox_server:

# Login to the Proxmox server
ssh proxmox_server

# Use `qmrestore` to create a new VM from the VMA
qmrestore vzdump-qemu-nixos-template.vma.zst <VM_ID> --unique true
```

> [!tip] Create a template from the VMA
> In the Proxmox UI, find the newly created VM -> Right Click -> Convert to template

# Secret Management

Secrets are managed via [sops-nix](https://github.com/Mic92/sops-nix).

## Generate an AGE key using your SSH private key

- When deploying to a local host:

  ```shell
  mkdir -p ~/.config/sops/age

  ssh-to-age --private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt

  # Generate the PUBLIC AGE key
  age-keygen -y ~/.config/sops/age/keys.txt
  ```

- When deploying to a remote machine:
  ```shell
  # Generate an AGE key using the new host's private SSH key
  ./setup-keys.sh root@10.0.0.10
  ```

Add the public AGE to `.sops.yaml`. For example:

```yaml
keys:
  - &new_host age1en................................
creation_rules:
  - path_regex: secrets.yaml$
    key_groups:
      - age:
          - *new_host
```

Finally, create the secrets.

> [!Note]
> I find it very useful to have per-host secrets stored in `hosts/${hostname}/secrets.yaml`. If there are lot of shared secrets between hosts, it might be a better idea to have just one "central" secrets file that all hosts can refer to.

```shell
sops hosts/new_host/secrets.yaml
```
