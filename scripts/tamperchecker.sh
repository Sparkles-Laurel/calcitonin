#!/bin/sh
# tamperchecker.sh - checks against tampering of the virtual disk images on boot
# Copyright (c) 2024 Sparkles-Sylvia-Sericea Sacramentum
# Licensed under GNU GPL v3, see LICENSE at project root for more details


# All shell variables related to Calcitonin should be labeled with the `CALCA_`
# prefix as this is what the hormone is called.

# the hard coded url to fetch signatures from
CALCA_FETCH_URL="https://calcitonin.yigitovski.com/distfiles/signlist.txt.zst"

calca_syslog() {
    systemd-cat --identifier="calcitonin" \
                --priority="$1" echo "${@:2}"
}

calca_fetch_signatures() {
    curl -f -o "$1" "${CALCA_FETCH_URL}" || {
        calca_syslog "crit" "Failed to fetch signatures, shutting down."
        halt -p
    }
}