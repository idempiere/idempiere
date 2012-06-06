@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title	Export Adempiere Database - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)
@Rem 
@Rem $Id: RUN_DBExport.bat,v 1.16 2005/04/27 17:45:02 jjanke Exp $
@Rem 
@Rem Parameter: <adempiereDBuser>/<adempiereDBpassword>

@call %ADEMPIERE_DB_PATH%\DBExportdp %ADEMPIERE_DB_USER% %ADEMPIERE_DB_PASSWORD% system/%ADEMPIERE_DB_SYSTEM%
@Rem call %ADEMPIERE_DB_PATH%\DBExportFulldp system/%ADEMPIERE_DB_SYSTEM%

@Echo If the following statement fails, fix your environment
IF (%IDEMPIERE_HOME%) == () (CALL myDBcopy.bat) else (CALL %IDEMPIERE_HOME%\utils\myDBcopy.bat)

@Rem Sleep 60
@CHOICE /C YN /T 60 /D N > NUL
