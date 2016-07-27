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
$JAVA ${DEBUG} -Xbootclasspath/p:plugins/org.mortbay.jetty.alpn.boot_8.1.7.v20160121.jar -Dorg.osgi.framework.bootdelegation=sun.security.ssl,org.eclipse.jetty.alpn -Dosgi.compatibility.bootdelegation=true -Djetty.home=$BASE/jettyhome -Djetty.etc.config.urls=etc/jetty.xml,etc/jetty-deployer.xml,etc/jetty-ssl.xml,etc/jetty-ssl-context.xml,etc/jetty-http.xml,etc/jetty-alpn.xml,etc/jetty-http2.xml,etc/jetty-https.xml -Dosgi.console=localhost:12612 -Dmail.mime.encodefilename=true -Dmail.mime.decodefilename=true -Dmail.mime.encodeparameters=true -Dmail.mime.decodeparameters=true -jar $BASE/plugins/org.eclipse.equinox.launcher_1.*.jar -application org.adempiere.server.application
