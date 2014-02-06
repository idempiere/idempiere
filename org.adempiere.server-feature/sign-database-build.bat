@Title Sign Database Build
@Echo off


@REM Sign Database Build
idempiere --launcher.ini setup.ini -application org.adempiere.base.SignDatabaseBuildApplication

@Echo ErrorLevel = %ERRORLEVEL%
@IF NOT ERRORLEVEL = 1 GOTO NEXT
@Echo ***************************************
@Echo Check the error message above.
@Echo ***************************************
@Pause
@Exit

@Echo .
@Echo For problems, check log file in base directory
@Rem Wait 10 second
@PING 1.1.1.1 -n 1 -w 10000 > NUL
