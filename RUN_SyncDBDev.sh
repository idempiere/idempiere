#!/bin/bash
IDEMPIERE_HOME=$( dirname "$( readlink -f "${BASH_SOURCE[0]}")" )
if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
    echo "
Usage: ${BASH_SOURCE[0]} [property_file] [migration_folder]

Called without parameters it tries to get the database connection information from the file $IDEMPIERE_HOME/idempiere.properties
This requires that install.app or install.console.app has been previously executed in eclipse.

If the first parameter is a file, then the script tries to obtain the connection information from such properties file.

Optionally you can pass one or more migration folders at the end in order to process them.
If no migration folder is passed then it processes the folder $IDEMPIERE_HOME/migration

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
cd "$IDEMPIERE_HOME" || (echo "Cannot cd to $IDEMPIERE_HOME"; exit 1)
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
if [ "x$ADEMPIERE_DB_USER" = "x" ]
then
    ADEMPIERE_DB_USER="$(expr "$CONN" : ".*UID.=\(.*\)\]")"
fi
ADEMPIERE_DB_PASSWORD="$(expr "$CONN" : ".*PWD.=\(.*\)]")"
if [ "x$ADEMPIERE_DB_PASSWORD" = "x" ]
then
    ADEMPIERE_DB_PASSWORD="$( $IDEMPIERE_HOME/org.adempiere.server-feature/utils.unix/getVar.sh ADEMPIERE_DB_PASSWORD )"
fi
ADEMPIERE_DB_PATH="$(expr "$CONN" : ".*type.=\(.*\),DBhost.=")"
ADEMPIERE_DB_PATH="${ADEMPIERE_DB_PATH,,}"
export IDEMPIERE_HOME
export ADEMPIERE_DB_NAME
export ADEMPIERE_DB_SERVER
export ADEMPIERE_DB_PORT
export ADEMPIERE_DB_USER
export ADEMPIERE_DB_PASSWORD
export ADEMPIERE_DB_PATH
bash "org.adempiere.server-feature/utils.unix/$ADEMPIERE_DB_PATH/SyncDB.sh" "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_PATH" "$@"
