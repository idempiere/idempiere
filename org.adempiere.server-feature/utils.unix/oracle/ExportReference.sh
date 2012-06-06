#!/bin/sh

echo	Adempiere Database Export 	$Revision: 1.5 $

# $Id: DBExport.sh,v 1.5 2005/12/20 07:12:17 jjanke Exp $

echo Saving reference database reference@$ADEMPIERE_DB_NAME to $IDEMPIERE_HOME/data/Adempiere.dmp

if [ "$IDEMPIERE_HOME" = "" -o  "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere.adempiere.org"
    exit 1
fi

# Export
exp reference/reference@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME FILE=$IDEMPIERE_HOME/data/Adempiere.dmp Log=$IDEMPIERE_HOME/data/Adempiere.log CONSISTENT=Y OWNER=reference 

cd $IDEMPIERE_HOME/data
jar cvfM Adempiere.jar Adempiere.dmp Adempiere.log
