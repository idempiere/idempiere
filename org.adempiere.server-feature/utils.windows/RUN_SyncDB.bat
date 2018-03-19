@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title	Synchronize iDempiere Database - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)

@call %ADEMPIERE_DB_PATH%\SyncDB %ADEMPIERE_DB_USER% %ADEMPIERE_DB_PASSWORD% %ADEMPIERE_DB_PATH%
