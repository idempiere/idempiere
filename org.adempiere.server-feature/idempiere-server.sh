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

if [ "$1" = "debug" ]; then
  DEBUG="-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=4554,server=y,suspend=n"
fi

echo ===================================
echo Starting iDempiere Server
echo ===================================

unset DISPLAY
BASE=`dirname $( readlink -f idempiere-server.sh )`
$JAVA ${DEBUG} -Dosgi.console=localhost:12612 -Djetty.home=$BASE/jettyhome -Djetty.etc.config.urls=etc/jetty.xml,etc/jetty-selector.xml,etc/jetty-ssl.xml,etc/jetty-https.xml,etc/jetty-deployer.xml -XX:MaxPermSize=192m -Dmail.mime.encodefilename=true -Dmail.mime.decodefilename=true -Dmail.mime.encodeparameters=true -Dmail.mime.decodeparameters=true -jar $BASE/plugins/org.eclipse.equinox.launcher_1.*.jar -application org.adempiere.server.application
