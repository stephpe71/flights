#!/usr/bin/bash
# ==============================================================================
# Doit être appelé dans un rep contenant des fichiers jsonl deja décodés ...

PROGNAME=$(basename $0)

# ==============================================================================
function usage {
    cat <<EOF

    $PROGNAME: usage:

    $PROGNAME callsign

    Called in a dir/folder containing flights decoded data Jsonl files (.jsonl)

    
EOF
}

# ==============================================================================
callsign=$1

[[ -z $callsign ]] && usage && exit 1

\fgrep $callsign *.jsonl
