@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title Stop Adempiere  - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)

@Rem $Id: RUN_Stop.bat,v 1.11 2005/01/22 21:59:15 jjanke Exp $

@CALL %IDEMPIERE_HOME%\utils\RUN_Server2Stop.bat

@CALL %ADEMPIERE_DB_PATH%\Stop.bat

