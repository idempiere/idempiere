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
 * Sponsor:                                                            *
 * - FH                                                                *
 * Contributors:                                                       *
 * - Carlos Ruiz                                                       *
 **********************************************************************/

package org.adempiere.webui.process;

import org.adempiere.webui.apps.IProcessParameterListener;
import org.adempiere.webui.apps.ProcessParameterPanel;
import org.adempiere.webui.editor.WEditor;
import org.compiere.model.MMFAMethod;
import org.compiere.util.Env;

public class MFARegisterParameterListener implements IProcessParameterListener {

	@Override
	public void onChange(ProcessParameterPanel parameterPanel, String columnName, WEditor editor) {
		if (editor.getValue() != null) {
			if ("MFA_Method_ID".equals(columnName)) {
				Object value = editor.getValue();
				if (value != null && value instanceof Integer) {
					WEditor elementPrmEditor = parameterPanel.getEditor("MFA_ElementPrm_ID");
					Integer methodId = (Integer) value;
					if (methodId.intValue() > 0) {
						MMFAMethod method = new MMFAMethod(Env.getCtx(), methodId, null);
						// set Accounting Date when StatementDate changes
						elementPrmEditor.setValue(method.getMFA_ElementPrm_ID());
					} else {
						elementPrmEditor.setValue(null);
					}
				}
			}
		}
	}

}
