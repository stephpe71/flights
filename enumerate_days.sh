#!/usr/bin/zsh
# zsh because bash does not handle ${$(basename $first .json)##*_} well
# =========================================================================
DATA_DIR=/var/tmp/data/opensky/periodic

DATE_FMT="%Y-%m-%d"
VERSION="0.1 (03-11-2026)"

# =========================================================================
# Main

cd $DATA_DIR || exit 1

#set -x

first=$(ls -1tr | head -1)
last=$( ls -1tr | tail -1)


ts_start=${$(basename $first .json)##*_}
dt_start=$(date --date=@$ts_start +$DATE_FMT)

ts_end=${$(  basename $last .json)##*_}
dt_end=$(  date --date=@$ts_end   +$DATE_FMT)

#echo dt_start=$dt_start
#echo dt_end=$dt_end

ts=$ts_start
ndays=0

echo "# Displaying dates for json data files found under $DATA_DIR ..."xs
while [[ $ts -lt $ts_end ]]; do
    
    date --date="$dt_start + $ndays day" +$DATE_FMT
    ts=$(date --date="$dt_start + $ndays day" +%s)
    ((ndays = ndays + 1))

done

