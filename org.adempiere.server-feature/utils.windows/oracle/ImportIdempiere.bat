@Echo	idempiere Database Import		$Revision: 1.9 $

@Rem $Id: ImportIdempiere.bat,v 1.9 2005/09/24 01:50:41 jjanke Exp $

@Echo	Importing idempiere DB from %IDEMPIERE_HOME%\data\seed\Adempiere.dmp (%ADEMPIERE_DB_NAME%)

@if (%IDEMPIERE_HOME%) == () goto environment
@if (%ADEMPIERE_DB_NAME%) == () goto environment
@if (%ADEMPIERE_DB_SERVER%) == () goto environment
@if (%ADEMPIERE_DB_PORT%) == () goto environment
@Rem Must have parameters AdempiereID AdempierePwd systemUser systemPwd
@if (%1) == () goto usage
@if (%2) == () goto usage
@if (%3) == () goto usage
@if (%4) == () goto usage

@echo -------------------------------------
@echo Re-Create DB user
@echo -------------------------------------
@sqlplus -S %3/%4@%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME% @%IDEMPIERE_HOME%\Utils\%ADEMPIERE_DB_PATH%\CreateUser.sql %1 %2

@echo -------------------------------------
@echo Re-Create DataPump directory
@echo -------------------------------------
@sqlplus -S %3/%4@%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME% @%IDEMPIERE_HOME%\Utils\%ADEMPIERE_DB_PATH%\CreateDataPumpDir.sql %IDEMPIERE_HOME%\data\seed

@echo -------------------------------------
@echo Import Adempiere.dmp
@echo -------------------------------------
@impdp %3/%4@%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME% DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=Adempiere.dmp REMAP_SCHEMA=reference:%1

@echo --------========--------========--------========--------
@echo Check System
@echo Import may show some warnings. This is OK as long as the following does not show errors
@echo --------========--------========--------========--------
@sqlplus -S %1/%2@%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME% @%IDEMPIERE_HOME%\Utils\%ADEMPIERE_DB_PATH%\AfterImport.sql

@goto end

:environment
@Echo Please make sure that the enviroment variables are set correctly:
@Echo		IDEMPIERE_HOME	e.g. D:\idempiere
@Echo		ADEMPIERE_DB_NAME	e.g. dev1.adempiere.org

:usage
@echo Usage:		%0 <AdempiereID> <AdempierePwd> <systemUser> <systemPwd>
@echo Example:	%0 idempiere idempiere system manager

:end
