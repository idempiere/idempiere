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

CREATE_USER_SCRIPT="$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateUser.sql
CREATE_DATAPUMP_DIR_SCRIPT="$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql
AFTER_IMPORT_SCRIPT="$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/AfterImport.sql
DOCKER_EXEC=
if [ -n "$ORACLE_DOCKER_CONTAINER" ]; then
  DOCKER_EXEC="docker exec -i $ORACLE_DOCKER_CONTAINER"
  ORACLE_DOCKER_HOME=${ORACLE_DOCKER_HOME:-/opt/oracle}
  $DOCKER_EXEC mkdir -p "$ORACLE_DOCKER_HOME"/idempiere/data/seed
  $DOCKER_EXEC mkdir -p "$ORACLE_DOCKER_HOME"/idempiere/script
  docker cp "$IDEMPIERE_HOME"/data/seed/Adempiere.dmp "$ORACLE_DOCKER_CONTAINER:$ORACLE_DOCKER_HOME"/idempiere/data/seed
  docker cp "$CREATE_USER_SCRIPT" "$ORACLE_DOCKER_CONTAINER:$ORACLE_DOCKER_HOME"/idempiere/script
  docker cp "$CREATE_DATAPUMP_DIR_SCRIPT" "$ORACLE_DOCKER_CONTAINER:$ORACLE_DOCKER_HOME"/idempiere/script
  docker cp "$AFTER_IMPORT_SCRIPT" "$ORACLE_DOCKER_CONTAINER:$ORACLE_DOCKER_HOME"/idempiere/script
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown -R oracle:dba "$ORACLE_DOCKER_HOME"/idempiere
  CREATE_USER_SCRIPT="$ORACLE_DOCKER_HOME"/idempiere/script/CreateUser.sql
  CREATE_DATAPUMP_DIR_SCRIPT="$ORACLE_DOCKER_HOME"/idempiere/script/CreateDataPumpDir.sql
  AFTER_IMPORT_SCRIPT="$ORACLE_DOCKER_HOME"/idempiere/script/AfterImport.sql
fi

echo -------------------------------------
echo Re-Create DB user
echo -------------------------------------
echo sqlplus -S "$3"/"$4"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$CREATE_USER_SCRIPT" "$1" "$2"
$DOCKER_EXEC sqlplus -S "$3"/"$4"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$CREATE_USER_SCRIPT" "$1" "$2"

DATAPUMP_HOME="$IDEMPIERE_HOME"
if [ -n "$ORACLE_DOCKER_CONTAINER" ]; then
  DATAPUMP_HOME="$ORACLE_DOCKER_HOME"/idempiere
fi

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
$DOCKER_EXEC sqlplus -S "$3"/"$4"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$CREATE_DATAPUMP_DIR_SCRIPT" "$DATAPUMP_HOME"/data/seed

if [ -z "$ORACLE_DOCKER_CONTAINER" ]; then
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
echo "impdp "$1"/"$2"@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp REMAP_SCHEMA=reference:$1" TRANSFORM=OID:N
$DOCKER_EXEC impdp "$1"/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp REMAP_SCHEMA=reference:"$1" TRANSFORM=OID:N

echo -------------------------------------
echo Check System
echo Import may show some warnings. This is OK as long as the following does not show errors
echo -------------------------------------
echo sqlplus -S "$1"/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$AFTER_IMPORT_SCRIPT"
$DOCKER_EXEC sqlplus -S "$1"/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$AFTER_IMPORT_SCRIPT"
