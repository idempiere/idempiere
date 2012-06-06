#!/bin/sh
#
# $Id: RUN_ImportReference.sh,v 1.11 2005/12/13 00:17:54 jjanke Exp $

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server
echo Import Reference - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

SUFFIX=""
SYSUSER=system
if [ $ADEMPIERE_DB_PATH = "postgresql" ]
then
   SUFFIX="_pg"
   SYSUSER=postgres
fi

echo Re-Create Reference User and import $IDEMPIERE_HOME/data/Adempiere.dmp - \($ADEMPIERE_DB_NAME\)
echo == The import will show warnings. This is OK ==
ls -lsa $IDEMPIERE_HOME/data/Adempiere${SUFFIX}.dmp
echo Press enter to continue ...
read in

# Parameter: <systemAccount> <AdempiereID> <AdempierePwd>
sh $ADEMPIERE_DB_PATH/ImportIdempiere.sh $SYSUSER/$ADEMPIERE_DB_SYSTEM reference reference $ADEMPIERE_DB_SYSTEM
