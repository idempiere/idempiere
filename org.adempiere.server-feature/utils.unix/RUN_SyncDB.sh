#!/bin/sh

# Author Carlos Ruiz
if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server
echo 	Synchronize iDempiere Database - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

sh $ADEMPIERE_DB_PATH/SyncDB.sh "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_PATH" $*
