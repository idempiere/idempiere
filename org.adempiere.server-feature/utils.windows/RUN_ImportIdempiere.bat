@Rem $Id: RUN_ImportIdempiere.bat,v 1.12 2005/01/22 21:59:15 jjanke Exp $

@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title Import idempiere - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)


@echo Re-Create idempiere User and import %IDEMPIERE_HOME%\data\Adempiere.dmp - (%ADEMPIERE_DB_NAME%)
@dir %IDEMPIERE_HOME%\data\Adempiere.dmp
@echo == The import will show warnings. This is OK ==
@pause

@Rem Parameter: <systemAccount> <AdempiereID> <AdempierePwd>
@Rem globalqss - cruiz - 2007-10-09 - added fourth parameter for postgres (ignored in oracle)
@call %ADEMPIERE_DB_PATH%\ImportIdempiere system/%ADEMPIERE_DB_SYSTEM% %ADEMPIERE_DB_USER% %ADEMPIERE_DB_PASSWORD% %ADEMPIERE_DB_SYSTEM%

@pause
