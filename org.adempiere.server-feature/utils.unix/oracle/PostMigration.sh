#!/bin/sh

# $Id: PostMigration.sh
echo	Oracle Post Migration Scripts

if [ $# -le 2 ] 
  then
    echo "Usage:		$0 <systemAccount> <AdempiereID> <AdempierePWD>"
    echo "Example:	$0 system/manager idempiere idempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" -o  "$ADEMPIERE_DB_NAME" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. idempiere.idempiere.org"
    exit 1
fi

echo -------------------------------------
echo Add missing translations
echo -------------------------------------
echo sqlplus $2/$3@$ADEMPIERE_DB_SERVER:$ADEMPIERE_DB_PORT/$ADEMPIERE_DB_NAME @$IDEMPIERE_HOME/utils/$ADEMPIERE_DB_PATH/01_add_missing_Translations.sql
