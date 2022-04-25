#!/bin/sh
#
echo Setup idempiere Server

# setup application requires getVar.sh to be executable
find . -name '*.sh' -exec chmod u+x '{}' \;

# Setup idempiere.properties and idempiereEnv.properties
./idempiere --launcher.ini setup.ini -application org.adempiere.install.console-application $@

# Setup Jetty
./idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

echo .
echo For problems, check log file in base directory
