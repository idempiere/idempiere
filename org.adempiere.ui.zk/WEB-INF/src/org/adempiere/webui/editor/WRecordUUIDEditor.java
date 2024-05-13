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
* - Igor Pojzl, Cloudempiere                                          *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.adempiere.webui.editor;

import java.beans.PropertyChangeEvent;
import java.util.Objects;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.window.WRecordIDDialog;
import org.compiere.model.GridField;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Default editor for {@link DisplayType#RecordUU}.<br/>
 * Implemented with composite component of {@link Textbox} and {@link ToolBarButton}.<br/>
 * The editor uses {@link WRecordIDDialog} for edit or viewing. 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class WRecordUUIDEditor extends WRecordEditor<String> {

	/**
	 * Constructor
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WRecordUUIDEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(gridField, tableEditor, editorConfiguration);
	}

	@Override
	public void actionZoom()
	{
		String s = tableIDValue != null ? String.valueOf(tableIDValue) : "";
		int tableID = s.length() > 0 ? Integer.parseInt(s) : 0;
		String recordUU = recordIDValue != null ? recordIDValue.toString() : "";
		if(tableID <= 0)
			return;
		if (!MRole.getDefault().isTableAccess(tableID, false))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "AccessTableNoView"));
		AEnv.zoomUU(tableID, recordUU);
	}

	@Override
	public void propertyChange(PropertyChangeEvent evt)
	{
		if (GridField.PROPERTY.equals(evt.getPropertyName()))
		{
			int tableID =  tableIDValue != null ? Integer.parseInt(String.valueOf(tableIDValue)) : 0;
			if (tableID > 0) {
				MTable table = MTable.get(tableID);
				String recordUU = Objects.toString(evt.getNewValue(), "");
				if (tableID > 0 && recordUU.length() > 0)
					table.getPOByUU(recordUU, null);	// calls po.checkCrossTenant() method

			}
			setValue(evt.getNewValue(), false);
		}
	}

	@Override
	public String toKeyValue(Object value) {
		return value != null ? value.toString() : null;
	}

	@Override
	public boolean isUseUUIDKey() {
		return true;
	}

	@Override
	public String validateTableIdValue(int tableId) {
		MTable table = MTable.get(tableId);
		if (! table.hasUUIDKey())
			return "TableHasNoKeyColumn";
		return null;		
	}
}
