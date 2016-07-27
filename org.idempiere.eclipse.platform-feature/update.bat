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

FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %1% -u org.adempiere.server.product
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %1% -i org.adempiere.server.product

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

