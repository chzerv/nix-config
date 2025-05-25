#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-
#
# fish-completion for distrobox
# https://github.com/89luca89/distrobox
#

# List available distroboxes
function __fish_distrobox_complete_containers
    distrobox list | awk '{ print $3 }' | tail -n +2
end

# List running distroboxes
function __fish_distrobox_complete_running_containers
    set -l active_containers (distrobox list | grep -vi exited | awk '{ print $3 }' | tail -n +2)

    string join \n $active_containers
end

# List available container images
function __fish_distrobox_container_images
    set -l images
    if command -v podman 1>/dev/null
        set images (podman image ls |  awk '{ print $1 }' | tail -n +2)
    else if command -v docker 1>/dev/null
        set images (docker image ls |  awk '{ print $1 }' | tail -n +2)
    end

    string join \n $images
end

# Disable file completions
complete -c distrobox --no-files

# Available distrobox commands
set -l distrobox_commands create enter list stop rm version

complete -c distrobox -n "not __fish_seen_subcommand_from $distrobox_commands" -a enter -d 'Enter the specified container'
complete -c distrobox -n "not __fish_seen_subcommand_from $distrobox_commands" -a create -d 'Create a container'
complete -c distrobox -n "not __fish_seen_subcommand_from $distrobox_commands" -a list -d 'List available containers'
complete -c distrobox -n "not __fish_seen_subcommand_from $distrobox_commands" -a stop -d 'Stop running containers'
complete -c distrobox -n "not __fish_seen_subcommand_from $distrobox_commands" -a rm -d 'Remove the specified container'
complete -c distrobox -n "not __fish_seen_subcommand_from $distrobox_commands" -a version -d 'Show version information'

# List available containers when using `distrobox enter/rm`
complete -c distrobox -n "__fish_seen_subcommand_from enter" -a '(__fish_distrobox_complete_containers)'

complete -c distrobox -n "__fish_seen_subcommand_from rm" -a '(__fish_distrobox_complete_containers)'

# List running containers when using `distrobox stop`
complete -c distrobox -n "__fish_seen_subcommand_from stop" -a '(__fish_distrobox_complete_running_containers)'

###############################################################################################################
# Handle generic options
complete -c distrobox -n "__fish_seen_subcommand_from $distrobox_commands" -l help -s h -d 'Help'
complete -c distrobox -n "__fish_seen_subcommand_from $distrobox_commands" -l version -s V -d 'Show version'
complete -c distrobox -n "__fish_seen_subcommand_from $distrobox_commands" -l verbose -s v -d 'Increase verbosity'
complete -c distrobox -n "__fish_seen_subcommand_from $distrobox_commands" -l root -s r -d 'Launch podman/docker with root privileges'
complete -c distrobox -n "__fish_seen_subcommand_from create enter" -l dry-run -s d -d 'Only print the generated command'
complete -c distrobox -x -n "__fish_seen_subcommand_from create enter rm stop" -l name -s n -d 'Name for the distrobox'

# Handle options for 'distrobox list'
complete -c distrobox -x -n "__fish_seen_subcommand_from list" -l no-color -d 'Disable color formatting'

# Handle options for 'distrobox stop'
complete -c distrobox -x -n "__fish_seen_subcommand_from stop" -l yes -s Y -d 'Stop without asking'

# Handle options for 'distrobox enter'
complete -c distrobox -x -n "__fish_seen_subcommand_from enter" -s e -d 'Command to execute at login'
complete -c distrobox -n "contains -- -- (commandline -opc)" -x -a "(__fish_print_packages)"
complete -c distrobox -x -n "__fish_seen_subcommand_from enter" -l no-tty -s T -d 'Do not instantiate a TTY'
complete -c distrobox -x -n "__fish_seen_subcommand_from enter" -l no-workdir -o 'nw' -d "Start inside the container's home directory"
complete -c distrobox -x -n "__fish_seen_subcommand_from enter" -l additional-flags -s a -d 'Additional flags to pass to podman/docker'
complete -c distrobox -x -n "__fish_seen_subcommand_from enter" -l help -s h -d 'Help'

# Handle options for 'distrobox create'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l image -s i -d 'Image to use for the container' -a '(__fish_distrobox_container_images)'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l pull -s p -d 'Pull the image even if it exists locally'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l yes -s Y -d 'Non-interactive'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l clone -s c -d 'Name of the distrobox container to use as base'
complete -c distrobox -n "__fish_seen_subcommand_from create" -l home -s H -d 'Select a custom HOME directory' -F -r
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l volume -d 'Additional volumes to add to the container'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l additional-flags -s a -d 'Additional flags to pass to podman/docker'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l init-hooks -d 'Additional commands to execute during container initialization'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l pre-init-hooks -d 'Additional commands to execute prior container initialization'
complete -c distrobox -x -n "__fish_seen_subcommand_from create" -l init -s I -d 'Use init system (e.g., systemd) inside the container'
