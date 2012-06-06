@echo off

REM Adempiere_Service_Uninstall.bat - globalqss - based on http://javaservice.objectweb.org

if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)

NET STOP Adempiere
%IDEMPIERE_HOME%\utils\windows\AdempiereService.exe -uninstall Adempiere
