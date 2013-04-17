#!/bin/sh

# $Id: RUN_DBRestore.sh,v 1.9 2005/01/22 21:59:15 jjanke Exp $
if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server
echo Restore idempiere Database from Export- $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)


echo Re-Create idempiere User and import $IDEMPIERE_HOME/data/ExpDat.dmp
echo == The import will show warnings. This is OK ==
ls -lsa $IDEMPIERE_HOME/data/ExpDat.dmp
echo Press enter to continue ...
read in

# Parameter: <systemAccount> <adempiereID> <adempierePwd>
# globalqss - cruiz - 2007-10-09 - added fourth parameter for postgres(ignored in oracle)
$ADEMPIERE_DB_PATH/DBRestoredp.sh system/$ADEMPIERE_DB_SYSTEM $ADEMPIERE_DB_USER $ADEMPIERE_DB_PASSWORD $ADEMPIERE_DB_SYSTEM
