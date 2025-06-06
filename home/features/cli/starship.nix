{lib, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_commit"
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

      add_newline = false;
      scan_timeout = 10;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red) ";
        vicmd_symbol = "[➜](bold yellow)";
      };

      directory = {
        truncation_length = 5;
        truncate_to_repo = true;
        style = "bold cyan";
      };

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
