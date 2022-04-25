#!/bin/sh
#
if [ "$JAVA_HOME" ]; then
  JAVA=$JAVA_HOME/bin/java
else
  JAVA=java
  echo JAVA_HOME is not set.
  echo You may not be able to start the Setup
  echo Set JAVA_HOME to the directory of your local JDK.
fi

# sign database build
$JAVA -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install setup -configuration setup/configuration -application org.adempiere.base.SignDatabaseBuildApplication
