#!/bin/sh
#
echo Setup Adempiere Server

# Setup Adempiere.properties and AdempiereEnv.properties
./adempiere -noExit --launcher.ini setup.ini -application org.adempiere.install.application

# Setup Tomcat
./adempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo .
echo For problems, check log file in base directory
