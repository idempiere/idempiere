#!/bin/bash

# Author Carlos Ruiz
if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh
echo 	Synchronize iDempiere Database - "$IDEMPIERE_HOME" \("$ADEMPIERE_DB_NAME"\)

bash "$ADEMPIERE_DB_PATH"/MonitoredSyncDB.sh "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_PATH" $*
