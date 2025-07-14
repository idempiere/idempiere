@Echo	Adempiere Database Export 	$Revision: 1.8 $

@Rem $Id: DBExport.bat,v 1.8 2005/04/27 17:45:01 jjanke Exp $
@Rem 
@set Date=%date:~6,4%%date:~3,2%%date:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
@Echo Saving database %1@%ADEMPIERE_DB_NAME% to %IDEMPIERE_HOME%\data\ExpDat_%Date%.dmp

@if (%IDEMPIERE_HOME%) == () goto environment
@if (%ADEMPIERE_DB_NAME%) == () goto environment
@Rem Must have parameter: userAccount
@if (%1) == () goto usage

@Rem Cleanup
@if ("%ADEMPIERE_DB_Name:~0,1%") == "@" (
    @set DB_CONNECTION="%ADEMPIERE_DB_NAME:~1%"
) else (
    @set DB_CONNECTION=%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME%
)
sqlplus -S %1/%2@%DB_CONNECTION% @%IDEMPIERE_HOME%\utils\%ADEMPIERE_DB_PATH%\Daily.sql

@echo -------------------------------------
@echo Re-Create DataPump Directory
@echo -------------------------------------
sqlplus -S %3@%DB_CONNECTION% @%IDEMPIERE_HOME%\utils\%ADEMPIERE_DB_PATH%\CreateDataPumpDir.sql %DATA_ENDPOINT% %IDEMPIERE_HOME%\data

@Rem The Export
expdp %1/%2@%DB_CONNECTION% DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=%DATA_ENDPOINT%ExpDat_%Date%.dmp LOGFILE=%DATA_ENDPOINT%ExpDat_%Date%.log EXCLUDE=STATISTICS SCHEMAS=%1 CREDENTIAL=NULL

@cd %IDEMPIERE_HOME%\Data
@jar cvfM ExpDat.jar ExpDat_%Date%.dmp ExpDat_%Date%.log

@goto end

:environment
@Echo Please make sure that the enviroment variables are set correctly:
@Echo		IDEMPIERE_HOME	e.g. D:\Adempiere
@Echo		ADEMPIERE_DB_NAME 	e.g. adempiere.adempiere.org

:usage
@echo Usage:	%0 <userAccount>
@echo Examples:	%0 adempiere adempiere

:end
