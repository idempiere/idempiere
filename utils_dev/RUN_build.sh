#!/bin/sh

#	This script rebuilds Adempiere
#	Ported from Windows script Marek Mosiewicz<marek.mosiewicz@jotel.com.pl>
#	If you have difficulties, compare it with the Windows version.
#
#	$Header: /cvsroot/adempiere/utils_dev/myDevEnvTemplate.sh,v 1.6 2003/04/27 12:34:16 marekmosiewicz Exp $

#check java home
if [ $JAVA_HOME ]; then
  export PATH=$JAVA_HOME/bin:$PATH
else
  echo JAVA_HOME is not set.
  echo You may not be able to build Adempiere
  echo Set JAVA_HOME to the directory of your local JDK.
  exit
fi

# check jdk
if  [ ! -f $JAVA_HOME/lib/tools.jar ] ; then
   echo "** Need full Java SDK **"
   exit
fi

ANTLIB="-lib ../tools/lib/ant4eclipse/ -lib ../equinox-target/org.eclipse.osgi_3.6.0.v20100517.jar -lib ../tools/lib/ant-contrib-1.0b1.jar"

#classpath
export ANT_CLASSPATH=../tools/lib/ant-launcher.jar

export ANT_OPTS="-Xms128m -Xmx512m -Dworkspace=`pwd`/.."

echo Cleanup ...
$JAVA_HOME/bin/java $ANT_OPTS -classpath $ANT_CLASSPATH org.apache.tools.ant.launch.Launcher $ANTLIB clean

echo Building ...
$JAVA_HOME/bin/java $ANT_OPTS -classpath $ANT_CLASSPATH org.apache.tools.ant.launch.Launcher -logger org.apache.tools.ant.listener.MailLogger $ANTLIB complete

echo Done ...

exit 0

