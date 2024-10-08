#!/bin/bash

set -e

APT="apt -c apt.conf"

tmpdir=$(mktemp -d)

reset() {
    rm -f etc/apt/sources.list.d/*.sources
    rm -f linux_*
    $APT update
}

test() {
    mirror="$1"
    reset
    ln -s ${mirror}.sources.disabled etc/apt/sources.list.d/${mirror}.sources
    apt_update_start=$(date +"%s")
    $APT update
    apt_source_start=$(date +"%s")
    $APT source --download-only linux
    end=$(date +"%s")
    echo "$apt_update_start,$apt_source_start,$end" >> $mirror.csv
}

random_sleep() {
    randint=$(( (RANDOM % 1000) + 1 ))
    echo "Sleeping for $randint seconds"
    sleep $randint
}

while :; do
    test us.ports
    random_sleep
    test us.archive
    random_sleep
done
