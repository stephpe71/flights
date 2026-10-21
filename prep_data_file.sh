#!/usr/bin/bash
# -------------------------------------------------------------------------------------
# Prep a data file for gnuplot sor opensky all states data
#
# -------------------------------------------------------------------------------------
# Config

# Where json outputs of nproc.get keys are supposed to be kept...
DATA_DIR=/var/tmp/data/opensky/periodic


FMT_STRING="\"%s(%s)\":%d, "

TS_MIN=0
TS_MAX=2145999000 # more or less end of unix times

VERSION="0.1 (20-10-2026)"

PROGNAME=$(basename $0)

# -------------------------------------------------------------------------------------
# Functions

function usage {
    cat <<EOF

	$PROGNAME: usage:

	$PROGNAME
EOF
}

# -------------------------------------------------------------------------------------
# Main 

[[ $1 = "-h" ]] && usage && exit 0

cd $DATA_DIR || exit 1

echo "# Plotting number of flights ..." 1>&2
echo "# Generating data from data files found under $DATA_DIR ..." 1>&2

COUNTRY_NAMES="France Germany Australia"

ls -1tr | while read fn
do
    #echo $fn
    
    tn=$(basename $fn .json)
    ts=${tn##*_}
    
    # Let-s presume ...
    #echo -e "{\c"
    printf '%d ' $ts 

    # on fait une boucle sur les noms
    for country_name in $COUNTRY_NAMES
    do
	cat $fn | jq -cM '.states | .[]' | grep -F -c $country_name | while read count
	do
	    printf "%d " "$count"
	done
    done
    echo 
done

