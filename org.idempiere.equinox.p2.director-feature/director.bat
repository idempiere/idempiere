@Title ... p2 director
@Echo off

FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
java -jar %JARFILE% -install director -configuration director/configuration -application org.eclipse.equinox.p2.director -consoleLog -profileProperties org.eclipse.update.install.features=true %1
