@Title ... p2 director
@Echo on

cd %~dp0
set DESTINATION=%cd%
@echo %DESTINATION%
@echo %1%

copy idempiere.ini idempiere.ini.sav

if exist jetty.xml.sav del /q jetty.xml.sav
if exist jettyhome\etc\jetty.xml (
   copy jettyhome\etc\jetty.xml jetty.xml.sav
)

if exist jetty-ssl.xml.sav del /q jetty-ssl.xml.sav
if exist jettyhome\etc\jetty-ssl.xml (
   copy jettyhome\etc\jetty-ssl.xml jetty-ssl.xml.sav
)

if exist jetty-selector.xml.sav del /q jetty-selector.xml.sav
if exist jettyhome\etc\jetty-selector.xml (
   copy jettyhome\etc\jetty-selector.xml jetty-selector.xml.sav
)

@call %DESTINATION%\update-prd %1% "org.adempiere.server.product,org.idempiere.fitnesse.feature.group"

copy idempiere.ini.sav idempiere.ini

if exist jetty.xml.sav (
   copy jetty.xml.sav jettyhome\etc\jetty.xml 
   del /q jetty.xml.sav
)

if exist jetty-ssl.xml.sav (
   copy jetty-ssl.xml.sav jettyhome\etc\jetty-ssl.xml 
   del /q jetty-ssl.xml.sav
)

if exist jetty-selector.xml.sav (
   copy jetty-selector.xml.sav jettyhome\etc\jetty-selector.xml 
   del /q jetty-selector.xml.sav
)
