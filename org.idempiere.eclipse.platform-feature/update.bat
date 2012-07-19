@Title ... p2 director
@Echo off

cd %~dp0

cp idempiere.ini idempiere.ini.sav

java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %~dp0 -repository %1 -u org.adempiere.server.product

java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %~dp0 -repository %1 -i org.adempiere.server.product

cp idempiere.ini.sav idempiere.ini
