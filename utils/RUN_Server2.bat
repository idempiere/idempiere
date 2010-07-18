@if (%ADEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %ADEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title Adempiere Server Start - %ADEMPIERE_HOME% (%ADEMPIERE_APPS_TYPE%)

@Rem $Id: RUN_Server2.bat,v 1.24 2005/10/26 00:38:18 jjanke Exp $

:CHECK_JAVA:
@if not "%JAVA_HOME%" == "" goto JAVA_HOME_OK
@Set JAVA=java
@Echo JAVA_HOME is not set.
@Echo   You may not be able to start Adempiere
@Echo   Set JAVA_HOME to the directory of your local JDK.
@Echo   You could set it via WinEnv.js e.g.:
@Echo     cscript WinEnv.js C:\Adempiere C:\j2sdk1.4.2_06
@goto CHECK_ADEMPIERE
:JAVA_HOME_OK
@Set JAVA=%JAVA_HOME%\bin\java

@Rem  To use your own Encryption class (implementing org.compiere.util.SecureInterface),
@Rem  you need to set it here (and in the client start script) - example:
@Rem  SET SECURE=-DADEMPIERE_SECURE=org.compiere.util.Secure
@SET SECURE=

VMARGS="-Dosgi.compatibility.bootdelegation=true -Djava.awt.headless=true -Declipse.ignoreApp=true -Dosgi.noShutdown=true -DADEMPIERE_HOME=%ADEMPIERE_HOME%"
# headless option if you don't have X installed on the server
@"%JAVA%" -server %VMARGS% -jar %ADEMPIERE_HOME%/osgi/org.eclipse.osgi_3.6.0.v20100517.jar -install %ADEMPIERE_HOME%/osgi -configuration %ADEMPIERE_HOME%/osgi/server -clean -console
