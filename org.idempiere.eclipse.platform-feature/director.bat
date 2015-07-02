@Title ... p2 director
@Echo off

FOR %%c in (plugins\org.eclipse.osgi_3.7.*.jar) DO set JARFILE=%%c
java -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=director -jar %JARFILE% -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true %1
