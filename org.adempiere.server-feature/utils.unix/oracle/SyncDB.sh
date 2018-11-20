#!/bin/sh
#
# Author: Carlos Ruiz - globalqss
# Script to synchronize the database for with latest migration scripts

echo	Synchronize iDempiere Database

echo Upgrading database $1@$ADEMPIERE_DB_NAME

if [ $# -eq 0 ] 
  then
    echo "Usage:		$0 <userAccount>"
    echo "Example:	$0 adempiere adempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" -o  "$ADEMPIERE_DB_NAME" = "" -o "$ADEMPIERE_DB_SERVER" = "" -o "$ADEMPIERE_DB_PORT" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere or xe"
    echo "  ADEMPIERE_DB_SERVER e.g. dbserver.adempiere.org"
    echo "  ADEMPIERE_DB_PORT e.g. 5432 or 1521"
    exit 1
fi

TMPFOLDER=/tmp
ADEMPIERE_DB_USER=$1
ADEMPIERE_DB_PASSWORD=$2
ADEMPIERE_DB_PATH=$3
CMD="sqlplus $ADEMPIERE_DB_USER/$ADEMPIERE_DB_PASSWORD@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME"
SILENTCMD="sqlplus -S $ADEMPIERE_DB_USER/$ADEMPIERE_DB_PASSWORD@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME"
ERROR_STRINGS="^(ORA-[0-9]+:|TNS-|PLS-)"
DIR_POST=$IDEMPIERE_HOME/migration
if [ "x$4" = "x" ]
then
    DIR_SCRIPTS=$IDEMPIERE_HOME/migration
else
    if [ `expr substr "$4" 1 1` = "/" ]
    then
        DIR_SCRIPTS="$4"
    else
        DIR_SCRIPTS="$IDEMPIERE_HOME/$4"
    fi
fi

cd "$DIR_SCRIPTS"
if [ $? -ne 0 ]
then
    echo "ERROR: Cannot change to folder $DIR_SCRIPTS"
    exit 1
fi

# Create list of files already applied - registered in AD_MigrationScript table
echo "set heading off
set feedback off
set pagesize 0
set term off
set echo off
select name from ad_migrationscript;" | $SILENTCMD | sed -e 's:^ ::' | grep -v '^$' | sort > $TMPFOLDER/lisDB_$$.txt

# Create list of files in the migration folder
> $TMPFOLDER/lisFS_$$.txt
find -type d -name $ADEMPIERE_DB_PATH | grep -v "./processes_post_migration/$ADEMPIERE_DB_PATH" | while read FOLDER
do
    cd "${FOLDER}"
    ls *.sql 2>/dev/null >> $TMPFOLDER/lisFS_$$.txt
    cd "$DIR_SCRIPTS"
done
sort -o $TMPFOLDER/lisFS_$$.txt $TMPFOLDER/lisFS_$$.txt
sort -o $TMPFOLDER/lisDB_$$.txt $TMPFOLDER/lisDB_$$.txt
MSGERROR=""
APPLIED=N
# extract and process the list of pending files
comm -13 $TMPFOLDER/lisDB_$$.txt $TMPFOLDER/lisFS_$$.txt > $TMPFOLDER/lisPENDING_$$.txt
if [ -s $TMPFOLDER/lisPENDING_$$.txt ]
then
    mkdir $TMPFOLDER/SyncDB_out_$$
    for FILE in `cat $TMPFOLDER/lisPENDING_$$.txt`
    do
	SCRIPT=`find -name "$FILE" | grep "/$ADEMPIERE_DB_PATH/"`
	OUTFILE=$TMPFOLDER/SyncDB_out_$$/`basename "$FILE" .sql`.out
	echo "Applying $SCRIPT"
	cat "$SCRIPT" | $CMD 2>&1 | tee "$OUTFILE"
	APPLIED=Y
	if egrep "$ERROR_STRINGS" "$OUTFILE" > /dev/null 2>&1
	then
	    MSGERROR="$MSGERROR\n**** ERROR ON FILE $OUTFILE - Please verify ****"
	    # Stop processing to allow user to fix the problem before processing additional files
	    break
	fi
    done
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
    cd "$DIR_POST"
    for FILE in processes_post_migration/$ADEMPIERE_DB_PATH/*.sql
    do
        OUTFILE=$TMPFOLDER/SyncDB_out_$$/`basename "$FILE" .sql`.out
        cat "$FILE" | $CMD 2>&1 | tee "$OUTFILE"
        if egrep "$ERROR_STRINGS" "$OUTFILE" > /dev/null 2>&1
        then
            MSGERROR="$MSGERROR\n**** ERROR ON FILE $OUTFILE - Please verify ****"
        fi
    done
fi
if [ -n "$MSGERROR" ]
then
    echo "$MSGERROR"
    echo "\n Errors were found during the process (see message above) - please review and fix the error running manually the script - and then restart this process again"
    exit 1
fi
exit 0
