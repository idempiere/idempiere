#!/bin/sh
#

cd $(dirname "${0}")
DESTINATION=$(pwd)

cp idempiere.ini idempiere.ini.sav

if [ -f server.xml.sav ];
then
   rm -f server.xml.sav
fi
if [ -f plugins/org.adempiere.tomcat.config_1.0.0/META-INF/tomcat/server.xml ]
then
   cp plugins/org.adempiere.tomcat.config_1.0.0/META-INF/tomcat/server.xml server.xml.sav
fi

java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination $DESTINATION -repository $1 -u org.adempiere.server.product

java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination $DESTINATION -repository $1 -i org.adempiere.server.product

cp idempiere.ini.sav idempiere.ini
if [ -f server.xml.sav ]
then
   cp server.xml.sav plugins/org.adempiere.tomcat.config_1.0.0/META-INF/tomcat/server.xml 
   rm -f server.xml.sav
fi

