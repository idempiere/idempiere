#!/bin/sh
#
echo Install Adempiere Server
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


echo ===================================
echo Setup Dialog
echo ===================================

# OSGi:
$JAVA -Dosgi.compatibility.bootdelegation=true -jar osgi/org.eclipse.osgi_3.6.0.v20100517.jar -clean -console -install osgi -configuration osgi/client -application org.adempiere.Install


echo ===================================
echo Make .sh executable & set Env
echo ===================================
chmod -R a+x *.sh
find . -name '*.sh' -exec chmod a+x '{}' \;

# Sign database build
# cd utils
#. ./RUN_SignDatabaseBuild.sh

. ./RUN_UnixEnv.sh

echo .
echo For problems, check log file in base directory
