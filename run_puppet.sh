#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null 2>&1 && pwd )"

# This script needs to be run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

function install_puppet {
    echo "Installing Puppet"
    apt-get -q update > /dev/null
    apt-get -q -y install ruby-full > /dev/null
    gem install --no-ri --no-rdoc puppet
}

# Make sure puppet is installed
which puppet &> /dev/null || install_puppet

puppet apply "${SCRIPTDIR}/octopi.pp" \
       --modulepath "${SCRIPTDIR}/modules:${SCRIPTDIR}/forge_modules" \
       "${@}"
