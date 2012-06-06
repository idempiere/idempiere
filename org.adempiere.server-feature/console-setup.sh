#!/bin/sh
#
echo Setup idempiere Server

# Setup idempiere.properties and idempiereEnv.properties
./idempiere --launcher.ini setup.ini -application org.adempiere.install.console-application

# Setup Tomcat
./idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo .
echo For problems, check log file in base directory
