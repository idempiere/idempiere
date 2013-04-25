@Rem $Id: RUN_ImportIdempiere.bat,v 1.12 2005/01/22 21:59:15 jjanke Exp $

@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title Import idempiere - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)

SET SUFFIX=
SET SYSUSER=system
if (%ADEMPIERE_DB_PATH%) == (postgresql) SET SUFFIX=_pg
if (%ADEMPIERE_DB_PATH%) == (postgresql) SET SYSUSER=postgres

@Rem for oracle or postgres version 9.1 or higher you run this the usual way:
@Rem   RUN_ImportIdempiere.sh
@Rem for postgres versions 8.4 or 9.0 you can run this way:
@Rem   RUN_ImportIdempiere.sh 8.4
@Rem     or
@Rem   RUN_ImportIdempiere.sh 9.0
if (%1) == (8.4) SET SUFFIX=_pg84
if (%1) == (9.0) SET SUFFIX=_pg84

@echo Re-Create idempiere User and import %IDEMPIERE_HOME%\data\Adempiere.dmp - (%ADEMPIERE_DB_NAME%)
cd %IDEMPIERE_HOME%\data\seed
jar xvf Adempiere%SUFFIX%.jar
cd %IDEMPIERE_HOME%\utils
@dir %IDEMPIERE_HOME%\data\seed\Adempiere%SUFFIX%.dmp
@echo == The import will show warnings. This is OK ==
@pause

@Rem Parameter: <systemAccount> <AdempiereID> <AdempierePwd>
@Rem globalqss - cruiz - 2007-10-09 - added fourth parameter for postgres (ignored in oracle)
@call %ADEMPIERE_DB_PATH%\ImportIdempiere %SYSUSER%/%ADEMPIERE_DB_SYSTEM% %ADEMPIERE_DB_USER% %ADEMPIERE_DB_PASSWORD% %ADEMPIERE_DB_SYSTEM%

@pause
