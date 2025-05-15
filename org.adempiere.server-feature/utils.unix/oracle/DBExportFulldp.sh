#!/bin/sh

echo	iDempiere Full Database Export 	"$Revision": 1.3 $

# $Id: DBExportFull.sh,v 1.3 2005/01/22 21:59:15 jjanke Exp $

DATE=$(date +%Y%m%d_%H%M%S)
echo Saving database "$1"@"$ADEMPIERE_DB_NAME" to "$IDEMPIERE_HOME"/data/ExpDatFull_"$DATE".dmp

if [ $# -eq 0 ]
  then
    echo "Usage:		$0 <systemAccount>"
    echo "Example:	$0 system/manager"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere.adempiere.org"
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
fi

DATAPUMP_HOME="$IDEMPIERE_HOME"
if [ -n "$ORACLE_DOCKER_CONTAINER" ]; then
  DATAPUMP_HOME="$ORACLE_DOCKER_HOME"/idempiere
fi

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
$DOCKER_EXEC sqlplus -S "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" @"$CREATE_DATAPUMP_DIR_SCRIPT" "$DATAPUMP_HOME"/data

if [ -z "$ORACLE_DOCKER_CONTAINER" ]; then
  chgrp dba "$IDEMPIERE_HOME"/data
  chmod 770 "$IDEMPIERE_HOME"/data
fi

$DOCKER_EXEC expdp "$1"@"$ADEMPIERE_DB_SERVER":"$ADEMPIERE_DB_PORT"/"$ADEMPIERE_DB_NAME" DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=ExpDatFull_"$DATE".dmp LOGFILE=ExpDatFull_"$DATE".log EXCLUDE=STATISTICS FULL=Y

if [ -n "$ORACLE_DOCKER_CONTAINER" ]; then
  docker cp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data/ExpDatFull_"$DATE".dmp "$IDEMPIERE_HOME"/data
  docker cp "$ORACLE_DOCKER_CONTAINER:$DATAPUMP_HOME"/data/ExpDatFull_"$DATE".log "$IDEMPIERE_HOME"/data
fi

cd "$IDEMPIERE_HOME"/data || exit
jar cvfM ExpDatFull.jar ExpDatFull_"$DATE".dmp  ExpDatFull_"$DATE".log

