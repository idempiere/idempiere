#!/bin/bash

# Author Carlos Ruiz
if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server
echo 	Synchronize iDempiere Database - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

bash $ADEMPIERE_DB_PATH/MonitoredSyncDB.sh "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_PATH" $*
