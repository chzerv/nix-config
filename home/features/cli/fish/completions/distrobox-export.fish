#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-
#
# fish-completion for distrobox-export
# https://github.com/89luca89/distrobox
#
complete -c distrobox-export -x -l app -s a -d 'Name of application to export' -a '(__fish_print_packages)'
complete -c distrobox-export -l bin -s b -d 'Absolute path of the binary to export' -r
complete -c distrobox-export -l service -s s -d 'Name of the service to export'
complete -c distrobox-export -l delete -s d -d 'Delete exported application or service'
complete -c distrobox-export -l export-label -o 'el' -d 'Label to add to the exported application'
complete -c distrobox-export -l export-path -o 'ep' -d 'Path where to export the binary' -r
complete -c distrobox-export -l extra-flags -o 'ef' -d 'Extra flags to add to the command'
complete -c distrobox-export -l sudo -s S -d 'Run the exported item with sudo'
complete -c distrobox-export -l help -s h -d 'Help'
complete -c distrobox-export -l version -s V -d 'Show version information'
complete -c distrobox-export -l verbose -s v -d 'Increase verbosity'
