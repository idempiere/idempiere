#!/bin/sh
#
if [ $JAVA_HOME ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=java
  echo JAVA_HOME is not set.
  echo You may not be able to start the server
  echo Set JAVA_HOME to the directory of your local JDK.
fi

echo ===================================
echo Starting iDempiere Server
echo ===================================

unset DISPLAY
BASE=`dirname $( readlink -f idempiere-server.sh )`
$JAVA -Dosgi.compatibility.bootdelegation=true -Dosgi.noShutdown=true -Dosgi.framework.activeThreadType=normal -XX:MaxPermSize=192m -jar $BASE/plugins/org.eclipse.equinox.launcher_1.*.jar -console 12612 -application org.adempiere.server.application
