#!/bin/sh

echo	Adempiere Full Database Export 	$Revision: 1.3 $

# $Id: DBExportFull.sh,v 1.3 2005/01/22 21:59:15 jjanke Exp $

DATE=`date +%Y%m%d_%H%M%S`
echo Saving database $1@$ADEMPIERE_DB_NAME to $IDEMPIERE_HOME/data/ExpDatFull_$DATE.dmp

if [ $# -eq 0 ] 
  then
    echo "Usage:		$0 <systemAccount>"
    echo "Example:	$0 system/manager"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" -o  "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere.adempiere.org"
    exit 1
fi

echo -------------------------------------
echo Re-Create DataPump directory
echo -------------------------------------
sqlplus $1@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME @$IDEMPIERE_HOME/utils/$ADEMPIERE_DB_PATH/CreateDataPumpDir.sql $IDEMPIERE_HOME/data
chgrp dba $IDEMPIERE_HOME/data
chmod 770 $IDEMPIERE_HOME/data

expdp $1@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=ExpDatFull_$DATE.dmp LOGFILE=ExpDatFull_$DATE.log EXCLUDE=STATISTICS FULL=Y

cd $IDEMPIERE_HOME/data
jar cvfM ExpDatFull.jar ExpDatFull_$DATE.dmp  ExpDatFull_$DATE.log

