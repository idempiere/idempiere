#!/bin/sh
#

cd "$(dirname "${0}")" || (echo "Cannot cd"; exit 1)
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

"$DESTINATION"/update-prd.sh "$1" org.adempiere.server.product

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
