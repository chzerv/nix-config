<div align="center">
<h1>
  <img width="96" src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake.svg"></img> <br>
  NixOS & Home Manager Configuration
<p></p>
  <img src="https://builtwithnix.org/badge.svg">
</h1>
</div>

# Disclaimer for the visitor

I've known about Nix for a while, but only recently dove into it, mostly for managing development environments. I found the process so exciting that I decided to also use it for managing my dotfiles and entire system configuration. Since I'm still a beginner, the code might not be of the best quality or follow best practices and is always subject to change.

> [!Warning]
> These are **_my_** dotfiles. They are always evolving and are specifically made for my needs. They are **NOT** guaranteed to work for you! With that in mind, feel free to take a look around and pick anything you like!

# Features

- **Flake based**
- **Secrets Management** via [sops-nix](https://github.com/Mic92/sops-nix) for connecting to SMB shares and more
- [home-manager](https://github.com/nix-community/home-manager) is installed using the "standalone" method. This way, system and home configurations are separated
- Per-host customization via [options](https://nixos.wiki/wiki/Extend_NixOS)
- **GNOME** as the Desktop Environment
- `neovim`, `tmux` and `alacritty` configurations managed via their own config files, but still "deployed" via `home-manager`
- Automatically loaded **overlays** thanks to the [NixOS & Flakes](https://nixos-and-flakes.thiscute.world/nixpkgs/overlays) book
  - Super useful for updating or downgrading packages, adding patches and more
- Proxmox LXC templates utilizing [nixos-generators](https://github.com/nix-community/nixos-generators)

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
├── images          # Images built using nixos-generators for use in Proxmox, VMWare etc
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

# Secret Management

Secret management is handled via the awesome [sops-nix](https://github.com/Mic92/sops-nix) project.

## Generate an AGE key using your SSH private key

```shell
mkdir -p ~/.config/sops/age

ssh-to-age --private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt

# Generate the PUBLIC AGE key
age-keygen -y ~/.config/sops/age/keys.txt
```

## `.sops.yaml`

Add the public AGE key to the `keys` section in `.sops.yaml` and allow these keys to decrypt your secrets. For example:

```yaml
keys:
  - &new_host <AGE_PUBLIC_KEY>
creation_rules:
  - path_regex: secrets.yaml$
    key_groups:
      - age:
          - *new_host
```

## Create the secrets

> [!Note]
> I find it very useful to have per-host secrets stored in `hosts/${hostname}/secrets.yaml`

```shell
sops hosts/jupiter/secrets.yaml
```
