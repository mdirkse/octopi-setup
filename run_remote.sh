#!/bin/bash

set -euo pipefail
IFS=$'\n\t'
REPODIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"
PI_USER="pi"
SETUP_DIR="octopi-setup"

# Make sure the public key is available or the authorized_keys setup
cut -d ' ' -f 2 < ~/.ssh/pi.pub > "${REPODIR}/modules/bootstrap/files/public-key"

rsync -aP -e "ssh -i ${OCTOPI_SSH_KEY}" \
      "${REPODIR}" \
      "${PI_USER}@${OCTOPI_HOST}:~" \
      --exclude .git

ssh -i "${OCTOPI_SSH_KEY}" \
     "${PI_USER}@${OCTOPI_HOST}" \
     "sudo -S /home/pi/${SETUP_DIR}/run_puppet.sh ${*}"
