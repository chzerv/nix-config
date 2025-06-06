# Safeguards
alias cp='cp -i -v'
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Better reporting
alias rsync='rsync --progress'
alias dd='dd status=progress'

# Shortcuts
alias vi='nvim'
alias :q='exit'
alias sshfs='sshfs - o idmap=user,ServerAliveInterval=5,ServerAliveCountMax=3,reconnect';
alias grep='grep --color=always'
alias egrep='egrep --colour=auto'
alias l='eza';
alias ll='eza -l';
alias la='eza -la';
alias k='kubectl';
alias tree='eza --tree';
alias tmux="tmux -2"

# Git
alias g='git';
alias ga='git add';
alias gaf='git add-fzf';
alias glo='git log --oneline';
alias gs='git status';
alias gst='git stash';
alias gc='git commit -v';
alias gcm='git commit -m';
alias gca='git commit -v --amend';
alias gcan='git commit --amend --no-edit';
alias gd='git diff';
alias gw='git worktree';

# Print a horizontal ruler
alias hr=' tput setaf 3; for i in $(seq 1 $COLUMNS); do printf '='; done; tput sgr0'
