#!/bin/sh

if [ "$IDEMPIERE_HOME" ]; then
    cd "$IDEMPIERE_HOME"/utils || (echo "Cannot cd $IDEMPIERE_HOME/utils"; exit 1)
else
    cd "$(dirname "$0")" || (echo "Cannot cd"; exit 1)
fi
export ID_ENV=Server
. ./myEnvironment.sh

if [ "$JAVA_HOME" ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=java
fi

# $Id: RUN_TrlImport.sh,v 1.3 2005/01/22 21:59:15 jjanke Exp $
echo    Import idempiere Translation - "$IDEMPIERE_HOME" \("$ADEMPIERE_DB_NAME"\)

if [ $# -gt 0 ]
then
    export  AD_LANGUAGE=$1
else
    # need to change this to reflect your language
    export  AD_LANGUAGE=es_CO
fi

if [ $# -gt 1 ]
then
    export  DIRECTORY=$2
else
    export  DIRECTORY=$IDEMPIERE_HOME/data/$AD_LANGUAGE
fi

cd ..

echo    This Procedure imports language $AD_LANGUAGE from directory "$DIRECTORY"

$JAVA -Dosgi.compatibility.bootdelegation=true -Dosgi.noShutdown=false -jar plugins/org.eclipse.equinox.launcher_1.*.jar -application org.adempiere.install.translation import "$DIRECTORY" $AD_LANGUAGE

echo    Done
echo .
echo For problems, check log file in base directory
