#!/bin/sh

if [ $IDEMPIERE_HOME ]; then
    cd $IDEMPIERE_HOME/utils
else
    cd "`dirname $0`"
fi
. ./myEnvironment.sh Server

if [ $JAVA_HOME ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=java
fi

# $Id: RUN_ApplyPackInFromFolder.sh
echo    Apply PackIn from Folder - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

if [ $# -eq 1 ]
then
    export  DIRECTORY=$1
else
    echo "Usage: $0 folder"
    exit 1
fi

cd ..

echo    This Procedure import packin files from directory $DIRECTORY

$JAVA -Dosgi.compatibility.bootdelegation=true -Dosgi.noShutdown=false -jar plugins/org.eclipse.equinox.launcher_1.*.jar -application org.adempiere.base.PackInFolderApplication $DIRECTORY

echo    Done
echo .
echo For problems, check log file in base directory
