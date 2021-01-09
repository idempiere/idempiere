#!/bin/bash
VARIABLE="${1}"
VALUE="${2}"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -x "$DIR/customSetVar.sh" ]
then
    "$DIR/customSetVar.sh" "$VARIABLE" "$VALUE"
else
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    if [[ "$DIR" == *utils ]]
    then
        VARFILE="$DIR/../.idpass"
    else
        VARFILE="$DIR/../../.idpass"
    fi
    if [ ! -f "$VARFILE" ] 
    then
        : > "$VARFILE"
    fi
    chmod 600 "$VARFILE"
    if grep -q "^$VARIABLE=" "$VARFILE"
    then
	sed -i -e "/^$VARIABLE=/d" "$VARFILE"
    fi
    if [ "x$VALUE" == "x" ]
    then
        echo "$VARIABLE=" >> "$VARFILE"
    else
        VALB=$( echo "$VALUE" | base64 )
        echo "$VARIABLE=\"$VALB\"" >> "$VARFILE"
    fi
fi
exit 0
