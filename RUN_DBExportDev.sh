#!/bin/bash
IDEMPIERE_HOME=$( dirname "$( readlink -f "$0")" )
if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
    echo "
Usage: $0 [property_file]

Called without parameters it tries to get the database connection information from the file $IDEMPIERE_HOME/idempiere.properties
This requires that install.app or install.console.app has been previously executed in eclipse.

If the first parameter is a file, then the script tries to obtain the connection information from such properties file.

When called with parameter -h or --help prints this help message"
    exit 0
fi
if [ "$#" -gt 0 ]
then
    if [ -s "$1" ]
    then
	PROPFILE="$(dirname "$1")/$(basename "$1")"
	shift
    fi
fi
if [ -z "$PROPFILE" ]
then
    if [ -s "$IDEMPIERE_HOME/idempiere.properties" ]
    then
        PROPFILE="$IDEMPIERE_HOME/idempiere.properties"
    fi
fi
if [ -z "$PROPFILE" ]
then
    echo "There is no idempiere.properties in folder $IDEMPIERE_HOME.
Please run first install.app or install.console.app within eclipse"
    exit 1
fi
cd "$IDEMPIERE_HOME" || exit
CONN=$(grep "^Connection=.*type" "$PROPFILE")
if [ -z "$CONN" ]
then
    echo "There is no Connection definition in the properties file $PROPFILE, or Connection is encrypted"
    exit 1
fi
ADEMPIERE_DB_NAME="$(expr "$CONN" : ".*DBname.=\(.*\),BQ.=")"
ADEMPIERE_DB_SERVER="$(expr "$CONN" : ".*DBhost.=\(.*\),DBport.=")"
ADEMPIERE_DB_PORT="$(expr "$CONN" : ".*DBport.=\(.*\),DBname.=")"
ADEMPIERE_DB_USER="$(expr "$CONN" : ".*UID.=\(.*\),PWD.=")"
ADEMPIERE_DB_PASSWORD="$(expr "$CONN" : ".*PWD.=\(.*\)]")"
ADEMPIERE_DB_PATH="$(expr "$CONN" : ".*type.=\(.*\),DBhost.=")"
ADEMPIERE_DB_PATH="${ADEMPIERE_DB_PATH,,}"

export IDEMPIERE_HOME
export ADEMPIERE_DB_NAME
export ADEMPIERE_DB_SERVER
export ADEMPIERE_DB_PORT

if [ ! -d "$IDEMPIERE_HOME/data" ]; then
    mkdir "$IDEMPIERE_HOME/data"
fi

sh "org.adempiere.server-feature/utils.unix/$ADEMPIERE_DB_PATH/DBExport.sh" "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD"
sh org.adempiere.server-feature/utils.unix/myDBcopyTemplate.sh
