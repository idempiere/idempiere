#!/bin/sh
# ADempiere Server Start

if [ $ADEMPIERE_HOME ]; then
  cd $ADEMPIERE_HOME/utils
fi

. ./myEnvironment.sh Server

##	Check Java Home
if [ $JAVA_HOME ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=java
  echo JAVA_HOME is not set.
  echo   You may not be able to start Adempiere
  echo   Set JAVA_HOME to the directory of your local JDK.
fi

# To use your own Encryption class (implementing org.compiere.util.SecureInterface),
# you need to set it here (and in the client start script) - example:
# SECURE=-DADEMPIERE_SECURE=org.compiere.util.Secure
SECURE=

VMARGS="-Djava.awt.headless=true -Declipse.ignoreApp=true -Dosgi.noShutdown=true -DADEMPIERE_HOME=$ADEMPIERE_HOME"
# headless option if you don't have X installed on the server
$JAVA -server $VMARGS -jar $ADEMPIERE_HOME/osgi/org.eclipse.osgi_3.6.0.v20100517.jar -install $ADEMPIERE_HOME/osgi -configuration $ADEMPIERE_HOME/osgi/server -clean -console


