#!/bin/bash
# Cross-platform compatibility (macOS and Linux)

# Determine the OS and set appropriate readlink command
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    if command -v greadlink >/dev/null 2>&1; then
        READLINK_CMD="greadlink"
    else
        echo "The 'greadlink' command is not installed. Install it with 'brew install coreutils'."
        exit 1
    fi
else
    # Linux
    READLINK_CMD="readlink"
fi

# Set IDEMPIERE_HOME using the appropriate readlink command
IDEMPIERE_HOME=$( dirname "$($READLINK_CMD -f "${BASH_SOURCE[0]}")" )

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "
Usage: ${BASH_SOURCE[0]} [property_file] [db_import_folder]

Called without parameters, it tries to get the database connection information from the file $IDEMPIERE_HOME/idempiere.properties.
This requires that install.app or install.console.app has been previously executed in Eclipse.

If the first parameter is a file, then the script tries to obtain the connection information from that properties file.

Optionally, you can pass a db_import_folder at the end, or you can define the env variable DBIMPORT_FOLDER.
The process looks into this folder for the file post_[dbname].sql (for example post_idempieredev.sql), this file is applied if found.

When called with parameter -h or --help, it prints this help message."
    exit 0
fi

if [ "$#" -gt 0 ]; then
    if [ -s "$1" ]; then
        PROPFILE="$(dirname "$1")/$(basename "$1")"
    fi
fi

if [ -z "$PROPFILE" ]; then
    if [ -s "$IDEMPIERE_HOME/idempiere.properties" ]; then
        PROPFILE="$IDEMPIERE_HOME/idempiere.properties"
    fi
fi

if [ -z "$PROPFILE" ]; then
    echo "There is no idempiere.properties in folder $IDEMPIERE_HOME.
Please run install.app or install.console.app within Eclipse first."
    exit 1
fi

cd "$IDEMPIERE_HOME" || (echo "Cannot cd to $IDEMPIERE_HOME"; exit 1)

CONN=$(grep "^Connection=.*type" "$PROPFILE")
if [ -z "$CONN" ]; then
    echo "There is no Connection definition in the properties file $PROPFILE, or Connection is encrypted."
    exit 1
fi

ADEMPIERE_DB_NAME="$(expr "$CONN" : ".*DBname.=\(.*\),BQ.=")"
ADEMPIERE_DB_SERVER="$(expr "$CONN" : ".*DBhost.=\(.*\),DBport.=")"
ADEMPIERE_DB_PORT="$(expr "$CONN" : ".*DBport.=\(.*\),DBname.=")"
ADEMPIERE_DB_USER="$(expr "$CONN" : ".*UID.=\(.*\),PWD.=")"
if [ "$ADEMPIERE_DB_USER" = "" ]; then
    ADEMPIERE_DB_USER="$(expr "$CONN" : ".*UID.=\(.*\)\]")"
fi
ADEMPIERE_DB_PASSWORD="$(expr "$CONN" : ".*PWD.=\(.*\)]")"
if [ "$ADEMPIERE_DB_PASSWORD" = "" ]; then
    ADEMPIERE_DB_PASSWORD="$( "$IDEMPIERE_HOME/org.adempiere.server-feature/utils.unix/getVar.sh" ADEMPIERE_DB_PASSWORD )"
fi
ADEMPIERE_DB_PATH="$(expr "$CONN" : ".*type.=\(.*\),DBhost.=")"
ADEMPIERE_DB_PATH=$(echo "$ADEMPIERE_DB_PATH" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase

export IDEMPIERE_HOME
export ADEMPIERE_DB_NAME
export ADEMPIERE_DB_SERVER
export ADEMPIERE_DB_PORT
export ADEMPIERE_DB_USER
export ADEMPIERE_DB_PASSWORD
export ADEMPIERE_DB_PATH

IDEMPIERE_HOME=$IDEMPIERE_HOME/org.adempiere.server-feature

ADEMPIERE_DB_SYSTEM="$( "$IDEMPIERE_HOME/utils.unix/getVar.sh" ADEMPIERE_DB_SYSTEM )"
export ADEMPIERE_DB_SYSTEM

SUFFIX=""
SYSUSER=system
if [ "$ADEMPIERE_DB_PATH" = "postgresql" ]
then
    SUFFIX="_pg"
    SYSUSER=postgres
fi

echo Re-Create idempiere User and import "$IDEMPIERE_HOME"/data/Adempiere${SUFFIX}.dmp - \("$ADEMPIERE_DB_NAME"\)
echo "== The import will show warnings. This is OK =="
cd "$IDEMPIERE_HOME"/data/seed || exit
jar xvf Adempiere${SUFFIX}.jar
ls -lsa "$IDEMPIERE_HOME"/data/seed/Adempiere${SUFFIX}.dmp
echo Press enter to continue ...
read -r _

if [ -z "$ADEMPIERE_DB_SYSTEM_USER" ]; then
    if [ "$ADEMPIERE_DB_PATH" = "postgresql" ]; then
        ADEMPIERE_DB_SYSTEM_USER=postgres
    else
        ADEMPIERE_DB_SYSTEM_USER=SYSTEM
    fi
fi

if [ "$ADEMPIERE_DB_PATH" = "postgresql" ]
then
    cd "$IDEMPIERE_HOME"/.. || (echo "Cannot cd to $IDEMPIERE_HOME/.."; exit 1)
    echo "*** Importing postgresql seed into $ADEMPIERE_DB_NAME ***"
    if ! bash "org.adempiere.server-feature/utils.unix/$ADEMPIERE_DB_PATH/ImportIdempiere.sh" "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_SYSTEM_USER" "$ADEMPIERE_DB_SYSTEM" "$SUFFIX"
    then
        echo "Import failed, please verify"
        exit 1
    fi

    echo "*** Applying migration scripts ***"
    IDEMPIERE_HOME=$( dirname "$($READLINK_CMD -f "${BASH_SOURCE[0]}")" )
    if ! bash "$IDEMPIERE_HOME/RUN_SyncDBDev.sh" "$1"
    then
        echo "Applying migration scripts failed, please verify"
        exit 1
    fi

    DBIMPORT_FOLDER="${2:-$DBIMPORT_FOLDER}"
    if [ -f "$DBIMPORT_FOLDER/post_$ADEMPIERE_DB_NAME.sql" ]
    then
        echo "*** Applying script post_$ADEMPIERE_DB_NAME.sql ***"
	PGPASSWORD="$ADEMPIERE_DB_PASSWORD"
	export PGPASSWORD
	psql -b -h "$ADEMPIERE_DB_SERVER" -p "$ADEMPIERE_DB_PORT" -d "$ADEMPIERE_DB_NAME" -U "$ADEMPIERE_DB_USER" -f "$DBIMPORT_FOLDER/post_$ADEMPIERE_DB_NAME.sql"
    else
        echo "*** No post script found $DBIMPORT_FOLDER/post_$ADEMPIERE_DB_NAME.sql ***"
    fi
else
    # TODO: oracle
    echo "oracle import not implemented yet"
    # would be called like:
    #    ADEMPIERE_DB_SYSTEM=oracle DBIMPORT_FOLDER=/home/carlos/post_import_scripts bash RUN_ImportIdempiereDev.sh idempieredevoracle.properties
    # verify if ADEMPIERE_DB_SYSTEM variable is set
    # cat "$IDEMPIERE_HOME"/$UTILS_FOLDER/"$ADEMPIERE_DB_PATH"/CreateUser.sql |
      # sed replacing &1 and &2
      # sqlplus
    # same for CreateDataPumpDir.sql
    # impdp
    # AfterImport.sql
    # post...sql
fi
