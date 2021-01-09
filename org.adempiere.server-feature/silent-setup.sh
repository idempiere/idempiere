#!/bin/sh
#
echo Setup idempiere Server

# Setup idempiere.properties and idempiereEnv.properties
./idempiere --launcher.ini setup.ini -application org.adempiere.install.silent-application $@

# Setup Jetty
if [ -s idempiere.properties ]
then
    ./idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml
fi

echo .
echo For problems, check log file in base directory
