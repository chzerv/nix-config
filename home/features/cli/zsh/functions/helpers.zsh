function mkd() {
    mkdir --parents $1 && cd $1
}

function cheat() {
    curl --silent "cheat.sh/:list" \
        | fzf-tmux \
        -p 70%,60% \
        --layout=reverse --multi \
        --preview \
        "curl --silent cheat.sh/{}\?style=rtt" \
        --bind "?:toggle-preview" \
        --preview-window 60%
}

function bd() {
    git_root=$(git rev-parse --show-toplevel)

    cd $git_root
}

# https://magnus919.com/2025/05/zsh-hidden-gems-advanced-tricks-that-will-transform-your-command-line-experience/
function cd() {
  # Go to home without arguments
  [ -z "$*" ] && builtin cd && return
  # If directory exists, change to it
  [ -d "$*" ] && builtin cd "$*" && return
  [ "$*" = "-" ] && builtin cd "$*" && return
  # Catch cd . and cd ..
  case "$*" in
    ..) builtin cd ..; return;;
    .) builtin cd .; return;;
  esac
  # Finally, call zoxide
  z "$*" || builtin cd "$*"
}

