#!/bin/sh
#

cd $(dirname "${0}")
DESTINATION=$(pwd)

cp idempiere.ini idempiere.ini.sav

if [ -f jetty.xml.sav ];
then
   rm -f jetty.xml.sav
fi
if [ -f jettyhome/etc/jetty.xml ]
then
   cp jettyhome/etc/jetty.xml jetty.xml.sav
fi

if [ -f jetty-ssl.xml.sav ];
then
   rm -f jetty-ssl.xml.sav
fi
if [ -f jettyhome/etc/jetty-ssl.xml ]
then
   cp jettyhome/etc/jetty-ssl.xml jetty-ssl.xml.sav
fi

if [ -f jetty-selector.xml.sav ];
then
   rm -f jetty-selector.xml.sav
fi
if [ -f jettyhome/etc/jetty-selector.xml ]
then
   cp jettyhome/etc/jetty-selector.xml jetty-selector.xml.sav
fi

VMOPTS="-Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true"
java $VMOPTS -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination $DESTINATION -repository $1 -u org.adempiere.server.product
java $VMOPTS -jar plugins/org.eclipse.equinox.launcher_1.*.jar -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination $DESTINATION -repository $1 -i org.adempiere.server.product 

cp idempiere.ini.sav idempiere.ini

if [ -f jetty.xml.sav ]
then
   cp jetty.xml.sav jettyhome/etc/jetty.xml 
   rm -f jetty.xml.sav
fi

if [ -f jetty-ssl.xml.sav ]
then
   cp jetty-ssl.xml.sav jettyhome/etc/jetty-ssl.xml 
   rm -f jetty-ssl.xml.sav
fi

if [ -f jetty-selector.xml.sav ]
then
   cp jetty-selector.xml.sav jettyhome/etc/jetty-selector.xml 
   rm -f jetty-selector.xml.sav
fi
