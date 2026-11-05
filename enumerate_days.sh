#!/usr/bin/zsh
# zsh because bash does not handle ${$(basename $first .json)##*_} well
# =========================================================================
DATA_DIR=/var/tmp/data/opensky/periodic

DATE_FMT="%Y-%m-%d"
VERSION="0.2 (05-11-2026)"

tmpfile=/tmp/enumdays$$

# =========================================================================
# Functions
function cleanup {
    rm -f $tmpfile
}

# =========================================================================
# Main

cd $DATA_DIR || exit 1

ls -ltr > $tmpfile
#set -x

first=$(ls -1tr | head -1)
last=$( ls -1tr | tail -1)

ts_start=${$(basename $first .json)##*_}
dt_start=$(date --date=@$ts_start +$DATE_FMT)

ts_end=${$(  basename $last .json)##*_}
dt_end=$(  date --date=@$ts_end   +$DATE_FMT)

ts=$ts_start
ndays=0
echo "# Displaying dates for json data files found under $DATA_DIR (from $ts_start to $ts_end) ..."
while [[ $ts -lt $ts_end ]]; do
    echo "----------------------------------------------------------"
    date --date="$dt_start + $ndays day" +$DATE_FMT
    #date --date="$dt_start + $ndays day" +%s
    
    # a date Format 'Nov  5' or 'Oct 31'
    awk_date=$(date --date="$dt_start + $ndays day" '+%b %_d')
    echo -e 'data files for that date: \c'; cat $tmpfile | fgrep "$awk_date" | wc -l
    ts=$(date --date="$dt_start + $ndays day" +%s)

    ((ndays = ndays + 1))
    #echo "    ts=$ts"
    #echo "ts_end=$ts_end"
done

[[ -z $DEBUG ]] && cleanup
