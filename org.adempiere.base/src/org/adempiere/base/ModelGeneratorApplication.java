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

import java.util.Map;

import org.adempiere.util.ModelClassGenerator;
import org.adempiere.util.ModelGeneratorDialog;
import org.adempiere.util.ModelInterfaceGenerator;
import org.compiere.Adempiere;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;

/**
 * @author hengsin
 * @author tbayen - command line start
 *
 */
public class ModelGeneratorApplication implements IApplication {

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.app.IApplication#start(org.eclipse.equinox.app.IApplicationContext)
	 */
	@Override
	public Object start(IApplicationContext context) throws Exception {
		Adempiere.startup(false);
		Map<?, ?> args = context.getArguments();
		// IDEMPIERE-1686 - GenerateModel does not take commandline arguments
		String commandlineArgs[] = (String[]) args.get("application.args");
		if (commandlineArgs.length >= 4) {
			String folder = commandlineArgs[0];
			String packageName = commandlineArgs[1];
			String entityType = commandlineArgs[2];
			String tableName = commandlineArgs[3];
			String columnEntityType = null;
			if (commandlineArgs.length >= 5) 
				columnEntityType = commandlineArgs[4];
			ModelInterfaceGenerator.generateSource(folder, packageName, entityType, tableName, columnEntityType);
			ModelClassGenerator.generateSource(folder, packageName, entityType, tableName, columnEntityType);
		} else if (commandlineArgs.length != 0) {
			System.out.println("usage: ModelGenerator folder packageName tableEntityType tableName columnEntityType");
		} else {
			ModelGeneratorDialog dialog = new ModelGeneratorDialog();
			dialog.setModal(true);
			dialog.pack();
			dialog.setLocationRelativeTo(null);
			dialog.setVisible(true);
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
