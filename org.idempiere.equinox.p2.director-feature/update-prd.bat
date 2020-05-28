@Title ... p2 director
@Echo on

cd %~dp0
@set DESTINATION=%cd%
@echo DESTINATION = %DESTINATION%
@set REPO=%1%
@echo REPOSITORY = %REPO%
@set PACK=%2%
@echo PACKAGES = %PACK%

@FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
@echo JARFILE = %JARFILE%
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %REPO% -u %PACK%
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -profile DefaultProfile -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %REPO% -i %PACK%
