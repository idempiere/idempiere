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

# for oracle or postgres version 9.1 or higher you run this the usual way:
#   RUN_ImportIdempiere.sh
# for postgres versions 8.4 or 9.0 you can run this way:
#   RUN_ImportIdempiere.sh 8.4
#     or
#   RUN_ImportIdempiere.sh 9.0
if [ "x$1" = x8.4 -o "x$1" = x9.0 ]
then
    SUFFIX="_pg84"
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
