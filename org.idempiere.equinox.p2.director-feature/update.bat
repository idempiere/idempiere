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

@call %DESTINATION%\update-prd %1% "org.adempiere.server.product"

copy idempiere.ini.sav idempiere.ini

if exist jetty.xml.sav (
   copy jetty.xml.sav jettyhome\etc\jetty.xml 
   del /q jetty.xml.sav
)

if exist jetty-ssl.xml.sav (
   copy jetty-ssl.xml.sav jettyhome\etc\jetty-ssl.xml 
   del /q jetty-ssl.xml.sav
)
