#!/bin/sh

# $Id: RUN_DBStart.sh,v 1.4 2005/01/22 21:59:15 jjanke Exp $
if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server
echo Start DataBase Service - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)


sh $ADEMPIERE_DB_PATH/Start.sh

