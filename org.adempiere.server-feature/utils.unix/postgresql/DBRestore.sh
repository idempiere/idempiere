#!/bin/sh

echo	ADempiere Database Import

echo	Importing ADempiere DB from $IDEMPIERE_HOME/data/ExpDat.dmp 

if [ $# -le 2 ] 
  then
    echo "Usage:		$0 <systemAccount> <AdempiereID> <AdempierePWD> <PostgresPWD>"
    echo "Example:	$0 postgres adempiere adempiere postgrespwd"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" -o  "$ADEMPIERE_DB_NAME" = "" -o "$ADEMPIERE_DB_SERVER" = "" -o "$ADEMPIERE_DB_PORT" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere or xe"
    echo "  ADEMPIERE_DB_SERVER e.g. dbserver.adempiere.org"
    echo "  ADEMPIERE_DB_PORT e.g. 5432 or 1521"
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
createdb -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -E UNICODE -T template0 -O $2 -U $2 $ADEMPIERE_DB_NAME

echo -------------------------------------
echo Import Adempiere_pg.dmp
echo -------------------------------------
psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -d $ADEMPIERE_DB_NAME -U $2 -c "drop schema sqlj cascade"
ADEMPIERE_ALTER_ROLE_SQL="ALTER ROLE $2 SET search_path TO adempiere, pg_catalog"
psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -d $ADEMPIERE_DB_NAME -U $2 -c "$ADEMPIERE_ALTER_ROLE_SQL"
psql -h $ADEMPIERE_DB_SERVER -p $ADEMPIERE_DB_PORT -d $ADEMPIERE_DB_NAME -U $2 -f $IDEMPIERE_HOME/data/ExpDat.dmp

PGPASSWORD=
export PGPASSWORD
