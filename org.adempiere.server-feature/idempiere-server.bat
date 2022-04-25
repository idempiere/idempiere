@Echo off

CALL utils\myEnvironment.bat Server

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

@Set VMOPTS=%VMOPTS% -Dorg.osgi.framework.bootdelegation=sun.security.ssl
@Set VMOPTS=%VMOPTS% -Dosgi.compatibility.bootdelegation=true
@Set VMOPTS=%VMOPTS% -Djetty.home=jettyhome
@Set VMOPTS=%VMOPTS% -Djetty.base=jettyhome
@Set VMOPTS=%VMOPTS% -Djetty.etc.config.urls=etc/jetty.xml,etc/jetty-deployer.xml,etc/jetty-ssl.xml,etc/jetty-ssl-context.xml,etc/jetty-http.xml,etc/jetty-https.xml,etc/jetty-threadpool.xml,etc/jetty-http-forwarded.xml
@Set VMOPTS=%VMOPTS% -Dosgi.console=localhost:12612
@Set VMOPTS=%VMOPTS% -Dmail.mime.encodefilename=true
@Set VMOPTS=%VMOPTS% -Dmail.mime.decodefilename=true
@Set VMOPTS=%VMOPTS% -Dmail.mime.encodeparameters=true
@Set VMOPTS=%VMOPTS% -Dmail.mime.decodeparameters=true

@"%JAVA%" %IDEMPIERE_JAVA_OPTIONS% %VMOPTS% -jar %JARFILE% -application org.adempiere.server.application
