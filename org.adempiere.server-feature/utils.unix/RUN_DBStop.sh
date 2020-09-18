#!/bin/sh

# $Id: RUN_DBStop.sh,v 1.4 2005/01/22 21:59:15 jjanke Exp $
if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh
echo Stop DataBase Service - "$IDEMPIERE_HOME" \("$ADEMPIERE_DB_NAME"\)


sh "$ADEMPIERE_DB_PATH"/Stop.sh

