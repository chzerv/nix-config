{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    # Command executed for CTRL-T
    fileWidgetCommand = "fd --hidden --follow --exclude '.git'";
    defaultOptions = [
      "--ansi"
      "--reverse"
      "--info=inline"
      "--height=70%"
      "--multi"
      "--preview-window right:70%"
      "--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'"
      "--prompt='∼ ' --pointer='▶' --marker='✓'"
      "--bind '?:toggle-preview'"
      "--bind 'ctrl-a:select-all'"
      "--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'"
      "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
      "--bind 'ctrl-v:execute(emacs {+})'"
      "--bind 'alt-k:preview-up,alt-p:preview-up'"
      "--bind 'alt-j:preview-down,alt-n:preview-down'"
      "--bind 'alt-w:toggle-preview-wrap'"
    ];
  };
}
