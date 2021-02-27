#!/bin/bash
VARIABLE="${1}"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -x "$DIR/customGetVar.sh" ]
then
    "$DIR/customGetVar.sh" "$VARIABLE"
else
    if [[ "$DIR" == *utils ]]
    then
        VARFILE="$DIR/../.idpass"
    else
        VARFILE="$DIR/../../.idpass"
    fi
    if [ ! -f "$VARFILE" ] 
    then
        echo "Variables file does not exist"
        exit 1
    fi
    source "$VARFILE"
    echo "${!VARIABLE}" | base64 -d
fi
exit 0
