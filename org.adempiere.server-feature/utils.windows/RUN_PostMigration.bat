@Title ... Post Migration
@Echo off

cd %IDEMPIERE_HOME%

idempiere --launcher.ini setup.ini -application org.adempiere.base.PostMigration -consoleLog
