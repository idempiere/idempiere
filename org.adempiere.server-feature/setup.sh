#!/bin/sh
#
echo ... Setup iDempiere Server

# Setup idempiere.properties and iDempiereEnv.properties
./idempiere --launcher.ini setup.ini -application org.adempiere.install.application $@

echo ... Setup Jetty
# Setup Jetty
./idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo ...
echo For problems, check log file in base directory
