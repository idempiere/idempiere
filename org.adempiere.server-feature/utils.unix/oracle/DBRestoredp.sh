#!/bin/sh

# $Id: DBRestore.sh,v 1.8 2005/12/20 07:12:17 jjanke Exp $
echo	iDempiere Database Restore 	"$Revision": 1.8 $

echo	Restoring iDempiere DB from "$IDEMPIERE_HOME"/data/ExpDat.dmp

if [ $# -le 2 ]
  then
    echo "Usage:		$0 <systemAccount> <AdempiereID> <AdempierePWD>"
    echo "Example:	$0 system/manager adempiere adempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere.adempiere.org"
    exit 1
fi


echo -------------------------------------
echo Re-Create DB user
echo -------------------------------------
sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateUser.sql "$2" "$3"

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql "$IDEMPIERE_HOME"/data
# Note the user running this script must be member of dba group:  usermod -G dba idempiere
chgrp dba "$IDEMPIERE_HOME"/data
chmod 770 "$IDEMPIERE_HOME"/data
chgrp dba "$IDEMPIERE_HOME"/data/ExpDat.dmp
chmod 640 "$IDEMPIERE_HOME"/data/ExpDat.dmp

echo -------------------------------------
echo Import ExpDat
echo -------------------------------------
impdp "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=ExpDat.dmp SCHEMAS="$2"

echo -------------------------------------
echo Check System
echo Import may show some warnings. This is OK as long as the following does not show errors
echo -------------------------------------
sqlplus -S "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/AfterImport.sql
