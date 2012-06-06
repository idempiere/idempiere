#!/bin/sh

echo	Adempiere Database Export 	$Revision: 1.5 $

# $Id: DBExport.sh,v 1.5 2005/12/20 07:12:17 jjanke Exp $

echo Saving database $1@$ADEMPIERE_DB_NAME to $IDEMPIERE_HOME/data/ExpDat.dmp

if [ $# -eq 0 ] 
  then
    echo "Usage:		$0 <userAccount>"
    echo "Example:	$0 adempiere adempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" -o  "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere.adempiere.org"
    exit 1
fi

# Cleanup
sqlplus $1/$2@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME @$IDEMPIERE_HOME/utils/$ADEMPIERE_DB_PATH/Daily.sql

# Export
exp $1/$2@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME FILE=$IDEMPIERE_HOME/data/ExpDat.dmp Log=$IDEMPIERE_HOME/data/ExpDat.log CONSISTENT=Y STATISTICS=NONE OWNER=$1 

cd $IDEMPIERE_HOME/data
jar cvfM ExpDat.jar ExpDat.dmp ExpDat.log
