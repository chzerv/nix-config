#!/usr/bin/env bash

# Define some colors for pretty prints
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# The host to connect to
HOST=$1

if [ $# -eq 0 ]; then
  echo
  echo -e "${RED}Error: You didn't provide an IP address to connect to!${NC}"
  echo
  echo -e "     Example: setup-keys.sh root@10.10.10.4 -p 2222"
  echo
  exit 0
fi

PUB_AGE_KEY=$(ssh "${HOST}" "nix-shell -p age ssh-to-age --run 'ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key | age-keygen -y'")

echo -e "${GREEN}The public AGE key is${NC}: $PUB_AGE_KEY"
