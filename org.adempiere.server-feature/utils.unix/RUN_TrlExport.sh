#!/bin/sh

# $Id: RUN_TrlExport.sh,v 1.4 2005/01/22 21:59:15 jjanke Exp $

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh Server

echo	Export idempiere Translation - $IDEMPIERE_HOME \($ADEMPIERE_DB_NAME\)

# need to change this to reflect your language
export  AD_LANGUAGE=ca_ES

export  DIRECTORY=$IDEMPIERE_HOME/data/$AD_LANGUAGE

echo	This Procedure exports language $AD_LANGUAGE to directory $DIRECTORY

$JAVA -Dosgi.compatibility.bootdelegation=true -Dosgi.noShutdown=true -Dosgi.framework.activeThreadType=normal -XX:MaxPermSize=192m -jar plugins/org.eclipse.equinox.launcher_1.*.jar -console 12612 -application org.adempiere.ui.translation export $DIRECTORY $AD_LANGUAGE

echo	Done
