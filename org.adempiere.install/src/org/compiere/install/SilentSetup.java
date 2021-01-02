package org.compiere.install;

import java.io.File;
import java.util.logging.Level;

import org.apache.tools.ant.Main;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.Ini;

@Deprecated
public class SilentSetup {

	public SilentSetup()
	{
		//Load C:\idempiere\idempiereEnv.properties
		String adempiereHome = System.getProperty(ConfigurationData.IDEMPIERE_HOME);
		if (adempiereHome == null || adempiereHome.length() == 0)
			adempiereHome = System.getProperty("user.dir");

//		boolean envLoaded = false;
		String fileName = adempiereHome + File.separator + ConfigurationData.IDEMPIERE_ENV_FILE;
		File env = new File(fileName);
		if (!env.exists())
		{
			System.err.println("Usage: Please edit idempiereEnvTemplate.properties and save as idempiereEnv.properties");
			return;
		}

		Ini.setShowLicenseDialog(false);
		ConfigurationData data = new ConfigurationData(null);
		if (!data.load()) return;
		if (!data.test(null))
		{
			System.err.println("");
			System.err.println("Warning: One or more of the configuration test failed.");
			System.err.println("");
		}
		if (!data.save()) return;

		/**	Run Ant	**/
		try
		{
			CLogger.get().info("Starting Ant ... ");
			System.setProperty("ant.home", ".");
			String[] 	args = new String[] {"setup"};
		//	Launcher.main (args);	//	calls System.exit
			Main antMain = new Main();
			antMain.startAnt(args, null, null);
		}
		catch (Exception e)
		{
			CLogger.get().log(Level.SEVERE, "ant", e);
		}
	}

	/**
	 * 	Start
	 * 	@param args Log Level e.g. ALL, FINE
	 */
	public static void main(String[] args)
	{
		CLogMgt.initialize(false);
		// Duplicate log file - not required
		// Handler fileHandler = new CLogFile(System.getProperty("user.dir"), false, false);
		// CLogMgt.addHandler(fileHandler);
		//	Log Level
		if (args.length > 0)
			CLogMgt.setLevel(args[0]);
		else
			CLogMgt.setLevel(Level.INFO);
		//	File Logger at least FINE
		// if (fileHandler.getLevel().intValue() > Level.FINE.intValue())
		//	fileHandler.setLevel(Level.FINE);

		new SilentSetup();
	}
}
