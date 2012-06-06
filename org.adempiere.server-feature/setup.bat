@Title ... Setup iDempiere Server
@Echo off

@REM Setup idempiere.properties and idempiereEnv.properties
idempiere --launcher.ini setup.ini -application org.adempiere.install.application -consoleLog

@Echo ErrorLevel = %ERRORLEVEL%
@IF NOT ERRORLEVEL = 1 GOTO NEXT
@Echo ***************************************
@Echo Check the error message above.
@Echo ***************************************
@Pause
@Exit

:NEXT
@REM Setup Tomcat
@Echo ... Setup Tomcat
idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

@Echo ...
@Echo For problems, check log file in base directory
@Rem Wait 10 second
@PING 1.1.1.1 -n 1 -w 10000 > NUL
