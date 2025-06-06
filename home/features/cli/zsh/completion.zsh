# ZSH Completion System
## Ref: https://thevaluable.dev/zsh-completion-guide-examples/

### Load and initialize the completion system
autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $ZDOTDIR/.zcompdump;
else
  compinit -C;
fi;
compdef -d mcd

### Define completers (https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Control-Functions)
zstyle ':completion:*' completer _extensions _complete _approximate
# zstyle ':completion:*' completer _complete _match _approximate

### Enable caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/.zcompcache"

### Use a menu for the selection
zstyle ':completion:*' menu select

### Group results under their descriptions
zstyle ':completion:*' group-name ''

### Change how suggestion are ordered
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

### When doing kill <TAB>, list more options about the processes
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,cputime,cmd'

### TODO: ??
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

### Colors and decorations
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
