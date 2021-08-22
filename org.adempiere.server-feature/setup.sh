#!/bin/sh
#
echo ... Setup iDempiere Server

# setup application requires getVar.sh to be executable
find . -name '*.sh' -exec chmod u+x '{}' \;

# Setup idempiere.properties and iDempiereEnv.properties
./idempiere --launcher.ini setup.ini -application org.adempiere.install.application $@

echo ... Setup Jetty
# Setup Jetty
./idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo ...
echo For problems, check log file in base directory
