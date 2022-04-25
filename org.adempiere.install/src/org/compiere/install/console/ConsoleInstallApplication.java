/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.compiere.install.console;

import java.io.File;
import java.util.logging.Level;

import org.apache.tools.ant.DefaultLogger;
import org.apache.tools.ant.Project;
import org.compiere.util.CLogMgt;
import org.compiere.util.CLogger;
import org.eclipse.ant.core.AntRunner;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

/**
 * @author hengsin
 *
 */
public class ConsoleInstallApplication implements IApplication {

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#start(org.eclipse.equinox.app.IApplicationContext)
	 */
	@Override
	public Object start(IApplicationContext context) throws Exception {
		CLogMgt.initialize(false);
		String[] args = (String[]) context.getArguments().get(IApplicationContext.APPLICATION_ARGS);

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

		ConfigurationConsole console = new ConfigurationConsole();
		console.doSetup();
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
		return ConsoleInstallApplication.EXIT_OK;
	}

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#stop()
	 */
	@Override
	public void stop() {
	}
}
