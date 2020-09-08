#!/bin/sh
#
# $Id: RUN_PostMigration.sh

if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh

#check java home
if [ "$JAVA_HOME" ]; then
  export PATH=$JAVA_HOME/bin:$PATH	
else
  echo JAVA_HOME is not set.
  echo You may not be able to build idempiere
  echo Set JAVA_HOME to the directory of your local JDK.
  exit
fi

cd "$IDEMPIERE_HOME" || (echo "Cannot cd to $IDEMPIERE_HOME"; exit 1)

./idempiere --launcher.ini setup.ini -application org.adempiere.base.PostMigration -consoleLog

echo Done ...

exit 0

