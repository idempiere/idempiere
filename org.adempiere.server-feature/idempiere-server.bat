@Echo off


@if not "%JAVA_HOME%" == "" goto JAVA_HOME_OK
@Set JAVA=java
@Echo JAVA_HOME is not set.
@Echo You may not be able to start the server
@Echo Set JAVA_HOME to the directory of your local 1.6 JDK.
goto START

:JAVA_HOME_OK
@Set JAVA=%JAVA_HOME%\bin\java


:START
@Echo =======================================
@Echo Starting iDempiere Server ...
@Echo =======================================

@"%JAVA%" -Dosgi.compatibility.bootdelegation=true -Dosgi.noShutdown=true -Dosgi.framework.activeThreadType=normal -XX:MaxPermSize=192m -jar plugins/org.eclipse.equinox.launcher_1.*.jar -console 12612 -application org.adempiere.server.application
