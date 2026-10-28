#!/usr/bin/bash
# -------------------------------------------------------------------------------------
# Prep a data file for gnuplot from opensky all states data
# -------------------------------------------------------------------------------------
# Config section

# Where json outputs of nproc.get keys are supposed to be kept...
DATA_DIR=/var/tmp/data/opensky/periodic

TS_MIN=0
TS_MAX=2145999000 # more or less end of unix times

VERSION="0.2 (28-10-2026)"

# FIXME: handle country names containing ' ' 
COUNTRY_NAMES="France Germany Australia China"

PROGNAME=$(basename $0)

# -------------------------------------------------------------------------------------
# Functions section

function usage {
    cat <<EOF

	$PROGNAME: usage:

	$PROGNAME

        # Prep a data file for gnuplot from opensky all states data
	# use with | tee filename 

	# and adapt gnuplot script accordingly ...

EOF
}

# -------------------------------------------------------------------------------------
# Main section
[[ $1 = "-h" ]] && usage && exit 0

tmpfile=/tmp/tmp$$

cd $DATA_DIR || exit 1

echo "# Generating gnuplot data from data files found under $DATA_DIR ..." 1>&2

ls -1tr | while read fn
do
    #echo $fn
    tn=$(basename $fn .json)
    ts=${tn##*_}
    
    echo -e "$ts \c"

    cat $fn | jq -cM '.states | .[]' > $tmpfile

    # on fait une boucle sur les noms
    for country_name in $COUNTRY_NAMES
    do
	cat $tmpfile | grep -F -c "$country_name" | while read count
	do
	    echo -e "$count \c"
	done
    done
    echo 
done

[[ -z $DEBUG ]] && rm -f $tmpfile

