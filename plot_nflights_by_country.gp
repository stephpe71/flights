# ==============================================================================
# Used to work, doesn't anymore
# ==============================================================================
set term qt	size 1400,900

set title	"Number of flights by countries"

set xdata	time
set timefmt	"%s"

# Very nice looking !!
#set xtics format "%b %d\n%H:%M"
set xtics format "%a %b %d\n%H:%M\n(%s)"

#set key autotitle columnheader

# TO TEST
# load https://github.com/Gnuplotting/gnuplot-palettes
# Maybe doesn't quite work with v5.4 ??
#set loadpath '/home/sperrot/work/stet/supervision/zabbix/agent/topn'
#load 'viridis.pal'

#filename="pmem.dat"
filename="nflights_by_country3.dat"

# Donc en colonne 1 le ts
#
plot \
     filename using ($1 + 3600):($2) title "France"    with points, \
     filename using ($1 + 3600):($3) title "Germany"   with points, \
     filename using ($1 + 3600):($4) title "Australia" with points

