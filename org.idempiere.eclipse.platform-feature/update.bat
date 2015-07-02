@Title ... p2 director
@Echo off

cd %~dp0

copy idempiere.ini idempiere.ini.sav

if exist jetty.xml.sav del /q jetty.xml.sav
if exist jettyhome/etc/jetty.xml (
   copy jettyhome/etc/jetty.xml jetty.xml.sav
)

if exist jetty-ssl.xml.sav del /q jetty-ssl.xml.sav
if exist jettyhome/etc/jetty-ssl.xml (
   copy jettyhome/etc/jetty-ssl.xml jetty-ssl.xml.sav
)

if exist jetty-selector.xml.sav del /q jetty-selector.xml.sav
if exist jettyhome/etc/jetty-selector.xml (
   copy jettyhome/etc/jetty-selector.xml jetty-selector.xml.sav
)

FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
java -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination $DESTINATION -repository $1 -u org.adempiere.server.product -i org.adempiere.server.product

copy idempiere.ini.sav idempiere.ini

if exist jetty.xml.sav (
   copy jetty.xml.sav jettyhome/etc/jetty.xml 
   del /q jetty.xml.sav
)

if exist jetty-ssl.xml.sav (
   copy jetty-ssl.xml.sav jettyhome/etc/jetty-ssl.xml 
   del /q jetty-ssl.xml.sav
)

if exist jetty-selector.xml.sav (
   copy jetty-selector.xml.sav jettyhome/etc/jetty-selector.xml 
   del /q jetty-selector.xml.sav
)

