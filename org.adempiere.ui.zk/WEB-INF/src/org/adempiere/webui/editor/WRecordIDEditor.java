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
 * Default editor for {@link DisplayType#RecordID}.<br/>
 * Implemented with composite component of {@link Textbox} and {@link ToolBarButton}.<br/>
 * The editor uses {@link WRecordIDDialog} for edit or viewing. 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class WRecordIDEditor extends WRecordEditor<Integer> {

	/**
	 * Constructor
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WRecordIDEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(gridField, tableEditor, editorConfiguration);
	}

	@Override
	public void actionZoom()
	{
		String s = tableIDValue != null ? String.valueOf(tableIDValue) : "";
		int tableID = s.length() > 0 ? Integer.parseInt(s) : 0;
		s = recordIDValue != null ? String.valueOf(recordIDValue) : "";
		int recordID = s.length() > 0 ? Integer.parseInt(s) : 0;
		if(tableID <= 0 || recordID < 0)
			return;
		if (!MRole.getDefault().isTableAccess(tableID, false))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "AccessTableNoView"));
		AEnv.zoom(tableID, recordID);
	}

	@Override
	public void propertyChange(PropertyChangeEvent evt)
	{
		if (GridField.PROPERTY.equals(evt.getPropertyName()))
		{
			int tableID =  tableIDValue != null ? Integer.parseInt(String.valueOf(tableIDValue)) : 0;
			if (tableID > 0) {
				MTable table = MTable.get(tableID);
				int recordID = Integer.parseInt(Objects.toString(evt.getNewValue(), "-1"));
				if (tableID > 0 && recordID >= 0)
					table.getPO(recordID, null);	// calls po.checkCrossTenant() method
			}
			setValue(evt.getNewValue(), false);
		}
	}

	@Override
	public Integer toKeyValue(Object value) {
		return value != null ? Integer.parseInt(String.valueOf(value)) : null;
	}

	@Override
	public boolean isUseUUIDKey() {
		return false;
	}

	@Override
	public String validateTableIdValue(int tableId) {
		MTable table = MTable.get(tableId);
		if (table.isUUIDKeyTable())
			return "UUTableNotCompatibleWithRecordID";
		if (! table.isIDKeyTable())
			return "TableHasNoKeyColumn";
		return null;
	}
}
