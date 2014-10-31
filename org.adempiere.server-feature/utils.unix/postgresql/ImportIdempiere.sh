#!/bin/sh

# $Id: ImportAdempiere.sh,v 1.10 2005/12/20 07:12:17 jjanke Exp $
echo	idempiere Database Import		$Revision: 1.10 $

echo	Importing idempiere DB from $IDEMPIERE_HOME/data/seed/Adempiere$5.dmp

if [ $# -le 2 ]
  then
    echo "Usage:		$0 <systemAccount> <AdempiereID> <AdempierePWD> <PostgresPwd>"
    echo "Example:	$0 postgres idempiere idempiere postgresPwd"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" -o  "$ADEMPIERE_DB_NAME" = "" -o "$ADEMPIERE_DB_SERVER" = "" -o "$ADEMPIERE_DB_PORT" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. idempiere"
    echo "  ADEMPIERE_DB_SERVER e.g. dbserver.idempiere.org"
    echo "  ADEMPIERE_DB_PORT e.g. 5432"
    exit 1
fi

PGPASSWORD=$4
export PGPASSWORD
if [ "x$4" = "x^TryLocalConnection^" ]
then
    LOCALPG=true  # Allow to run this command with user postgres (just useful running configure as root)
else
    LOCALPG=false
fi
echo -------------------------------------
echo Recreate user and database
echo -------------------------------------
ADEMPIERE_CREATE_ROLE_SQL="CREATE ROLE $2 SUPERUSER LOGIN PASSWORD '$3'"
if [ $LOCALPG = "true" ]
then
    # Assuming that adempiere role already exists (it was created out there)
    PGPASSWORD=$3
    export PGPASSWORD
    dropdb -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -U $2 $ADEMPIERE_DB_NAME
else
    dropdb -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -U postgres $ADEMPIERE_DB_NAME
    dropuser -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -U postgres $2
    psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -U postgres -c "$ADEMPIERE_CREATE_ROLE_SQL"
fi
ADEMPIERE_CREATE_ROLE_SQL=

PGPASSWORD=$3
export PGPASSWORD
createdb -T template0 -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -E UNICODE -O $2 -U $2 $ADEMPIERE_DB_NAME

echo -------------------------------------
echo Import Adempiere$5.dmp
echo -------------------------------------
ADEMPIERE_ALTER_ROLE_SQL="ALTER ROLE $2 SET search_path TO adempiere, pg_catalog"
psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -d $ADEMPIERE_DB_NAME -U $2 -c "$ADEMPIERE_ALTER_ROLE_SQL"
psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -d $ADEMPIERE_DB_NAME -U $2 -f $IDEMPIERE_HOME/data/seed/Adempiere$5.dmp
ADEMPIERE_ALTER_ROLE_SQL=
PGPASSWORD=
export PGPASSWORD
