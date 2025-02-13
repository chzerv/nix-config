{type, ...}: {
  programs.yt-dlp = {
    enable = type != "server";
    settings = {
      embed-thumbnail = true;
    };
  };
}
