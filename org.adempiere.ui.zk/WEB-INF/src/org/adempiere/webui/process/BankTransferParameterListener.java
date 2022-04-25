/**********************************************************************
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
* - Carlos Ruiz                                                       *
**********************************************************************/

package org.adempiere.webui.process;

import org.adempiere.webui.apps.IProcessParameterListener;
import org.adempiere.webui.apps.ProcessParameterPanel;
import org.adempiere.webui.editor.WEditor;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.WrongValueException;

public class BankTransferParameterListener implements IProcessParameterListener {

	@Override
	public void onChange(ProcessParameterPanel parameterPanel, String columnName, WEditor editor) {
		if (editor.getValue() != null) {
			if ("StatementDate".equals(columnName)) {
				// set Accounting Date when StatementDate changes
				WEditor dateAcctEditor = parameterPanel.getEditor("DateAcct");
				dateAcctEditor.setValue(editor.getValue());
			} else if (   "From_C_BankAccount_ID".equals(columnName)
					   || "To_C_BankAccount_ID".equals(columnName)) {
				WEditor toBankEditor = parameterPanel.getEditor("To_C_BankAccount_ID");
				WEditor fromBankEditor = parameterPanel.getEditor("From_C_BankAccount_ID");
				if (   toBankEditor.getValue() != null && fromBankEditor.getValue() != null 
					&& fromBankEditor.getValue().equals(toBankEditor.getValue())) {
					editor.setValue(null);
					throw new WrongValueException(editor.getComponent(), Msg.getMsg(Env.getCtx(), "BankFromToMustDiffer"));
				}
			}
		}
	}

}
