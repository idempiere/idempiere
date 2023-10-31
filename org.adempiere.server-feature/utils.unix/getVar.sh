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
        ENVFILE="$DIR/../idempiereEnv.properties"
    else
        VARFILE="$DIR/../../.idpass"
        ENVFILE="$DIR/../../idempiereEnv.properties"
    fi
    if [ ! -f "$VARFILE" ] 
    then
	VALUE=$( grep "${VARIABLE}" "${ENVFILE}" | sed -e "s/^${VARIABLE}=//" )
	if [ -n "${VALUE}" ]
	then
	    echo "${VALUE}"
	    exit 0
	fi
        echo "Variables file does not exist"
        exit 1
    fi
    source "$VARFILE"
    echo "${!VARIABLE}" | base64 -d
fi
exit 0
