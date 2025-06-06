{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        # Pretty much the defaults
        show_hidden = false;
        show_symlink = true;
        sort_dir_first = true;
        sort_sensitive = false;
        sort_reverse = true;
      };
    };
  };
}
