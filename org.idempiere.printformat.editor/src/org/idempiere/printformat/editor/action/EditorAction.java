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
 * - Trek Global                         							   *
 **********************************************************************/
package org.idempiere.printformat.editor.action;

import org.adempiere.webui.action.IAction;
import org.adempiere.webui.adwindow.ADWindow;
import org.compiere.util.Env;
import org.idempiere.printformat.editor.ui.WPrintFormatEditor;
import org.osgi.service.component.annotations.Component;

/**
 * @author hengsin
 *
 */
@Component(name="org.idempiere.printformat.editor.action.EditorAction", immediate = true, service = IAction.class)
public class EditorAction implements IAction {

	/**
	 * default constructor
	 */
	public EditorAction() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.action.IAction#execute(java.lang.Object)
	 */
	@Override
	public void execute(Object target) {
		ADWindow adwindow = (ADWindow) target;
		int windowNo = adwindow.getADWindowContent().getWindowNo();
		int AD_PrintFormat_ID = Env.getContextAsInt(Env.getCtx(), windowNo, "AD_PrintFormat_ID", true);
		if (AD_PrintFormat_ID > 0) {
			WPrintFormatEditor editor = new WPrintFormatEditor(AD_PrintFormat_ID, adwindow.getADWindowContent());
			editor.showEditorWindow();
		}
	}

	@Override
	public String getIconSclass() {
		return "z-icon-th-list";
	}

}
