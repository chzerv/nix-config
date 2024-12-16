{
  config,
  pkgs,
  lib,
  ...
}: let
  opts = config.custom.hm;
  configDir = "${config.home.homeDirectory}/nix-config/config";
in {
  config = lib.mkIf opts.editor.neovim {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      package = pkgs.neovim;
      vimdiffAlias = true;
      extraPackages = with pkgs; [
        # Dependencies for packages to properly work
        luajit
        fswatch # According to :checkhealth, fswatch is preferred over libuv-watchdirs
        luajitPackages.luarocks
        luajitPackages.jsregexp
        gnumake
        gcc
        ripgrep
        fd
        fzf
        tree-sitter
        yarn
        nodePackages.npm
        nodejs

        ## Ansible
        # ansible-language-server # LSP
        # ansible-lint # Linter

        ## YAML
        nodePackages_latest.yaml-language-server # LSP
        yamllint # Linter
        yamlfmt # Formatter

        ## Terraform
        terraform-ls # LSP

        # Formatters & Linters
        nodePackages_latest.prettier

        ## Bash
        bash-language-server ## LSP
        shellcheck ## Static analysis
        shfmt

        ## Lua
        lua-language-server # LSP
        stylua # Formatter

        ## Python
        black
        pyright

        ## Rust
        rust-analyzer # LSP
        rustfmt # Formatter

        ## Golang
        gopls # go LSP
        delve # go debugger
        gotools # tools like goimports, godoc and more
        gofumpt # Formatter

        ## Nix
        nil # LSP
        alejandra # Formatter

        # TOML
        taplo

        # Emmet for HTML, HEEX, CSS etc
        emmet-language-server

        ## Other
        dockerfile-language-server-nodejs
        vscode-langservers-extracted # https://github.com/hrsh7th/vscode-langservers-extracted
        texlab # LaTeX LSP
        taplo # TOML LSP/formatter/linter
        hadolint

        # DAP
        lldb
        # Better debugging for Rust. Eventhough the extension is for VSCode, it still provides
        # the required binary
        vscode-extensions.vadimcn.vscode-lldb
      ];
    };

    # This is done so we can have a writable ~/.config/nvim. If a relative path is provided, it will get resolved to a nix-store path,
    # making ~/.config/nvim read-only. See:
    # https://www.reddit.com/r/NixOS/comments/104l0w9/how_to_get_lua_files_in_neovim_on_hm/
    xdg.configFile.nvim = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/nvim";
      recursive = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
