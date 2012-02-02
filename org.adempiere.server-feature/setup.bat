@Title ... Setup Adempiere Server
@Echo off

@REM Setup Adempiere.properties and AdempiereEnv.properties
adempiere --launcher.ini setup.ini -application org.adempiere.install.application -consoleLog

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
adempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

@Echo ...
@Echo For problems, check log file in base directory
@Rem Wait 10 second
@PING 1.1.1.1 -n 1 -w 10000 > NUL
