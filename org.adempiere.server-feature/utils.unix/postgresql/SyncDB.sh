#!/bin/bash
#
# Author: Carlos Ruiz - globalqss
# Script to synchronize the database for with latest migration scripts

echo	Synchronize iDempiere Database

echo Upgrading database "$1@$ADEMPIERE_DB_NAME"

if [ $# -eq 0 ]
  then
    echo "Usage:		$0 <userAccount>"
    echo "Example:	$0 adempiere adempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ] || [ "$ADEMPIERE_DB_SERVER" = "" ] || [ "$ADEMPIERE_DB_PORT" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere or xe"
    echo "  ADEMPIERE_DB_SERVER e.g. dbserver.adempiere.org"
    echo "  ADEMPIERE_DB_PORT e.g. 5432 or 1521"
    exit 1
fi

PGPASSWORD=$2
export PGPASSWORD

TMPFOLDER=/tmp
ADEMPIERE_DB_USER=$1
ADEMPIERE_DB_PATH=$3
CMD="psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -d $ADEMPIERE_DB_NAME -U $ADEMPIERE_DB_USER -b"
SILENTCMD="$CMD -q -t"
ERROR_STRINGS="^(ERROR:|FEHLER:|FATAL:|ERRO:)"
DIR_POST=$IDEMPIERE_HOME/migration
if [ "x$4" = "x" ]
then
    DIR_SCRIPTS=$IDEMPIERE_HOME/migration
else
    if [ "${4:0:1}" = "/" ]
    then
        DIR_SCRIPTS="$4"
    else
        DIR_SCRIPTS="$IDEMPIERE_HOME/$4"
    fi
fi

cd "$DIR_SCRIPTS" || (echo "ERROR: Cannot change to folder $DIR_SCRIPTS"; exit 1)

# Create list of files already applied - registered in AD_MigrationScript table
echo "select name from ad_migrationscript" | $SILENTCMD | sed -e 's:^ ::' | grep -v '^$' | sort > $TMPFOLDER/lisDB_$$.txt

# Create list of files in the migration folder
find . -type f -wholename "*/${ADEMPIERE_DB_PATH}/*.sql" ! -wholename "./processes_post_migration/${ADEMPIERE_DB_PATH}/*" | sed -e 's:.*/::' | sort > $TMPFOLDER/lisFS_$$.txt

MSGERROR=""
APPLIED=N
# extract and process the list of pending files
comm -13 $TMPFOLDER/lisDB_$$.txt $TMPFOLDER/lisFS_$$.txt > $TMPFOLDER/lisPENDING_$$.txt
if [ -s $TMPFOLDER/lisPENDING_$$.txt ]
then
    while read -r FILE
    do
	SCRIPT=$(find . -name "$FILE" | grep "/$ADEMPIERE_DB_PATH/")
	echo "$SCRIPT" >> $TMPFOLDER/lisPENDINGFOL_$$.txt
    done < $TMPFOLDER/lisPENDING_$$.txt
    sort -o $TMPFOLDER/lisPENDINGFOL_$$.txt $TMPFOLDER/lisPENDINGFOL_$$.txt
    mkdir $TMPFOLDER/SyncDB_out_$$
    while read -r SCRIPT
    do
	OUTFILE=$TMPFOLDER/SyncDB_out_$$/$(basename "$SCRIPT" .sql).out
	echo "Applying $SCRIPT"
	$CMD < "$SCRIPT" 2>&1 | tee "$OUTFILE"
	APPLIED=Y
	if grep -E "$ERROR_STRINGS" "$OUTFILE" > /dev/null 2>&1
	then
	    MSGERROR="$MSGERROR\n**** ERROR ON FILE $OUTFILE - Please verify ****"
	    # Stop processing to allow user to fix the problem before processing additional files
	    break
	fi
    done < $TMPFOLDER/lisPENDINGFOL_$$.txt
else
    if [ -s $TMPFOLDER/lisFS_$$.txt ]
    then
        echo "Database is already in sync - no scripts pending to apply"
    else
        echo "No scripts were found to apply"
    fi
fi
if [ x$APPLIED = xY ]
then
    cd "$DIR_POST" || (echo "ERROR: Cannot change to folder $DIR_POST"; exit 1)
    for FILE in processes_post_migration/"$ADEMPIERE_DB_PATH"/*.sql
    do
        OUTFILE=$TMPFOLDER/SyncDB_out_$$/$(basename "$FILE" .sql).out
        $CMD 2>&1 < "$FILE" | tee "$OUTFILE"
        if grep -E "$ERROR_STRINGS" "$OUTFILE" > /dev/null 2>&1
        then
            MSGERROR="$MSGERROR\n**** ERROR ON FILE $OUTFILE - Please verify ****"
        fi
    done
fi
PGPASSWORD=
export PGPASSWORD
if [ -n "$MSGERROR" ]
then
    echo "$MSGERROR"
    printf "\n Errors were found during the process (see message above) - please review and fix the error running manually the script - and then restart this process again"
    exit 1
fi
exit 0
