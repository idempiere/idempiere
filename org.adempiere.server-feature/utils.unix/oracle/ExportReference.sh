#!/bin/sh

echo    iDempiere Database Export       "$Revision": 1.5 $

# $Id: ExportReference.sh,v 1.5 2005/12/20 07:12:17 jjanke Exp $

echo Saving reference database reference@"$ADEMPIERE_DB_NAME" to "$IDEMPIERE_HOME"/data/Adempiere.dmp

if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "      IDEMPIERE_HOME  e.g. /idempiere"
    echo "      ADEMPIERE_DB_NAME       e.g. adempiere.adempiere.org"
    exit 1
fi

CREATE_DATAPUMP_DIR_SCRIPT="$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql
DOCKER_EXEC=
if [ -n "$ORACLE_DOCKER_CONTAINER" ]; then
  DOCKER_EXEC="docker exec -i $ORACLE_DOCKER_CONTAINER"
  ORACLE_DOCKER_HOME=${ORACLE_DOCKER_HOME:-/opt/oracle}
  $DOCKER_EXEC mkdir -p "$ORACLE_DOCKER_HOME"/idempiere/data
  $DOCKER_EXEC mkdir -p "$ORACLE_DOCKER_HOME"/idempiere/script
  docker cp "$CREATE_DATAPUMP_DIR_SCRIPT" "$ORACLE_DOCKER_CONTAINER:$ORACLE_DOCKER_HOME"/idempiere/script
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown -R oracle:dba "$ORACLE_DOCKER_HOME"/idempiere
  CREATE_DATAPUMP_DIR_SCRIPT="$ORACLE_DOCKER_HOME"/idempiere/script/CreateDataPumpDir.sql
fi

DATAPUMP_HOME="$IDEMPIERE_HOME"
if [ -n "$ORACLE_DOCKER_CONTAINER" ]; then
  DATAPUMP_HOME="$ORACLE_DOCKER_HOME"/idempiere
fi

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
$DOCKER_EXEC sqlplus -S "$3"/"$4"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$CREATE_DATAPUMP_DIR_SCRIPT" "$DATAPUMP_HOME"/data

if [ -z "$ORACLE_DOCKER_CONTAINER" ]; then
  chgrp dba "$IDEMPIERE_HOME"/data
  chmod 770 "$IDEMPIERE_HOME"/data
fi

$DOCKER_EXEC rm -f "$DATAPUMP_HOME"/data/Adempiere.dmp "$DATAPUMP_HOME"/data/Adempiere.log
# Export
if [ "$1" != "reference" ]; then
  $DOCKER_EXEC expdp "$1"/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp LOGFILE=Adempiere.log EXCLUDE=STATISTICS SCHEMAS="$1"
else
  $DOCKER_EXEC expdp REFERENCE/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp LOGFILE=Adempiere.log EXCLUDE=STATISTICS SCHEMAS=REFERENCE
fi

if [ -n "$ORACLE_DOCKER_CONTAINER" ]; then
  docker cp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data/Adempiere.dmp "$IDEMPIERE_HOME"/data
  docker cp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data/Adempiere.log "$IDEMPIERE_HOME"/data
fi

cd "$IDEMPIERE_HOME"/data || exit
jar cvfM Adempiere.jar Adempiere.dmp Adempiere.log
