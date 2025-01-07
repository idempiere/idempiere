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
 * - Nicolas Micoud (TGI)                                              *
 **********************************************************************/

package org.adempiere.webui.process;

import org.adempiere.webui.apps.IProcessParameterListener;
import org.adempiere.webui.apps.ProcessParameterPanel;
import org.adempiere.webui.editor.WEditor;
import org.compiere.model.MModelGeneratorTemplate;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Parameter listener for generate model process
 */
public class GenerateModelParameterListener implements IProcessParameterListener {

	private static final String[] parameters = {"Folder", "PackageName", "TableLike", "TableEntityType", "ColumnEntityType"};

	@Override
	public void onChange(ProcessParameterPanel parameterPanel, String columnName, WEditor editor) {
		if (editor.getValue() != null) {
			if ("AD_ModelGeneratorTemplate_ID".equals(columnName) && !editor.isNullOrEmpty()) {

				MModelGeneratorTemplate mgt = new MModelGeneratorTemplate(Env.getCtx(), (Integer) editor.getValue(), null);
				
				for (String paramName : parameters) {
					WEditor param = parameterPanel.getEditor(paramName);
					if (param != null) {

						if (paramName.equals("TableLike"))
							paramName = "TableName";

						String rawValue = mgt.get_ValueAsString(paramName);

						if (paramName.equals("TableName") && !Util.isEmpty(rawValue) && rawValue.equals("@TableName@"))
							param.setValue(Env.getContext(Env.getCtx(), parameterPanel.getWindowNo(), "TableName"));
						else if ((paramName.equals("TableEntityType") || paramName.equals("ColumnEntityType")) && !Util.isEmpty(rawValue) && rawValue.equals("@EntityType@"))
							param.setValue(Env.getContext(Env.getCtx(), parameterPanel.getWindowNo(), "EntityType"));
						else
							param.setValue(mgt.get_Value(paramName));
					}
				}
			}
		}
	}
}
