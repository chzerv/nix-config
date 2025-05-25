#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-
#
# fish-completion for distrobox-generate-entry
# https://github.com/89luca89/distrobox
#
complete -c distrobox-generate-entry -l help -s h -d 'Help'
complete -c distrobox-generate-entry -l all -s a -d 'Perform for all distroboxes'
complete -c distrobox-generate-entry -l delete -s d -d 'Delete the entry'
complete -c distrobox-generate-entry -l icon -s i -d 'Path to a custom icon' -r
complete -c distrobox-generate-entry -l version -s V -d 'Show version information'
complete -c distrobox-generate-entry -l verbose -s v -d 'Increase verbosity'
