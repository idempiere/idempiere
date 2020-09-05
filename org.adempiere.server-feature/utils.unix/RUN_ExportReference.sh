#!/bin/sh

# Author + Copyright 1999-2005 Jorg Janke
# $Id: RUN_DBExport.sh,v 1.10 2005/05/31 18:45:33 jjanke Exp $
if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh
echo    Export idempiere Database - "$IDEMPIERE_HOME" \("$ADEMPIERE_DB_NAME"\)


# Parameter: <adempiereDBuser>/<adempiereDBpassword>
sh "$ADEMPIERE_DB_PATH"/ExportReference.sh "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" system/"$ADEMPIERE_DB_SYSTEM"
