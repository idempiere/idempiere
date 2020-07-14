#!/bin/bash
#IDEMPIERE_HOME=$( dirname "$( readlink -f "${BASH_SOURCE[0]}")" )

IDEMPIERE_HOME=$( dirname "$( readlink -f "$0")" )
if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
    echo "
Usage: $0 db_system [property_file]

The contents of the first manadatory parameter depends on the type of database server that is used:
Postgresql: enter database root user password here.
Oracle: enter database root user name.

Called without the second property_file parameter it tries to get the database connection information 
from the file $IDEMPIERE_HOME/idempiere.properties
This requires that install.app or install.console.app has been previously executed in eclipse.

If the second parameter is a file, then the script tries to obtain the connection information from such properties file.

Note: This script requires that a database backup has already been created using the RUN_DBExportDev.sh script.

When called with parameter -h or --help prints this help message"
    exit 0
fi
if [ ! -f "data/ExpDat.dmp" ] 
then
    echo "
Database Backup not found. Make sure to run RUN_DBExportDev.sh at least once before attemting to restore." 
    exit 1
fi

if [ -z "$1" ]
then
    echo "Required parameter DB_Systemuser_password is missing.
    Run  $0 --help for details."
    exit 1
fi

if [ -s "$2" ]
then
	PROPFILE="$(dirname "$2")/$(basename "$2")"
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

sudo service postgresql restart

ADEMPIERE_DB_USER="$(expr "$CONN" : ".*UID.=\(.*\),PWD.=")"
ADEMPIERE_DB_PASSWORD="$(expr "$CONN" : ".*PWD.=\(.*\)]")"
ADEMPIERE_DB_NAME="$(expr "$CONN" : ".*DBname.=\(.*\),BQ.=")"
ADEMPIERE_DB_SERVER="$(expr "$CONN" : ".*DBhost.=\(.*\),DBport.=")"
ADEMPIERE_DB_PORT="$(expr "$CONN" : ".*DBport.=\(.*\),DBname.=")"
ADEMPIERE_DB_PATH="$(expr "$CONN" : ".*type.=\(.*\),DBhost.=")"
ADEMPIERE_DB_PATH=`echo "$ADEMPIERE_DB_PATH" | tr '[:upper:]' '[:lower:]'`

export IDEMPIERE_HOME
export ADEMPIERE_DB_NAME
export ADEMPIERE_DB_SERVER
export ADEMPIERE_DB_PORT


echo Restore idempiere Database from Export- $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

echo Re-Create idempiere User and import $IDEMPIERE_HOME/data/ExpDat.dmp
echo == The import will show warnings. This is OK ==
ls -lsa $IDEMPIERE_HOME/data/ExpDat.dmp
echo Press enter to continue ...
read in

# Parameter: <systemAccount> <adempiereID> <adempierePwd>
# globalqss - cruiz - 2007-10-09 - added fourth parameter for postgres(ignored in oracle)
sh "org.adempiere.server-feature/utils.unix/$ADEMPIERE_DB_PATH/DBRestore.sh" "system/$1" "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$1"
./RUN_SyncDBDev.sh
