@Title ... p2 director
@Echo on

cd %~dp0
set DESTINATION=%cd%
@echo %DESTINATION%
@echo %1%

FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %1% -u "%2%, org.idempiere.fitnesse.feature.group"
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %1% -i "%2%, org.eclipse.equinox.p2.director, org.idempiere.fitnesse.feature.group, org.idempiere.equinox.p2.director.feature.group"
