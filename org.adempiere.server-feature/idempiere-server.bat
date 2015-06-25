@Echo off


@if not "%JAVA_HOME%" == "" goto JAVA_HOME_OK
@Set JAVA=java
@Echo JAVA_HOME is not set.
@Echo You may not be able to start the server
@Echo Set JAVA_HOME to the directory of your local 1.6 JDK.
goto START

:JAVA_HOME_OK
@Set JAVA=%JAVA_HOME%\bin\java


:START
@Echo =======================================
@Echo Starting iDempiere Server ...
@Echo =======================================

FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
@"%JAVA%" -Dosgi.console=localhost:12612 -Djetty.home=jettyhome -Djetty.etc.config.urls=etc/jetty.xml,etc/jetty-selector.xml,etc/jetty-ssl.xml,etc/jetty-https.xml,etc/jetty-deployer.xml -XX:MaxPermSize=192m -Dmail.mime.encodefilename=true -Dmail.mime.decodefilename=true -Dmail.mime.encodeparameters=true -Dmail.mime.decodeparameters=true -jar %JARFILE% -application org.adempiere.server.application
