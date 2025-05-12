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

DOCKER_EXEC=
if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  DOCKER_EXEC="docker exec $ORACLE_DOCKER_CONTAINER"
fi

echo -------------------------------------
echo Re-Create DB user
echo -------------------------------------
echo sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateUser.sql "$2" "$3"
sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateUser.sql "$2" "$3"

DATAPUMP_HOME="$IDEMPIERE_HOME"
if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  ORACLE_DOCKER_HOME=${ORACLE_DOCKER_HOME:-/opt/oracle}
  DATAPUMP_HOME="$ORACLE_DOCKER_HOME"
  $DOCKER_EXEC mkdir -p "$DATAPUMP_HOME"/data/seed
  docker cp "$IDEMPIERE_HOME"/data/seed/Adempiere.dmp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data/seed
fi

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql "$DATAPUMP_HOME"/data/seed

if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown oracle:dba "$DATAPUMP_HOME"/data
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown oracle:dba "$DATAPUMP_HOME"/data/seed
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown oracle:dba "$DATAPUMP_HOME"/data/seed/Adempiere.dmp
else
  # Note the user running this script must be member of dba group:  usermod -G dba idempiere
  chgrp dba "$DATAPUMP_HOME"/data
  chmod 770 "$DATAPUMP_HOME"/data
  chgrp dba "$DATAPUMP_HOME"/data/seed
  chmod 770 "$DATAPUMP_HOME"/data/seed
  chgrp dba "$DATAPUMP_HOME"/data/seed/Adempiere.dmp
  chmod 640 "$DATAPUMP_HOME"/data/seed/Adempiere.dmp
fi

echo -------------------------------------
echo Import Adempiere.dmp
echo -------------------------------------
echo "impdp $1@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp REMAP_SCHEMA=reference:$2"
$DOCKER_EXEC impdp "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp REMAP_SCHEMA=reference:"$2"

echo -------------------------------------
echo Check System
echo Import may show some warnings. This is OK as long as the following does not show errors
echo -------------------------------------
echo sqlplus -S "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/AfterImport.sql
sqlplus -S "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/AfterImport.sql
