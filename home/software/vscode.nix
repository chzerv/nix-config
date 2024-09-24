{
  config,
  inputs,
  system,
  lib,
  ...
}: let
  opts = config.custom.hm;
  extensions = inputs.nix-vscode-extensions.extensions.${system};
in {
  config = lib.mkIf opts.editor.vscode {
    programs.vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with extensions; [
        vscode-marketplace.beardedbear.beardedicons
        vscode-marketplace.beardedbear.beardedtheme
        vscode-marketplace.redhat.ansible
        vscode-marketplace.redhat.vscode-yaml
        vscode-marketplace.ms-azuretools.vscode-docker
        vscode-marketplace.hashicorp.hcl
        vscode-marketplace.hashicorp.terraform
        vscode-marketplace.esbenp.prettier-vscode
        vscode-marketplace.ms-vscode-remote.remote-ssh
        vscode-marketplace.vscodevim.vim
        vscode-marketplace.jnoortheen.nix-ide
        vscode-marketplace.rust-lang.rust-analyzer
        vscode-marketplace.ms-python.python
      ];
      userSettings = {
        # Disable telemetry
        "telemetry.telemetryLevel" = "off";

        # Appearance
        "window.titleBarStyle" = "custom";
        "window.commandCenter" = true;

        # Editor
        "editor.accessibilitySupport" = "off";
        "editor.minimap.enabled" = false;
        "editor.lineNumbers" = "off";
        "breadcrumbs.enabled" = false;
        "editor.colorDecorators" = true;
        "editor.dragAndDrop" = false;
        "editor.folding" = false;
        "editor.showFoldingControls" = "mouseover";
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "editor.glyphMargin" = false;
        "editor.renderWhitespace" = "selection";
        "editor.renderLineHighlight" = "none";
        "editor.occurrencesHighlight" = true;
        "editor.overviewRulerBorder" = false;
        "editor.bracketPairColorization.enabled" = true;
        "editor.scrollBeyondLastLine" = true;
        "editor.cursorSurroundingLines" = 3;
        "editor.useTabStops" = true;
        "editor.formatOnPaste" = false;
        "editor.wordWrap" = "on";
        "editor.wordWrapColumn" = 90;
        "editor.hover.enabled" = true;
        "editor.autoClosingBrackets" = "languageDefined";
        "editor.quickSuggestions" = {
          "other" = "on";
          "comments" = "off";
          "strings" = "off";
        };
        "editor.multiCursorModifier" = "ctrlCmd";
        "editor.acceptSuggestionOnEnter" = "off";

        # Terminal
        "terminal.integrated.fontFamily" = "FiraCode Nerd Font";

        # Explorer
        "explorer.confirmDelete" = false;
        "explorer.decorations.badges" = false;
        "explorer.compactFolders" = false;
        "explorer.openEditors.visible" = 1;

        # Files
        "files.exclude" = {
          "**/.DS_Store" = true;
          "**/.direnv" = true;
          "**/node_modules" = true;
          "**/bower_components" = true;
          "**/__pycache__" = true;
          "**/.cache" = true;
          "**/.idea" = true;
          "**/.pytest_cache" = true;
          "**/.mypy_cache" = true;
          "**/.venv" = true;
          "**/.coverage" = true;
          "**/*.py[co]" = true;
          "**/htmlcoverage" = true;
          "**/docs/build" = true;
        };

        "files.associations" = {
          "**/roles/**/tasks/*.yml" = "ansible";
          "**/roles/**/vars/*.yml" = "ansible";
          "**/roles/**/defaults/*.yml" = "ansible";
          "**/handlers/**/defaults/*.yml" = "ansible";
          "**/playbooks/**/*.yml" = "ansible";
        };

        "workbench.editor.labelFormat" = "medium";
        "workbench.statusBar.visible" = true;
        "workbench.tips.enabled" = false;
        "workbench.editor.showIcons" = true;
        "workbench.editor.showTabs" = "multiple";
        "workbench.editor.decorations.badges" = false;
        "workbench.editor.decorations.colors" = false;
        "workbench.colorTheme" = "Bearded Theme Monokai Metallian";
        "workbench.iconTheme" = "bearded-icons";

        # Extensions
        "extensions.ignoreRecommendations" = true;
        "redhat.telemetry.enabled" = false;
        "vim.leader" = "space";
        "vim.easymotion" = false;
        "vim.incsearch" = true;
        "vim.surround" = true;
        "vim.useSystemClipboard" = true;
        "vim.useCtrlKeys" = true;
        "vim.hlsearch" = true;
        "extensions.experimental.affinity" = {
          "vscodevim.vim" = 1;
        };
        "vim.insertModeKeyBindings" = [
          {
            "before" = ["j" "j"];
            "after" = ["<Esc>"];
          }
        ];
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            "before" = ["<leader>" "f"];
            "commands" = ["workbench.action.quickOpen"];
          }
          {
            "before" = ["<leader>" "c" "f"];
            "commands" = ["editor.action.formatDocument"];
          }
          {
            "before" = ["<Esc><Esc>"];
            "commands" = [":nohl"];
          }
        ];
        "vim.visualModeKeyBindings" = [
          {
            "before" = [">"];
            "commands" = ["editor.action.indentLines"];
          }
          {
            "before" = ["<"];
            "commands" = ["editor.action.outdentLines"];
          }
        ];
        # Needed for the VIM extension if Esc and Caps are swapped
        "keyboard.dispatch" = "keyCode";

        # Language specific settings
        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        "[ansible]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

        "[yaml]" = {
          "editor.defaultFormatter" = "redhat.vscode-yaml";
        };

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting.command" = "nixpkgs fmt";
          };
        };
      };

      keybindings = [
        {
          "key" = "ctrl+p";
          "command" = "workbench.action.quickOpen";
        }
        {
          "key" = "alt+h";
          "command" = "workbench.action.focusLeftGroup";
          "when" = "editorTextFocus && vim.active && vim.mode != 'Insert'";
        }
        {
          "key" = "alt+l";
          "command" = "workbench.action.focusRightGroup";
          "when" = "editorTextFocus && vim.active && vim.mode != 'Insert'";
        }
        {
          "key" = "alt+k";
          "command" = "workbench.action.focusAboveGroup";
          "when" = "editorTextFocus && vim.active && vim.mode != 'Insert'";
        }
        {
          "key" = "alt+j";
          "command" = "workbench.action.focusBelowGroup";
          "when" = "editorTextFocus && vim.active && vim.mode != 'Insert'";
        }
        {
          "key" = "ctrl+w ctrl+w";
          "command" = "workbench.action.terminal.focus";
          "when" = "editorFocus";
        }
        {
          "key" = "ctrl+w ctrl+w";
          "command" = "workbench.action.focusActiveEditorGroup";
          "when" = "terminalFocus";
        }
        {
          "key" = "ctrl+w z";
          "command" = "workbench.action.toggleMaximizedPanel";
          "when" = "terminalFocus";
        }
      ];
    };
  };
}
