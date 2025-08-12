@Rem $Id: RUN_ImportIdempiere.bat,v 1.12 2005/01/22 21:59:15 jjanke Exp $

@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title Import idempiere - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)

SET SUFFIX=
if (%ADEMPIERE_DB_PATH%) == (postgresql) SET SUFFIX=_pg
if "%ADEMPIERE_DB_SYSTEM_USER%" == "" (
    if "%ADEMPIERE_DB_PATH%" == "postgresql" (
        SET ADEMPIERE_DB_SYSTEM_USER=postgres
    ) else (
        SET ADEMPIERE_DB_SYSTEM_USER=SYSTEM
    )
)

@echo Re-Create idempiere User and import %IDEMPIERE_HOME%\data\Adempiere.dmp - (%ADEMPIERE_DB_NAME%)
cd %IDEMPIERE_HOME%\data\seed
jar xvf Adempiere%SUFFIX%.jar
cd %IDEMPIERE_HOME%\utils
@dir %IDEMPIERE_HOME%\data\seed\Adempiere%SUFFIX%.dmp
@echo == The import will show warnings. This is OK ==
@pause

@Rem Parameter: <AdempiereID> <AdempierePwd> <systemUser> <systemPwd>
@call %ADEMPIERE_DB_PATH%\ImportIdempiere %ADEMPIERE_DB_USER% %ADEMPIERE_DB_PASSWORD% %ADEMPIERE_DB_SYSTEM_USER% %ADEMPIERE_DB_SYSTEM% %SUFFIX%

@call RUN_SyncDB

cd ..
@call sign-database-build-alt

@pause
