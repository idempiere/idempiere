/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/

package org.compiere.install;

import java.io.File;
import java.util.logging.Level;

import org.apache.tools.ant.DefaultLogger;
import org.apache.tools.ant.Project;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.compiere.util.Ini;
import org.eclipse.ant.core.AntRunner;

public class SilentSetup {

	public SilentSetup()
	{
		//Load C:\idempiere\idempiereEnv.properties
		String adempiereHome = System.getProperty(ConfigurationData.IDEMPIERE_HOME);
		if (adempiereHome == null || adempiereHome.length() == 0)
			adempiereHome = System.getProperty("user.dir");

		String fileName = adempiereHome + File.separator + ConfigurationData.IDEMPIERE_ENV_FILE;
		File env = new File(fileName);
		if (!env.exists())
		{
			CLogger.get().severe("Usage: Please edit idempiereEnvTemplate.properties and save as idempiereEnv.properties");
			return;
		}

		Ini.setShowLicenseDialog(false);
		ConfigurationData data = new ConfigurationData(null);
		if (!data.load())
			return;
		if (!data.test(null))
		{
			CLogger.get().severe("");
			CLogger.get().severe("ERROR: One or more of the configuration test failed.");
			CLogger.get().severe("");
			return;
		}
		if (!data.save())
			return;

		/**	Run Ant	**/
		try
		{
			String path = System.getProperty("user.dir") + "/org.adempiere.install/build.xml";
			File file = new File(path);
			System.out.println("file="+path+" exists="+file.exists());
			//only exists if it is running from development environment
			if (file.exists()) {
				AntRunner runner = new AntRunner();
				runner.setBuildFileLocation(path);
				runner.setMessageOutputLevel(Project.MSG_VERBOSE);
				runner.addBuildLogger(DefaultLogger.class.getName());
				runner.run();
				runner.stop();
			}
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

		//	Log Level
		Level logLevel = Level.INFO;
		if (args.length > 0) {
			try {
				logLevel = Level.parse(args[0]);
			} catch (IllegalArgumentException e) {
				CLogger.get().warning("Unrecognized log level: " + args[0] + " defaulting to: " + logLevel);
			}
		}
		CLogMgt.setLevel(logLevel);

		new SilentSetup();
	}
}
