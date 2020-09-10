#!/bin/sh

echo	iDempiere Database Export 	"$Revision": 1.5 $

# $Id: DBExport.sh,v 1.5 2005/12/20 07:12:17 jjanke Exp $

DATE=$(date +%Y%m%d_%H%M%S)
echo Saving database "$1"@"$ADEMPIERE_DB_NAME" to "$IDEMPIERE_HOME"/data/ExpDat_"$DATE".dmp

if [ $# -eq 0 ]
  then
    echo "Usage:		$0 <userAccount>"
    echo "Example:	$0 adempiere adempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere.adempiere.org"
    exit 1
fi

# Cleanup
sqlplus "$1"/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/Daily.sql

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
sqlplus "$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql "$IDEMPIERE_HOME"/data
chgrp dba "$IDEMPIERE_HOME"/data
chmod 770 "$IDEMPIERE_HOME"/data

# Export
expdp "$1"/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=ExpDat_"$DATE".dmp LOGFILE=ExpDat_"$DATE".log EXCLUDE=STATISTICS SCHEMAS="$1"

cd "$IDEMPIERE_HOME"/data || exit
jar cvfM ExpDat.jar ExpDat_"$DATE".dmp ExpDat_"$DATE".log
