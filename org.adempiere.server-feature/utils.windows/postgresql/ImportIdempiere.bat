@Echo	idempiere Database Import		$Revision: 1.3 $

@Rem $Id: ImportIdempiere.bat,v 1.3 2005/01/22 21:59:15 jjanke Exp $

@Echo	Importing idempiere DB from %IDEMPIERE_HOME%\data\seed\Adempiere%5.dmp (%ADEMPIERE_DB_NAME%)

@if (%IDEMPIERE_HOME%) == () goto environment
@if (%ADEMPIERE_DB_NAME%) == () goto environment
@if (%ADEMPIERE_DB_SERVER%) == () goto environment
@if (%ADEMPIERE_DB_PORT%) == () goto environment
@Rem Must have parameters AdempiereID AdempierePwd systemUser systemPwd
@if (%1) == () goto usage
@if (%2) == () goto usage
@if (%3) == () goto usage
@if (%4) == () goto usage

@set PGPASSWORD=%4
@echo -------------------------------------
@echo Re-Create user and database
@echo -------------------------------------
@dropdb -h %ADEMPIERE_DB_SERVER% -p %ADEMPIERE_DB_PORT% -U %3 %ADEMPIERE_DB_NAME%
@dropuser -h %ADEMPIERE_DB_SERVER% -p %ADEMPIERE_DB_PORT% -U %3 %1
@set ADEMPIERE_CREATE_ROLE_SQL=CREATE ROLE %1 SUPERUSER LOGIN PASSWORD '%2'
@psql -h %ADEMPIERE_DB_SERVER% -p %ADEMPIERE_DB_PORT% -U %3 -c "%ADEMPIERE_CREATE_ROLE_SQL%" -d template1
@set ADEMPIERE_CREATE_ROLE_SQL=

@set PGPASSWORD=%2
@createdb --template=template0 -h %ADEMPIERE_DB_SERVER% -p %ADEMPIERE_DB_PORT% -E UNICODE -O %1 -U %1 %ADEMPIERE_DB_NAME%

@echo -------------------------------------
@echo Import Adempiere%5.dmp
@echo -------------------------------------
@set ADEMPIERE_ALTER_ROLE_SQL=ALTER ROLE %1 SET search_path TO adempiere, pg_catalog

@psql -h %ADEMPIERE_DB_SERVER% -p %ADEMPIERE_DB_PORT% -d %ADEMPIERE_DB_NAME% -U %1 -c "%ADEMPIERE_ALTER_ROLE_SQL%"

@psql -h %ADEMPIERE_DB_SERVER% -p %ADEMPIERE_DB_PORT% -d %ADEMPIERE_DB_NAME% -U %1 -f %IDEMPIERE_HOME%/data/seed/Adempiere%5.dmp
@set ADEMPIERE_ALTER_ROLE_SQL=


@set PGPASSWORD=
@goto end

:environment
@Echo Please make sure that the enviroment variables are set correctly:
@Echo		IDEMPIERE_HOME	e.g. D:\idempiere
@Echo		ADEMPIERE_DB_NAME 	e.g. adempiere
@Echo		ADEMPIERE_DB_SERVER 	e.g. dbserver.idempiere.org
@Echo		ADEMPIERE_DB_PORT 	e.g. 5432

:usage
@echo Usage:		%0 <AdempiereID> <AdempierePwd> <postgresUser> <PostgresPwd>
@echo Example:	%0 idempiere idempiere postgres postgresPwd

:end
