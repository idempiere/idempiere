@Title ... Setup idempiere Server
@Rem  $Header: /cvsroot/adempiere/install/Adempiere/RUN_setup.bat,v 1.19 2005/09/08 21:54:12 jjanke Exp $
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
@"%JAVA%" -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=setup -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.adempiere.install.application -consoleLog

@Echo ErrorLevel = %ERRORLEVEL%
@IF NOT ERRORLEVEL = 1 GOTO NEXT
@Echo ***************************************
@Echo Check the error message above.
@Echo ***************************************
@Pause
@Exit

:NEXT
@REM setup tomcat
@Echo ... Setup Tomcat
@"%JAVA%" -Dosgi.noShutdown=false -Dosgi.compatibility.bootdelegation=true -Dosgi.install.area=setup -jar plugins/org.eclipse.osgi_3.7.*.jar -application org.eclipse.ant.core.antRunner -buildfile build.xml

@Echo ...
@Echo For problems, check log file in base directory
@Rem Wait 10 second
@PING 1.1.1.1 -n 1 -w 10000 > NUL
