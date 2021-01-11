#!/bin/bash
#
# Author: Carlos Ruiz - globalqss
# Script to synchronize the database with latest migration scripts allowing a remote monitored way
#
# Intended process:
# 1. Customer executes bash RUN_MonitoredSyncDB.sh (folder can be specified as an optional parameter)
# 2. The program executes all pending scripts UNTIL an error is found
#    When an error is found it register the output of the script in AD_Migration_Script.Script column
#    The program stop the process informing the error
# 3. Vendor send a fix to the customer to integrate in the same folder
#    Conditions:
#    The script must have the same name as the script changing the suffix .sql by .001.fix - then .002.fix and so on
#       for example if 201811121420_IDEMPIERE-2648.sql fails, then Vendor must provide a file
#       201811121420_IDEMPIERE-2648.001.fix and send it to customer to integrate in the same folder as the sql failed
#       if the 001.fix fails then it can provide a 002.fix and keep going until the error is solved
#    It is expected that the script 001.fix always end registering calling register_migration_script
#      and also cleaning the Error status from the script that is fixing via update, for example:
#      script 201811121420_IDEMPIERE-2648.001.fix is expected to end with these two lines:
#        UPDATE AD_MigrationScript SET Status='IP' WHERE Name='201811121420_IDEMPIERE-2648.sql');
#        SELECT register_migration_script('201811121420_IDEMPIERE-2648.001.fix') FROM dual;
#      and similar the script 201811121420_IDEMPIERE-2648.002.fix is expected to end with these two lines:
#        UPDATE AD_MigrationScript SET Status='IP' WHERE Name='201811121420_IDEMPIERE-2648.001.fix');
#        SELECT register_migration_script('201811121420_IDEMPIERE-2648.002.fix') FROM dual;
#      and so on
# 4. If there is an email registered in AD_System.SupportEMail and there is an accessible sendmail program then
#    this script tries to send an email to that support informing the error
# 5. All the above steps are intended to be executed initially in a test or stage environment
#    When executed again on a clean environment, or applied in production, the script automatically applies the fixes and continue
#

echo Synchronize iDempiere Database

echo Upgrading database "$1@$ADEMPIERE_DB_NAME"

if [ $# -eq 0 ]
  then
    echo "Usage: $0 <userAccount>"
    echo "Example: $0 adempiere adempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ] || [ "$ADEMPIERE_DB_SERVER" = "" ] || [ "$ADEMPIERE_DB_PORT" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "  IDEMPIERE_HOME e.g. /idempiere"
    echo "  ADEMPIERE_DB_NAME e.g. adempiere or xe"
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
ERROR_STRINGS="\b(ORA-[0-9]+:|TNS-|PLS-|SP2-)"
DIR_POST=$IDEMPIERE_HOME/migration
if [ "x$4" = "x" ]
then
    DIR_SCRIPTS=$IDEMPIERE_HOME/migration
else
    if [ "${4#/}" = "${4}" ]
    then
        DIR_SCRIPTS="$IDEMPIERE_HOME/$4"
    else
        DIR_SCRIPTS="$4"
    fi
fi

cd "$DIR_SCRIPTS" || exit 1

mkdir $TMPFOLDER/SyncDB_out_$$

apply_script()
{
    SCRIPT="$1"
    OUTFILE="$2"
    FILE="$3"
    echo "Applying $SCRIPT"
    $CMD < "$SCRIPT" > "$OUTFILE" 2>&1
    APPLIED=Y
    if grep -E "$ERROR_STRINGS" "$OUTFILE" > /dev/null 2>&1
    then
        echo "Found error in $SCRIPT"
        # record error in ad_migrationscript
        echo "update ad_migrationscript set status='ER' where name='$FILE';" | $CMD >> "$OUTFILE" 2>&1
        return 1
    else
        return 0
    fi
}

process_fix()
{
    FAILEDSCRIPT=$1
    SUFFIX="${FAILEDSCRIPT##*.}"
    if [ "sql" = "$SUFFIX" ]
    then
        TMPBASE="${FAILEDSCRIPT##*/}"
        BASE="${TMPBASE%.sql}"
    elif [ "fix" = "$SUFFIX" ]
    then
        TMPBASE="${FAILEDSCRIPT##*/}"
        BASE="${TMPBASE%.[0-9][0-9][0-9].fix}"
    fi
    if [ -z "$BASE" ]
    then
        MSGERROR="$MSGERROR\n**** CANNOT FIND BASENAME FOR $FAILEDSCRIPT - Please contact administrator ****"
        return 1
    fi
    FIXFOUND=N
    find . -type f -path "*/$ADEMPIERE_DB_PATH/$BASE.[0-9][0-9][0-9].fix" > /tmp/lsfix$$
    CNTFIXES=$(wc -l < /tmp/lsfix$$)
    IDX=0
    while read -r FIX
    do
        IDX=$((IDX + 1))
        BASEFIX="$(basename "$FIX")"
        BASE=$(expr "$FIX" : '.*/\(.*\)\.fix')
        CNT=$(echo "set heading off
set feedback off
set pagesize 0
set term off
set echo off
select count(*) from ad_migrationscript where name='$BASEFIX';" | $SILENTCMD | sed -e 's:^ ::' | grep -v '^$' | sed -e 's/[ \t]//g')
        if [ "$CNT" != "0" ]
        then
            echo "$BASEFIX already applied, search for next fix"
            continue
        fi
        OUTFILE=$TMPFOLDER/SyncDB_out_$$/$BASE.out
        if ! apply_script "$FIX" "$OUTFILE" "$BASEFIX"
        then
            if [ "$IDX" -lt "$CNTFIXES" ]
            then
                # there are more fixes to process
                continue
            else
                MSGERROR="$MSGERROR\n**** ERROR ON FILE $OUTFILE - Please verify ****"
                # Stop processing, problem must be fixed
                return 2
            fi
        else
            FIXFOUND=Y
            return 0
        fi
    done < /tmp/lsfix$$
    if [ $FIXFOUND = N ]
    then
        MSGERROR="$MSGERROR\n**** NO FIXES FOUND FOR $FAILEDSCRIPT ****"
        return 1
    fi
    MSGERROR="$MSGERROR\n**** WRONG CONDITION FOR $FAILEDSCRIPT - Please verify ****"
    return 1
}

notify_error()
{
    printf '%s' "$MSGERROR"
    printf '\n%s\n%s\n' "Error=true" "Errors were found during the process (see message above) - please inform and integrate a fix to restart this process again"
    SUPPORTEMAIL=$(echo "set heading off
set feedback off
set pagesize 0
set term off
set echo off
select supportemail from ad_system;" | $SILENTCMD | sed -e 's:^ ::' | grep -v '^$' | sed -e 's/[ \t]//g')
    SENDMAIL=$(command -v sendmail)
    FROM="$(whoami)@$(hostname)"
    ATTACH=$(expr "$MSGERROR" : ".* ERROR ON FILE \(.*\) - Please verify.*")
    if [ -n "$SUPPORTEMAIL" ] && [ -n "$SENDMAIL" ] && [ -n "$ATTACH" ]
    then
        (
            echo "From: $FROM"
            echo "To: $SUPPORTEMAIL"
            echo "Subject: RUN_MonitoredSyncDB.sh - $(hostname) - fix script required $(date +'%Y-%m-%d %H:%M:%S')"
            echo "Mime-Version: 1.0"
            echo "Content-Type: multipart/mixed; boundary=\"ZZ_/afg6432dfgkl.94531q\""
            echo "--ZZ_/afg6432dfgkl.94531q"
            echo "Content-Type: text/plain; charset=\"UTF-8\""
            echo "Content-Transfer-Encoding: 7bit"
            echo "Content-Disposition: inline"
            printf '%s' "$MSGERROR"
            echo "================================="
            cat "$ATTACH"
            echo
            echo "--ZZ_/afg6432dfgkl.94531q"
        ) > /tmp/mail$$ 2>&1
        $SENDMAIL -t -oi < /tmp/mail$$ &
    fi
    exit 1
}

APPLIED=N
# Create list of files with error - registered in ad_migrationscript table
echo "set heading off
set feedback off
set pagesize 0
set term off
set echo off
select name from ad_migrationscript where status='ER' order by name;" | $SILENTCMD | sed -e 's:^ ::' | grep -v '^$' | sort > $TMPFOLDER/lisERR_$$.txt
while read -r FILE
do
    echo "Error registered in script $FILE, checking for fixes"
    if process_fix "$FILE"
    then
        # fix worked continue with next file
        continue
    else
        # no fix or fix failed - inform and stop
        notify_error
    fi
done < $TMPFOLDER/lisERR_$$.txt

# Create list of files already applied - registered in AD_MigrationScript table
echo "set heading off
set feedback off
set pagesize 0
set term off
set echo off
select name from ad_migrationscript;" | $SILENTCMD | sed -e 's:^ ::' | grep -v '^$' | sort > $TMPFOLDER/lisDB_$$.txt

# Create list of files in the migration folder
find . -type f -wholename "*/${ADEMPIERE_DB_PATH}/*.sql" ! -wholename "./processes_post_migration/${ADEMPIERE_DB_PATH}/*" | sed -e 's:.*/::' | sort > $TMPFOLDER/lisFS_$$.txt

MSGERROR=""
# extract and process the list of pending files
comm -13 $TMPFOLDER/lisDB_$$.txt $TMPFOLDER/lisFS_$$.txt > $TMPFOLDER/lisPENDING_$$.txt
if [ -s $TMPFOLDER/lisPENDING_$$.txt ]
then
    while read -r FILE
    do
        SCRIPT=$(find . -name "$FILE" | grep "/$ADEMPIERE_DB_PATH/")
        OUTFILE=$TMPFOLDER/SyncDB_out_$$/$(basename "$FILE" .sql).out
        if ! apply_script "$SCRIPT" "$OUTFILE" "$FILE"
        then
            TMPMSGERROR="\n**** ERROR ON FILE $OUTFILE - Please verify ****"
            process_fix "$FILE"
            FIXSTATUS=$?
            if [ "$FIXSTATUS" -eq 0 ]
            then
                # fix worked continue with next file
                continue
            elif [ "$FIXSTATUS" -eq 1 ]
            then
                MSGERROR="$MSGERROR$TMPMSGERROR"
            fi
            # Stop processing, problem must be fixed
            break
        fi
    done < $TMPFOLDER/lisPENDING_$$.txt
else
    if [ -s $TMPFOLDER/lisFS_$$.txt ]
    then
        echo "Database is already in sync - no scripts pending to apply"
    else
        echo "No scripts were found to apply"
    fi
fi

if [ -z "$MSGERROR" ]
then
    # Last verification - are there still ERRORS?
    echo "set heading off
set feedback off
set pagesize 0
set term off
set echo off
select name from ad_migrationscript where status='ER' order by name;" | $SILENTCMD | sed -e 's:^ ::' | grep -v '^$' | sort > $TMPFOLDER/lisERR_$$.txt
    while read -r FILE
    do
        MSGERROR="$MSGERROR\n**** Error on file $FILE still not resolved - Please verify ****"
    done < $TMPFOLDER/lisERR_$$.txt
fi

if [ x$APPLIED = xY ] && [ -z "$MSGERROR" ]
then
    cd "$DIR_POST" || exit 1
    for FILE in processes_post_migration/"$ADEMPIERE_DB_PATH"/*.sql
    do
        OUTFILE=$TMPFOLDER/SyncDB_out_$$/$(basename "$FILE" .sql).out
        echo "Applying $FILE"
        $CMD < "$FILE" > "$OUTFILE" 2>&1
        if grep -E "$ERROR_STRINGS" "$OUTFILE" > /dev/null 2>&1
        then
            echo "Found error in $SCRIPT"
            MSGERROR="$MSGERROR\n**** ERROR ON FILE $OUTFILE - Please verify ****"
        fi
    done
fi
if [ -n "$MSGERROR" ]
then
    notify_error
fi
exit 0
