#!/bin/sh
#
# script parameters are used as VM args. e.g.:
# ./adempiere-client.sh -DPropertyFile=/home/tbayen/idempiere-conf2.properties
# -- tbayen

if [ $JAVA_HOME ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=java
  echo JAVA_HOME is not set.
  echo You may not be able to start the server
  echo Set JAVA_HOME to the directory of your local JDK.
fi

echo ===================================
echo Starting Adempiere Client
echo ===================================

$JAVA -Dosgi.noShutdown=true -Dosgi.framework.activeThreadType=normal -Dosgi.compatibility.bootdelegation=true $@ -XX:MaxPermSize=192m -jar plugins/org.eclipse.equinox.launcher_1.*.jar -application org.adempiere.ui.swing.client
