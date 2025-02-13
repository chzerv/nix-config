{
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Search in compressed files
      "--search-zip"

      # Ignore case unless different cases are used for the query itself
      "--smart-case"

      # Ignore directories
      "--glob=!**/node_modules/**"
      "--glob=!.git/"
    ];
  };
}
