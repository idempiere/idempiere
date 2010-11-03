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
echo Starting Adempiere Server
echo ===================================

$JAVA -Dosgi.noShutdown=true -Dosgi.framework.activeThreadType=normal -XX:MaxPermSize=192m -jar plugins/org.eclipse.equinox.launcher_1.1.0.v20100507.jar -console
