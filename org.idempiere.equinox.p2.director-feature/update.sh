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

UNINSTALL_UI="org.adempiere.server.product, org.idempiere.fitnesse.feature.group"
INSTALL_UI="org.adempiere.server.product, org.eclipse.equinox.p2.director, org.idempiere.fitnesse.feature.group, org.idempiere.equinox.p2.director.feature.group"

$DESTINATION/update-prd.sh $1 "$INSTALL_UI" "$UNINSTALL_UI"

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
