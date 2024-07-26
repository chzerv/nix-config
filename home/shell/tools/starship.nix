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
        "$git_state"
        "$git_status"
        "$rust"
        "$golang"
        "$python"
        "$terraform"
        "$nix_shell"
        "$kubernetes"
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
        success_symbol = "[➜ ](green)";
        error_symbol = "[✗](red) ";
        vicmd_symbol = "[➜ ](yellow)";
      };

      directory.style = "blue";

      hostname = {
        ssh_only = true;
        format = "[$hostname](blue) ";
        disabled = false;
      };

      cmd_duration.min_time = 5000; # Show cmd_duration if cmd took >= 5s

      git_commit = {commit_hash_length = 7;};

      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };

      git_branch = {
        format = "[$branch]($style) ";
        style = "bright-black";
      };

      jobs = {
        style = "red";
        symbol = "";
        format = "[$symbol $number]($style)";
      };

      kubernetes = {
        symbol = "󱃾";
        style = "bright-blue";
        format = "on [$symbol $namespace@$context]($style) ";
        disabled = false;
      };

      nix_shell = {
        symbol = "󱄅 ";
        style = "bright-blue";
        format = "via [$symbol(\($name\))]($style) ";
      };

      # Disabled modules
      memory_usage.disabled = true;
      package.disabled = true;
      docker_context.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;
      nodejs.disabled = true;
    };
  };
}
