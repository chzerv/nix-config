{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_status"
        "$kubernetes"
        "$rust"
        "$nodejs"
        "$lua"
        "$golang"
        "$python"
        "$c"
        "$terraform"
        "$nix_shell"
        "$line_break"
        "$character"
        "$jobs"
        ""
      ];

      right_format = lib.concatStrings [
        "$cmd_duration"
      ];

      add_newline = true;

      scan_timeout = 3;

      character = {
        error_symbol = "[󰊠](bold red)";
        success_symbol = "[󰊠](bold green)";
        vicmd_symbol = "[󰊠](bold yellow)";
        format = "$symbol [|](bold bright-black) ";
      };

      kubernetes = {
        symbol = "☸ ";
        style = "blue";
        format = "[$symbol$namespace \\($context\\)]($style) in ";
        disabled = false;
      };

      git_commit = {commit_hash_length = 7;};

      lua.format = "via [ $version](bold blue) ";

      python.symbol = "[](blue) ";

      jobs = {
        style = "red";
        symbol = "";
        format = "[$symbol $number]($style)";
      };

      hostname = {
        ssh_only = true;
        format = "[$hostname](bold blue) ";
        disabled = false;
      };

      nix_shell = {
        symbol = "❄️ ";
      };

      memory_usage.disabled = true;

      package.disabled = true;
    };
  };
}
