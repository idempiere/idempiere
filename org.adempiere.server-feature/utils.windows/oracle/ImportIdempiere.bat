@Echo	idempiere Database Import		$Revision: 1.9 $

@Rem $Id: ImportIdempiere.bat,v 1.9 2005/09/24 01:50:41 jjanke Exp $

@Echo	Importing idempiere DB from %IDEMPIERE_HOME%\data\seed\Adempiere.dmp (%ADEMPIERE_DB_NAME%)

@if (%IDEMPIERE_HOME%) == () goto environment
@if (%ADEMPIERE_DB_NAME%) == () goto environment
@Rem Must have parameters systemAccount AdempiereID AdempierePwd
@if (%1) == () goto usage
@if (%2) == () goto usage
@if (%3) == () goto usage

@echo -------------------------------------
@echo Re-Create DB user
@echo -------------------------------------
@if (%ADEMPIERE_DB_SERVER%) == () (
    @set DB_CONNECTION=%ADEMPIERE_DB_NAME%
) else (
    @set DB_CONNECTION=%ADEMPIERE_DB_SERVER%:%ADEMPIERE_DB_PORT%/%ADEMPIERE_DB_NAME%
)
sqlplus -S %1@%DB_CONNECTIONE% @%IDEMPIERE_HOME%\Utils\%ADEMPIERE_DB_PATH%\CreateUser.sql %2 %3

@echo -------------------------------------
@echo Re-Create DataPump directory
@echo -------------------------------------
sqlplus -S %1@%DB_CONNECTION% @%IDEMPIERE_HOME%\Utils\%ADEMPIERE_DB_PATH%\CreateDataPumpDir.sql %SEED_ENDPOINT% %IDEMPIERE_HOME%\data\seed

@echo -------------------------------------
@echo Import Adempiere.dmp
@echo -------------------------------------
impdp %1@%DB_CONNECTION% DIRECTORY=ADEMPIERE_DATA_PUMP_DIR DUMPFILE=%SEED_ENDPOINT%Adempiere.dmp REMAP_SCHEMA=reference:%2 CREDENTIAL=NULL

@echo --------========--------========--------========--------
@echo Check System
@echo Import may show some warnings. This is OK as long as the following does not show errors
@echo --------========--------========--------========--------
sqlplus -S %2/%3@%DB_CONNECTION% @%IDEMPIERE_HOME%\Utils\%ADEMPIERE_DB_PATH%\AfterImport.sql

@goto end

:environment
@Echo Please make sure that the enviroment variables are set correctly:
@Echo		IDEMPIERE_HOME	e.g. D:\idempiere
@Echo		ADEMPIERE_DB_NAME	e.g. dev1.adempiere.org

:usage
@echo Usage:		%0 <systemAccount> <AdempiereID> <AdempierePwd>
@echo Example:	%0 system/manager idempiere idempiere

:end
