#!/bin/sh

if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
else
    cd "$(dirname "$0")" || (echo "Cannot cd "; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh

if [ "$JAVA_HOME" ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=java
fi

# $Id: RUN_ApplyPackInFromFolder.sh
echo    Apply PackIn from Folder - "$IDEMPIERE_HOME" \("$ADEMPIERE_DB_NAME"\)

if [ $# -eq 1 ]
then
    export  DIRECTORY=$1
else
    echo "Usage: $0 folder"
    exit 1
fi

cd .. || (echo "Cannot cd .."; exit 1)

echo    This Procedure import packin files from directory "$DIRECTORY"

$JAVA -Dosgi.compatibility.bootdelegation=true -Dosgi.noShutdown=false -jar plugins/org.eclipse.equinox.launcher_1.*.jar -application org.adempiere.base.PackInFolderApplication "$DIRECTORY"

echo    Done
echo .
echo For problems, check log file in base directory
