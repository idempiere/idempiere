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

$JAVA_HOME/bin/java -cp $CLASSPATH org.compiere.install.Translation $DIRECTORY $AD_LANGUAGE export 


echo	Done
