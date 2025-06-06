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
