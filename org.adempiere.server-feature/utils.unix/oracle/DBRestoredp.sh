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

DOCKER_EXEC=
if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  DOCKER_EXEC="docker exec $ORACLE_DOCKER_CONTAINER"
fi

DATAPUMP_HOME="$IDEMPIERE_HOME"
if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  ORACLE_DOCKER_HOME=${ORACLE_DOCKER_HOME:-/opt/oracle}
  DATAPUMP_HOME="$ORACLE_DOCKER_HOME"
  $DOCKER_EXEC mkdir -p "$DATAPUMP_HOME"/data
fi

echo -------------------------------------
echo Re-Create DB user
echo -------------------------------------
sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateUser.sql "$2" "$3"

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql "$DATAPUMP_HOME"/data

if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown oracle:dba "$DATAPUMP_HOME"/data
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown oracle:dba "$DATAPUMP_HOME"/data/ExpDat.dmp
else
  # Note the user running this script must be member of dba group:  usermod -G dba idempiere
  chgrp dba "$IDEMPIERE_HOME"/data
  chmod 770 "$IDEMPIERE_HOME"/data
  chgrp dba "$IDEMPIERE_HOME"/data/ExpDat.dmp
  chmod 640 "$IDEMPIERE_HOME"/data/ExpDat.dmp
fi

if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  docker cp "$IDEMPIERE_HOME"/data/ExpDat.dmp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data
fi

echo -------------------------------------
echo Import ExpDat
echo -------------------------------------
$DOCKER_EXEC impdp "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=ExpDat.dmp SCHEMAS="$2"

echo -------------------------------------
echo Check System
echo Import may show some warnings. This is OK as long as the following does not show errors
echo -------------------------------------
sqlplus -S "$2"/"$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/AfterImport.sql
