@Echo	Adempiere Full Database Export 	$Revision: 1.6 $

@Rem $Id: DBExportFull.bat,v 1.6 2005/04/27 17:45:01 jjanke Exp $
@set Date=%date:~6,4%%date:~3,2%%date:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
@Echo Saving database %1@%ADEMPIERE_DB_NAME% to %IDEMPIERE_HOME%\data\ExpDatFull_%Date%.dmp

@if (%IDEMPIERE_HOME%) == () goto environment
@if (%ADEMPIERE_DB_NAME%) == () goto environment
@if (%ADEMPIERE_DB_SERVER%) == () goto environment
@if (%ADEMPIERE_DB_PORT%) == () goto environment
@Rem Must have parameter: systemAccount
@if (%1) == () goto usage

@echo -------------------------------------
@echo Re-Create DataPump Directory
@echo -------------------------------------
@sqlplus -S %1@%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME% @%IDEMPIERE_HOME%\utils\%ADEMPIERE_DB_PATH%\CreateDataPumpDir.sql %IDEMPIERE_HOME%\data

@expdp %1@%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME% DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=ExpDatFull_%Date%.dmp LOGFILE=ExpDatFull_%Date%.log EXCLUDE=STATISTICS FULL=Y

@cd %IDEMPIERE_HOME%\data
@jar cvfM data\ExpDatFull.jar ExpDatFull_%Date%.dmp  ExpDatFull_%Date%.log

@goto end

:environment
@Echo Please make sure that the enviroment variables are set correctly:
@Echo		IDEMPIERE_HOME	e.g. D:\Adempiere
@Echo		ADEMPIERE_DB_NAME	e.g. dev1.adempiere.org

:usage
@echo Usage:	%0 <systemAccount>
@echo Examples:	%0 system/manager

:end
