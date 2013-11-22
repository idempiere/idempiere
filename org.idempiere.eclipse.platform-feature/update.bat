@Title ... p2 director
@Echo off

cd %~dp0

cp idempiere.ini idempiere.ini.sav
if exist server.xml.sav del /q server.xml.sav
if exist plugins/org.adempiere.tomcat.config_1.0.0/META-INF/tomcat/server.xml (
   copy plugins/org.adempiere.tomcat.config_1.0.0/META-INF/tomcat/server.xml server.xml.sav
   del /q plugins/org.adempiere.tomcat.config_1.0.0/META-INF/tomcat/server.xml
)
if exist plugins/org.adempiere.tomcat.config_2.0.0/META-INF/tomcat/server.xml (
   copy plugins/org.adempiere.tomcat.config_2.0.0/META-INF/tomcat/server.xml server.xml.sav
)

java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %~dp0 -repository %1 -u org.adempiere.server.product

java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %~dp0 -repository %1 -i org.adempiere.server.product

cp idempiere.ini.sav idempiere.ini
if exist server.xml.sav (
   copy server.xml.sav plugins/org.adempiere.tomcat.config_2.0.0/META-INF/tomcat/server.xml 
   del /q server.xml.sav
)
