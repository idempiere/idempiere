#!/bin/sh
#
# $Id: RUN_ImportIdempiere.sh,v 1.9 2005/01/22 21:59:15 jjanke Exp $

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server
echo Import idempiere - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

SUFFIX=""
SYSUSER=system
if [ $ADEMPIERE_DB_PATH = "postgresql" ]
then
    SUFFIX="_pg"
    SYSUSER=postgres
fi

echo Re-Create idempiere User and import $IDEMPIERE_HOME/data/Adempiere${SUFFIX}.dmp - \($ADEMPIERE_DB_NAME\)
echo == The import will show warnings. This is OK ==
cd $IDEMPIERE_HOME/data/seed
jar xvf Adempiere${SUFFIX}.jar
cd $IDEMPIERE_HOME/utils
ls -lsa $IDEMPIERE_HOME/data/seed/Adempiere${SUFFIX}.dmp
echo Press enter to continue ...
read in

# Parameter: <systemAccount> <AdempiereID> <AdempierePwd>
# globalqss - cruiz - 2007-10-09 - added fourth parameter for postgres(ignored in oracle)
$ADEMPIERE_DB_PATH/ImportIdempiere.sh $SYSUSER/$ADEMPIERE_DB_SYSTEM $ADEMPIERE_DB_USER $ADEMPIERE_DB_PASSWORD $ADEMPIERE_DB_SYSTEM
