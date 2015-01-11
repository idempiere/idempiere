#!/bin/sh
#
echo ... Setup idempiere Server
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

#setup idempiere.properties and idempiereEnv.propertiess
$JAVA -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install setup -configuration setup/configuration -application org.adempiere.install.application

echo ... Setup Jetty
#setup jetty
$JAVA -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install setup -configuration setup/configuration -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo ... Make .sh executable
chmod -R a+x *.sh
find . -name '*.sh' -exec chmod a+x '{}' \;

echo ...
echo For problems, check log file in base directory