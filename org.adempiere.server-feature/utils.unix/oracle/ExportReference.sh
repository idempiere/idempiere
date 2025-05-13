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
echo Re-Create DataPump directory
echo -------------------------------------
sqlplus -S "$3"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$IDEMPIERE_HOME"/utils/"$ADEMPIERE_DB_PATH"/CreateDataPumpDir.sql "$DATAPUMP_HOME"/data

if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  docker exec -u 0 "$ORACLE_DOCKER_CONTAINER" chown oracle:dba "$DATAPUMP_HOME"/data
else
  chgrp dba "$IDEMPIERE_HOME"/data
  chmod 770 "$IDEMPIERE_HOME"/data
fi


rm -f "$IDEMPIERE_HOME"/data/Adempiere.dmp "$IDEMPIERE_HOME"/data/Adempiere.log
# Export
if [ "x${1,,}" != "xreference" ]; then
  $DOCKER_EXEC expdp "$1"/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp LOGFILE=Adempiere.log EXCLUDE=STATISTICS SCHEMAS="$1"
else
  $DOCKER_EXEC expdp REFERENCE/"$2"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp LOGFILE=Adempiere.log EXCLUDE=STATISTICS SCHEMAS=REFERENCE
fi

if [[ -n "$ORACLE_DOCKER_CONTAINER" ]]; then
  docker cp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data/Adempiere.dmp "$IDEMPIERE_HOME"/data
  docker cp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data/Adempiere.log "$IDEMPIERE_HOME"/data
fi

cd "$IDEMPIERE_HOME"/data || exit
jar cvfM Adempiere.jar Adempiere.dmp Adempiere.log
