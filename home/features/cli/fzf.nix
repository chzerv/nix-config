{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    # Command executed when pressing Ctrl-T
    fileWidgetCommand = "fd --hidden --follow --exclude '.git'";
    # Options to be passed to Ctrl-R
    historyWidgetOptions = [
      "--sort"
      "--exact"
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | wlcopy -n)+abort'"
      "--header 'Press CTRL-Y to copy command into the clipboard'"
    ];
    changeDirWidgetOptions = [
      "--preview 'eza --tree {} | head -200'"
    ];
    defaultOptions = [
      "--ansi"
      "--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626,gutter:-1"
      "--color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00"
      "--color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf"
      "--color=border:#262626,label:#aeaeae,query:#d9d9d9"
      "--border=rounded"
      " --border-label='' --preview-window='border-rounded' --prompt='> '"
      "--marker='>' --pointer='◆' --separator='─' --scrollbar='│'"
      "--height=70%"
      "--multi"
      "--preview-window right:70%"
      "--bind '?:toggle-preview'"
      "--bind 'ctrl-a:select-all'"
      "--bind 'ctrl-y:execute-silent(echo {+} | wlcopy -n)'"
      "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
      "--bind 'alt-k:preview-up,alt-p:preview-up'"
      "--bind 'alt-j:preview-down,alt-n:preview-down'"
      "--bind 'alt-w:toggle-preview-wrap'"
    ];
  };
}
