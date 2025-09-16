@Rem $Id: RUN_ImportReference.bat,v 1.11 2005/01/22 21:59:15 jjanke Exp $

@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title Import Reference - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)


@echo Re-Create Reference User and import %IDEMPIERE_HOME%\data\Adempiere.dmp - (%ADEMPIERE_DB_NAME%)
@dir %IDEMPIERE_HOME%\data\Adempiere.dmp
@echo == The import will show warnings. This is OK ==
@pause

@Rem Parameter: <AdempiereID> <AdempierePwd> <systemUser> <systemPwd>
@if "%ADEMPIERE_DB_SYSTEM_USER%" == "" (set "ADEMPIERE_DB_SYSTEM_USER=SYSTEM")
@call %ADEMPIERE_DB_PATH%\ImportIdempiere reference reference %ADEMPIERE_DB_SYSTEM_USER% %ADEMPIERE_DB_SYSTEM%

@pause
