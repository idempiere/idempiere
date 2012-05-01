#!/bin/sh
#
echo ... Setup Adempiere Server
# $Header: /cvsroot/adempiere/install/Adempiere/RUN_setup.sh,v 1.19 2005/09/08 21:54:12 jjanke Exp $

if [ $JAVA_HOME ]; then
  JAVA=$JAVA_HOME/bin/java
  KEYTOOL=$JAVA_HOME/bin/keytool
else
  JAVA=java
  KEYTOOL=keytool
  echo JAVA_HOME is not set.
  echo You may not be able to start the Setup
  echo Set JAVA_HOME to the directory of your local JDK.
fi

#setup Adempiere.properties and AdempiereEnv.propertiess
$JAVA -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=setup -jar plugins/org.eclipse.osgi_3.7.2.v20120110-1415.jar -application org.adempiere.install.application -consoleLog

echo ... Setup Tomcat
#setup tomcat
$JAVA -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=setup -jar plugins/org.eclipse.osgi_3.7.2.v20120110-1415.jar -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo ... Make .sh executable
chmod -R a+x *.sh
find . -name '*.sh' -exec chmod a+x '{}' \;

echo ...
echo For problems, check log file in base directory
