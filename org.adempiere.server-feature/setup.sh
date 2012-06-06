#!/bin/sh
#
echo ... Setup iDempiere Server

# Setup idempiere.properties and iDempiereEnv.properties
./idempiere --launcher.ini setup.ini -application org.adempiere.install.application

echo ... Setup Tomcat
# Setup Tomcat
./idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo ... Make .sh executable
chmod -R a+x *.sh
find . -name '*.sh' -exec chmod a+x '{}' \;

echo ...
echo For problems, check log file in base directory
