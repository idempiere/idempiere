@Title Install idempiere Server Silently
@Echo off


@REM Setup idempiere.properties and idempiereEnv.properties
idempiere --launcher.ini setup.ini -application org.adempiere.install.silent-application

@Echo ErrorLevel = %ERRORLEVEL%
@IF NOT ERRORLEVEL = 1 GOTO NEXT
@Echo ***************************************
@Echo Check the error message above.
@Echo ***************************************
@Pause
@Exit

:NEXT
@REM Setup Jetty
idempiere --launcher.ini setup.ini -application org.eclipse.ant.core.antRunner -buildfile build.xml

@Echo .
@Echo For problems, check log file in base directory
