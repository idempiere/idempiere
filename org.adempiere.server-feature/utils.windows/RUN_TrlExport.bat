@Rem $Id: RUN_TrlExport.bat,v 1.4 2005/09/16 00:49:37 jjanke Exp $

@if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)
@Title Export Translation - %IDEMPIERE_HOME% (%ADEMPIERE_DB_NAME%)

@SET AD_LANGUAGE=es_CO
@SET DIRECTORY=%IDEMPIERE_HOME%\data\%AD_LANGUAGE%

@echo This Procedure exports language %AD_LANGUAGE% into directory %DIRECTORY%
@pause

FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
@"%JAVA_HOME%\bin\java" -Dosgi.compatibility.bootdelegation=true -Dosgi.noShutdown=false -jar %JARFILE% -application org.adempiere.install.translation export %DIRECTORY% %AD_LANGUAGE%

@pause
