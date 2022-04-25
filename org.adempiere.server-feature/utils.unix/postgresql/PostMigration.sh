#!/bin/sh

# $Id: PostMigration.sh
echo	Postgresql Post Migration Scripts

if [ $# -le 2 ]
  then
    echo "Usage:		$0 <systemAccount> <AdempiereID> <AdempierePWD> <PostgresPwd>"
    echo "Example:	$0 postgres idempiere idempiere postgresPwd"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ] || [ "$ADEMPIERE_DB_SERVER" = "" ] || [ "$ADEMPIERE_DB_PORT" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. idempiere"
    echo "  ADEMPIERE_DB_SERVER e.g. dbserver.idempiere.org"
    echo "  ADEMPIERE_DB_PORT e.g. 5432"
    exit 1
fi

PGPASSWORD=$3
export PGPASSWORD
echo -------------------------------------
echo Add missing translations
echo -------------------------------------
psql -h "$ADEMPIERE_DB_SERVER" -p "$ADEMPIERE_DB_PORT" -d "$ADEMPIERE_DB_NAME" -U "$2" -f "$IDEMPIERE_HOME"/migration/processes_post_migration/"$ADEMPIERE_DB_PATH"/01_add_missing_translations.sql
PGPASSWORD=
export PGPASSWORD
