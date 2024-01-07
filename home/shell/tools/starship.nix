{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$kubernetes"
        "$directory"
        "$git_branch"
        "$git_status"
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
        ""
      ];
      right_format = lib.concatStrings [
        "$cmd_duration"
        "$jobs"
      ];
      add_newline = true;
      scan_timeout = 3;
      character = {
        error_symbol = "[󰊠](bold red)";
        success_symbol = "[󰊠](bold green)";
        vicmd_symbol = "[󰊠](bold yellow)";
        format = "$symbol [|](bold bright-black) ";
      };
      git_commit = {commit_hash_length = 7;};
      lua.format = "via [ $version](bold blue) ";
      python.symbol = "[](blue) ";
      jobs.symbol = "[](red)";
      hostname = {
        ssh_only = true;
        format = "[$hostname](bold blue) ";
        disabled = false;
      };
      memory_usage.disabled = true;
      package.disabled = true;
      kubernetes = {
        symbol = "☸ ";
        style = "blue";
        format = "[$symbol$context( \\($namespace\\))]($style) in ";
        disabled = false;
      };
    };
  };
}
