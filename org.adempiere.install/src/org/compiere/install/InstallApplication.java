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
package org.compiere.install;

import java.io.File;

import org.apache.tools.ant.DefaultLogger;
import org.apache.tools.ant.Project;
import org.eclipse.ant.core.AntRunner;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

/**
 *
 * @author hengsin
 *
 */
public class InstallApplication implements IApplication {

	public Object start(IApplicationContext context) throws Exception {
		Setup.main(new String[]{});
		Thread.sleep(10000);
		while (Setup.instance.isDisplayable()) {
			Thread.sleep(2000);
		}
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
		return null;
	}

	public void stop() {
	}

}
