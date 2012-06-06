@Title Set Windows Environment
@Rem $Id: RUN_WinEnvTemplate.bat,v 1.4 2005/09/08 21:56:00 jjanke Exp $

@Echo ===================================
@Echo Setup Client Environment
@Echo ===================================

@cscript //nologo @IDEMPIERE_HOME@\utils\WinEnv.js "@IDEMPIERE_HOME@" "@JAVA_HOME@"

