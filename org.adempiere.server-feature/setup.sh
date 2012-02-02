#!/bin/sh
#
echo ... Setup Adempiere Server

# Setup Adempiere.properties and AdempiereEnv.properties
./adempiere --launcher.ini setup.ini -application org.adempiere.install.application

echo ... Setup Tomcat
# Setup Tomcat
./adempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo ... Make .sh executable
chmod -R a+x *.sh
find . -name '*.sh' -exec chmod a+x '{}' \;

echo ...
echo For problems, check log file in base directory
