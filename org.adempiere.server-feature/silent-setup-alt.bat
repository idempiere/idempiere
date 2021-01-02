@Title Install idempiere Server Silently
@Echo off


@if not "%JAVA_HOME%" == "" goto JAVA_HOME_OK
@Set JAVA=java
@Echo JAVA_HOME is not set.
@Echo You may not be able to start the required Setup window !!
@Echo Set JAVA_HOME to the directory of your local 1.5 JDK.
@Echo If you experience problems, run utils/WinEnv.js
@Echo Example: cscript utils\WinEnv.js C:\Adempiere "C:\Program Files\Java\jdk1.5.0_04"
goto START

:JAVA_HOME_OK
@Set JAVA=%JAVA_HOME%\bin\java


:START
@REM Setup idempiere.properties and idempiereEnv.properties
FOR %%c in (plugins\org.eclipse.equinox.launcher_1.*.jar) DO set JARFILE=%%c
@"%JAVA%" -jar %JARFILE% -install setup -configuration setup/configuration -application org.adempiere.install.silent-application

@Echo ErrorLevel = %ERRORLEVEL%
@IF NOT ERRORLEVEL = 1 GOTO NEXT
@Echo ***************************************
@Echo Check the error message above.
@Echo ***************************************
@Pause
@Exit

:NEXT
@REM setup jetty
@"%JAVA%" -jar %JARFILE% -install setup -configuration setup/configuration -application org.eclipse.ant.core.antRunner -buildfile build.xml

@Echo .
@Echo For problems, check log file in base directory
