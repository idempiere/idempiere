#!/bin/sh

# $Id: ImportIdempiere.sh,v 1.10 2005/12/20 07:12:17 jjanke Exp $
echo	iDempiere Database Import		"$Revision": 1.10 $

echo	Importing idempiere DB from "$IDEMPIERE_HOME"/data/seed/Adempiere.dmp

if [ $# -le 2 ]
  then
    echo "Usage:		$0 <systemAccount> <AdempiereID> <AdempierePWD>"
    echo "Example:	$0 system/manager idempiere idempiere"
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
echo sqlplus "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateUser.sql "$2" "$3"
sqlplus "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateUser.sql "$2" "$3"

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
sqlplus "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql "$IDEMPIERE_HOME"/data/seed
# Note the user running this script must be member of dba group:  usermod -G dba idempiere
chgrp dba "$IDEMPIERE_HOME"/data
chmod 770 "$IDEMPIERE_HOME"/data
chgrp dba "$IDEMPIERE_HOME"/data/seed
chmod 770 "$IDEMPIERE_HOME"/data/seed
chgrp dba "$IDEMPIERE_HOME"/data/seed/Adempiere.dmp
chmod 640 "$IDEMPIERE_HOME"/data/seed/Adempiere.dmp

echo -------------------------------------
echo Import Adempiere.dmp
echo -------------------------------------
echo "impdp $1@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp REMAP_SCHEMA=reference:$2"
impdp "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp REMAP_SCHEMA=reference:"$2"

echo -------------------------------------
echo Check System
echo Import may show some warnings. This is OK as long as the following does not show errors
echo -------------------------------------
echo sqlplus "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/AfterImport.sql
sqlplus "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/AfterImport.sql
