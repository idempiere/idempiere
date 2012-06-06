#!/bin/sh
# iDempiere Server Start

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
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

VMARGS="-Dosgi.compatibility.bootdelegation=true -Djava.awt.headless=true -Declipse.ignoreApp=true -Dosgi.noShutdown=true -DIDEMPIERE_HOME=$IDEMPIERE_HOME"
# headless option if you don't have X installed on the server
$JAVA -server $VMARGS -jar $IDEMPIERE_HOME/osgi/org.eclipse.osgi_3.6.0.v20100517.jar -install $IDEMPIERE_HOME/osgi -configuration $IDEMPIERE_HOME/osgi/server -clean -console


