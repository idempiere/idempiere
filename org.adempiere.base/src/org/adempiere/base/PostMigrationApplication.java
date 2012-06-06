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
package org.adempiere.base;

import java.util.logging.Level;

import org.adempiere.util.ProcessUtil;
import org.compiere.Adempiere;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogMgt;
import org.compiere.util.Env;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

/**
 * @author hengsin
 *
 */
public class PostMigrationApplication implements IApplication {

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#start(org.eclipse.equinox.app.IApplicationContext)
	 */
	@Override
	public Object start(IApplicationContext context) throws Exception {
		Adempiere.startup(false);
		CLogMgt.setLevel(Level.FINE);
		addMissingTranslation();
		roleAccessUpdate();
		checkSequence();
		
		return IApplication.EXIT_OK;
	}

	private void checkSequence() {
		ProcessInfo pi = new ProcessInfo("Sequence Check", 258);
		pi.setAD_Client_ID(0);
		pi.setAD_User_ID(100);
		pi.setClassName("org.compiere.process.SequenceCheck");
		ProcessUtil.startJavaProcess(Env.getCtx(), pi, null);
	}

	private void roleAccessUpdate() {
		ProcessInfo pi = new ProcessInfo("Role Access Update", 295);
		pi.setAD_Client_ID(0);
		pi.setAD_User_ID(100);
		pi.setClassName("org.compiere.process.RoleAccessUpdate");
		ProcessUtil.startJavaProcess(Env.getCtx(), pi, null);
	}

	private void addMissingTranslation() {
		ProcessInfo pi = new ProcessInfo("Synchronize Terminology", 172);
		pi.setAD_Client_ID(0);
		pi.setAD_User_ID(100);
		pi.setClassName("org.compiere.process.SynchronizeTerminology");
		ProcessUtil.startJavaProcess(Env.getCtx(), pi, null);
	}

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#stop()
	 */
	@Override
	public void stop() {
	}

}
