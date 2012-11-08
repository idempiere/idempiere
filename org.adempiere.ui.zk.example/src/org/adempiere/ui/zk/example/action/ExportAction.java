/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.ui.zk.example.action;

import org.adempiere.webui.action.IAction;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.ADWindowContent;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MRole;

/**
 * @author hengsin
 *
 */
public class ExportAction implements IAction {
	
	/**
	 * default constructor
	 */
	public ExportAction() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.action.IAction#execute(java.lang.Object)
	 */
	@Override
	public void execute(Object target) {		
		ADWindow adwindow = (ADWindow) target;
		ADWindowContent panel = adwindow.getADWindowContent();
		
		if (!MRole.getDefault().isCanExport()) {
			FDialog.error(panel.getWindowNo(), "AccessTableNoView");
			return;
		}
		
		doExport(panel);
	}

	private void doExport(ADWindowContent panel) {
		ExportWindow window = new ExportWindow();
		window.init(panel);
		
		AEnv.showWindow(window);
	}	
}
