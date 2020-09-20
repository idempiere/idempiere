#!/bin/sh

echo	iDempiere PostgreSQL Database Export

# $Id: DBExport.sh,v 1.3 2005/01/22 21:59:15 jjanke Exp $

echo Saving database "$1"@"$ADEMPIERE_DB_NAME" to "$IDEMPIERE_HOME"/data/ExpDat.dmp

if [ $# -eq 0 ]
  then
    echo "Usage:		$0 <userAccount>"
    echo "Example:	$0 adempiere adempiere"
    exit 1
fi
if [ "$IDEMPIERE_HOME" = "" ] || [ "$ADEMPIERE_DB_NAME" = "" ] || [ "$ADEMPIERE_DB_SERVER" = "" ] || [ "$ADEMPIERE_DB_PORT" = "" ]
  then
    echo "Please make sure that the environment variables are set correctly:"
    echo "	IDEMPIERE_HOME	e.g. /idempiere"
    echo "	ADEMPIERE_DB_NAME	e.g. adempiere or xe"
    echo "  ADEMPIERE_DB_SERVER e.g. dbserver.adempiere.org"
    echo "  ADEMPIERE_DB_PORT e.g. 5432 or 1521"
    exit 1
fi

PGPASSWORD=$2
export PGPASSWORD
pg_dump -h "$ADEMPIERE_DB_SERVER" -p "$ADEMPIERE_DB_PORT" --no-owner -U "$1" "$ADEMPIERE_DB_NAME" > "$IDEMPIERE_HOME"/data/ExpDat.dmp
PGPASSWORD=
export PGPASSWORD

cd "$IDEMPIERE_HOME"/data || exit
jar cvfM ExpDat.jar ExpDat.dmp
