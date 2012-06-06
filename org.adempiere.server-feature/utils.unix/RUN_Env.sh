#!/bin/sh

# $Id: RUN_Env.sh,v 1.16 2005/01/22 21:59:15 jjanke Exp $
echo idempiere Environment Check

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
# Environment is read from the following script myEnvironment.sh
. ./myEnvironment.sh

echo General ...
echo PATH      = $PATH
echo CLASSPTH  = $CLASSPATH

echo .
echo Homes ...
echo IDEMPIERE_HOME        = $IDEMPIERE_HOME
echo JAVA_HOME            = $JAVA_HOME
echo ADEMPIERE_DB_URL      = $ADEMPIERE_DB_URL

echo .
echo Database ...
echo ADEMPIERE_DB_USER     = $ADEMPIERE_DB_USER
echo ADEMPIERE_DB_PASSWORD = $ADEMPIERE_DB_PASSWORD
echo ADEMPIERE_DB_PATH     = $ADEMPIERE_DB_PATH

echo .. Oracle specifics
echo ADEMPIERE_DB_NAME      = $ADEMPIERE_DB_NAME
echo ADEMPIERE_DB_SYSTEM   = $ADEMPIERE_DB_SYSTEM

echo .
echo Java Test ... should be 1.6+
$JAVA_HOME/bin/java -version

echo .
echo Database Connection Test \(1\) ... TNS
echo Running tnsping $ADEMPIERE_DB_NAME
tnsping $ADEMPIERE_DB_NAME

echo .
echo Database Connection Test \(2\)... System
echo Running sqlplus system/$ADEMPIERE_DB_SYS@$ADEMPIERE_DB_NAME @$ADEMPIERE_DB_PATH/Test.sql
sqlplus system/$ADEMPIERE_DB_SYSTEM@$ADEMPIERE_DB_NAME @$ADEMPIERE_DB_HOME/Test.sql 

echo .
echo Checking Database Size \(3\)
sqlplus system/$ADEMPIERE_DB_SYSTEM@$ADEMPIERE_DB_NAME @$ADEMPIERE_DB_HOME/CheckDB.sql $ADEMPIERE_DB_USER

echo .
echo == It is ok for the next to fail before the Adempiere Database Import Step ==
echo Database Connection Test \(4\) ... Adempiere \(May not work, if not user not yet imported\)
sqlplus $ADEMPIERE_DB_USER/$ADEMPIERE_DB_PASSWORD@$ADEMPIERE_DB_NAME @$ADEMPIERE_DB_HOME/Test.sql

echo .
echo Done

