@Title ... p2 director
@Echo on

cd %~dp0
set DESTINATION=%cd%
@echo %DESTINATION%
@echo %1%

set INSTALL_UI=%2%
set UNINSTALL_UI=%2%
if [%3]==[] goto nothird
set UNINSTALL_UI=%3%
:nothird

FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %1 -u %UNINSTALL_UI%
java -Dorg.eclipse.ecf.provider.filetransfer.excludeContributors=org.eclipse.ecf.provider.filetransfer.httpclient4 -Djava.net.preferIPv4Stack=true -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true -destination %DESTINATION% -repository %1 -i %INSTALL_UI%
