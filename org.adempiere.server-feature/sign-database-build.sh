#!/bin/sh
#
echo Sign Database Build

# Sign Database Build
./idempiere --launcher.ini setup.ini -application org.adempiere.base.SignDatabaseBuildApplication

echo .
echo For problems, check log file in base directory
