@echo off

REM idempiere_Service_Install.bat - globalqss - based on http://javaservice.objectweb.org

if (%IDEMPIERE_HOME%) == () (CALL myEnvironment.bat Server) else (CALL %IDEMPIERE_HOME%\utils\myEnvironment.bat Server)

%IDEMPIERE_HOME%\utils\windows\idempiereService.exe -install idempiere "%JAVA_HOME%\jre\bin\server\jvm.dll" -Xmx256M -server %ADEMPIERE_JAVA_OPTIONS% -start idempiere -stop -method systemExit -out "%IDEMPIERE_HOME%\out.txt" -current "%IDEMPIERE_HOME%" -manual -overwrite -description "iDempiere server"

rem IT DEPENDS ON OTHER SERVICE?
rem add this option for dependency with postgresql service (replace with proper service name)
rem    -depends pgsql-8.4
rem add this option for dependency with oracle service (replace with proper service name)
rem    -depends oraclexe
rem NOTE: The -depends parameter must be put before -manual or -automatic parameter

rem DO YOU WANT AUTOMATIC STARTUP?
rem replace -manual by -auto to make service run automatically on system startup

rem other usefult options can be:
rem -err err_log_file
rem -shutdown seconds
rem -user user_name
rem -password password
rem -append or -overwrite
rem -description service_desc
