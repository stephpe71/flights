# Flights description
A simple exploration of flights data from openskies by api
(every 5 minutes), w/ standard Unix CLI tools:

curl, grep, shell, loops, awk, jq, visidata...

Notably, mlr does not seem to be applicable here
(data is valid json, but not millerable, dixit mlr :
each vector is output as a json array, not object
(more compact for not compressed ultra-repetive data,
if I guess correctly)

# Getting the data
Simple crontab line
*/5 * * * *	/path/to/collect_opensky_states.sh

# Example of gnuplot display
See 'Screenshot from 2026-10-25 10-45-06.png'
Representing number of flights (in collected data)
for France, Germany, Australia and Germany
from Oct 19 to Oct 25

# Fun fact
Based to ultra fast superficial analysis, only flights
found above 14000 meters are those from 'United States'
and 'United Kingdom' (smthg to do w/ being United ?)











