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
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/
package org.adempiere.base;

import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.Adempiere;
import org.compiere.model.MPInstance;
import org.compiere.model.SystemIDs;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogMgt;
import org.compiere.util.Env;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

/**
 * @author Carlos Ruiz (globalqss)
 *
 */
public class PackInFolderApplication implements IApplication {

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#start(org.eclipse.equinox.app.IApplicationContext)
	 */
	@Override
	public Object start(IApplicationContext context) throws Exception {
		Adempiere.startup(false);
		String logLevel = System.getProperty("LogLevel");
		if (logLevel == null)
			logLevel = "INFO";
		switch (logLevel) {
		case "SEVERE":	CLogMgt.setLevel(Level.SEVERE); break;
		case "WARNING":	CLogMgt.setLevel(Level.WARNING); break;
		case "INFO":	CLogMgt.setLevel(Level.INFO); break;
		case "CONFIG":	CLogMgt.setLevel(Level.CONFIG); break;
		case "FINE":	CLogMgt.setLevel(Level.FINE); break;
		case "FINER": 	CLogMgt.setLevel(Level.FINER); break;
		case "FINEST": 	CLogMgt.setLevel(Level.FINEST); break;
		default:		CLogMgt.setLevel(Level.INFO); break;
		}
		Map<?, ?> args = context.getArguments();
		String commandlineArgs[] = (String[]) args.get("application.args");
		if (commandlineArgs.length == 1) {
			Properties ctx = Env.getCtx();
			Env.setContext(ctx, "org.adempiere.base.PackInFolderApplication", "Y");
			String directory = commandlineArgs[0];
			ProcessInfo pi = new ProcessInfo("PackInFolder", 200099);
			pi.setAD_Client_ID(0);
			pi.setAD_User_ID(SystemIDs.USER_SUPERUSER);
			MPInstance instance = new MPInstance(ctx, 200099, 0);
			instance.saveEx();
			instance.createParameter(10, "Folder", directory);
			pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());
			ProcessCall process = Core.getProcess("org.adempiere.pipo2.PackInFolder");
			boolean success = process.startProcess(ctx, pi, null);
			ProcessInfoUtil.setLogFromDB(pi);
			StringBuilder msgout = new StringBuilder("Process=").append(pi.getTitle())
					.append("\n Error=").append(pi.isError())
					.append("\n Summary=").append(pi.getSummary())
					.append("\n Logs=\n").append(pi.getLogInfo(false).replaceAll("<br>", "\n"));
			System.out.println(msgout.toString());
			if (!success)
				return Integer.valueOf(1);
		} else {
			System.out.println("Apply PackIn from Folder usage:");
			System.out.println("RUN_ApplyPackInFromFolder.sh folder");
			return Integer.valueOf(1);
		}
		
		
		return IApplication.EXIT_OK;
	}

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#stop()
	 */
	@Override
	public void stop() {
	}

}
