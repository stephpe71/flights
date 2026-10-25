#!/usr/bin/bash
# ==============================================================================
# Script to be placed in crontab to collect
# a lot of json data (10000 flights on Oct 15 2026)

# Author:		Stéphane Perrot
# Creation date:	2026, october 15th

# ==============================================================================
# Configuration
URL="https://opensky-network.org/api/states/all"
DATADIR="/var/tmp/data/opensky/periodic/"
FILENAME=states_all_$(date +%s).json

VERSION="0.2 (2026-10-16)"

PROGNAME=$(basename $0)

# ==============================================================================
# Functions

function usage {
  cat <<EOF

    $PROGNAME: usage:
    $PROGNAME

    collects OpenSky vector states data (json)
    intended to be called from crontab
EOF
}

# ==============================================================================
# Main

[[ ! -d $DATADIR ]] && mkdir -p $DATADIR

curl ${URL} > ${DATADIR}/${FILENAME}
