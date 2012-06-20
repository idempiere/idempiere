@echo off

REM Adempiere_Service_Uninstall.bat - globalqss - based on http://javaservice.objectweb.org

if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)

NET STOP idempiere
%IDEMPIERE_HOME%\utils\windows\idempiereService.exe -uninstall idempiere
