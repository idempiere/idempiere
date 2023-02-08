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
import java.beans.PropertyChangeListener;
import java.util.ArrayList;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.GridTabDataBinder;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WRecordIDDialog;
import org.compiere.model.GridField;
import org.compiere.model.MColumn;
import org.compiere.model.MQuery;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Vlayout;

/**
 * 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class WRecordIDEditor extends WEditor implements ContextMenuListener, IZoomableEditor {
	
	private boolean m_ReadWrite;
	private Object oldValue;
	private Object oldTableID;
	
	private GridField tableIDGridField;
	private WEditor tableIDEditor;
	private GridTabDataBinder dataBinder;
	
	private Div wrapperDiv;
	private Textbox recordTextBox;
	private ToolBarButton editButton;
	private ToolBarButton zoomButton;
	
	protected String selectedTableName = "";
	protected String selectedRecordIdentifyer = "";
	
	private static final String IMAGES_CONTEXT_ZOOM_PNG = "images/Zoom16.png";
	private static final String IMAGES_CONTEXT_EDIT_RECORD_PNG = "images/EditRecord16.png";

	public WRecordIDEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new Vlayout(), gridField, tableEditor, editorConfiguration);
		init();
	}

	private void init() {
		wrapperDiv = new Div();
		wrapperDiv.setSclass("recordid-editor");
		wrapperDiv.setParent(this.getComponent());
		wrapperDiv.addEventListener(Events.ON_RIGHT_CLICK, this);

		if(gridTab != null) {
			tableIDGridField = gridTab.getField("AD_Table_ID");
			tableIDEditor = WebEditorFactory.getEditor(tableIDGridField, true);
			
			if(tableIDGridField.getValue() != null)
				tableIDEditor.setValue(tableIDGridField.getValue());
						
			dataBinder = new GridTabDataBinder(gridTab);
			tableIDEditor.addValueChangeListener(dataBinder);
			
			tableIDGridField.addPropertyChangeListener(tableIDEditor);
			tableIDGridField.addPropertyChangeListener(new PropertyChangeListener() {
				@Override
				public void propertyChange(PropertyChangeEvent evt) {
					if(evt.getNewValue() != oldTableID) {
						oldTableID = evt.getNewValue();
						setValue(oldValue);
					}
				}
			});
			tableIDEditor.getComponent().addEventListener(Events.ON_SELECT, this);
			oldTableID = tableIDGridField.getValue();
		}
		
		recordTextBox = new Textbox();
		recordTextBox.setParent(wrapperDiv);
		recordTextBox.setWidth("100%");
		recordTextBox.setReadonly(true);
		
		editButton = new ToolBarButton();
		editButton.setStyle("right: 21px;");
		if (ThemeManager.isUseFontIconForImage())
			editButton.setIconSclass("z-icon-Edit");
		else
			editButton.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_EDIT_RECORD_PNG));
		editButton.setParent(wrapperDiv);
		editButton.addEventListener(Events.ON_CLICK, this);

		zoomButton = new ToolBarButton();
		if (ThemeManager.isUseFontIconForImage())
			zoomButton.setIconSclass("z-icon-Zoom");
		else
			zoomButton.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_ZOOM_PNG));
		zoomButton.setParent(wrapperDiv);
		zoomButton.addEventListener(Events.ON_CLICK, this);
		
		if (gridField != null)
        {
			popupMenu = new WEditorPopupMenu(true, true, isShowPreference());
			popupMenu.addMenuListener(this);
			addChangeLogMenu(popupMenu);
        }
	}
	
	public void actionRefresh(Object value)
    {
		setValue(value);
    }
	
	@Override
	public void actionZoom()
	{
		MTable savedTable = new MTable(Env.getCtx(), (Integer) tableIDGridField.getValue(), null);
	
		String[] keyColumns = savedTable.getKeyColumns();
		String keyColumn = null;
		if(keyColumns.length > 0) {
			keyColumn = keyColumns[0];	//	guess
		}
	
		String where = keyColumn + "=" + gridTab.getValue("Record_ID");
		PO po = new Query(Env.getCtx(), savedTable, where, null).first();
		boolean isSOTrx = true;
		if(po.columnExists("IsSOTrx")) {
			isSOTrx = po.get_ValueAsBoolean("IsSOTrx");
		}
		int AD_Window_ID;
		if(isSOTrx)
			AD_Window_ID = savedTable.getAD_Window_ID();
		else
			AD_Window_ID = savedTable.getPO_Window_ID();

		if (AD_Window_ID > 0) {
			if(!Util.isEmpty(keyColumn)) {
				MQuery zoomQuery = new MQuery();
				zoomQuery.addRestriction(keyColumn, MQuery.EQUAL, (Integer)po.get_Value(keyColumn));
				zoomQuery.setRecordCount(1);
	
				AEnv.zoom(AD_Window_ID, zoomQuery);
			}
		}
	}

	@Override
	public void onMenu(ContextMenuEvent evt)
	{
		if (WEditorPopupMenu.REQUERY_EVENT.equals(evt.getContextEvent()))
		{
			actionRefresh(oldValue);
		}
		else if (WEditorPopupMenu.ZOOM_EVENT.equals(evt.getContextEvent()))
		{
			actionZoom();
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		} 
		else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), gridField, getValue());
		}
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		m_ReadWrite = readWrite;
		if(editButton != null)
			editButton.setDisabled(!readWrite);
		
	}

	@Override
	public boolean isReadWrite() {
		return m_ReadWrite;
	}

	public  void propertyChange(PropertyChangeEvent evt)
	{
		if ("FieldValue".equals(evt.getPropertyName()))
		{
			setValue(evt.getNewValue());
		}
	}
	
	@Override
	public void setValue(Object value) {
		if (value == null || value.toString().trim().length() == 0)
		{
			oldValue = null;
			value = null;
			recordTextBox.setValue("");
		}
		else {
			if(oldTableID != tableIDGridField.getValue()) {
				oldTableID = tableIDGridField.getValue();
			}
			if(value != null && oldTableID != null) {
				Integer recordID = Integer.parseInt(String.valueOf(value));
				Integer tableID = Integer.parseInt(String.valueOf(oldTableID));
				if(recordID != null && tableID != null)
					recordTextBox.setValue(getIdentifierColumns(tableID, recordID));
			}
		}

		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, value);
        super.fireValueChange(changeEvent);
		oldValue = value;

	}

	@Override
	public Object getValue() {
		return oldValue;
	}

	@Override
	public String getDisplay() {
		if(((Integer) tableIDGridField.getValue() != null) && ((Integer) gridField.getValue() != null))
			return getIdentifierColumns((Integer) tableIDGridField.getValue(), (Integer) gridField.getValue());
		else
			return "";
	}
	
	@Override
    public String getDisplayTextForGridView(Object value) {
		String s = "";
		if(value != null &&  value.equals(gridField.getValue())) {
			this.setValue(value);
			s = getDisplay();
			if ("<0>".equals(s)) {
			s = "";
			}
		}
		else {
			this.setValue(value);
			s = "<"+value+">";
		}
		return s;
    }

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getName().equalsIgnoreCase(Events.ON_CLICK)) {
			if(event.getTarget().equals(zoomButton)) {
				actionZoom();
			}
			else if(event.getTarget().equals(editButton)) {
				new WRecordIDDialog(recordTextBox.getPage(), this, tableIDGridField);
			}
		}
		else if(event.getName().equalsIgnoreCase(Events.ON_RIGHT_CLICK)) {
			if(event.getTarget().equals(wrapperDiv)) {
				popupMenu.open(wrapperDiv);
			}
		}
	}

	/**
	 * Get Identifier String from AD_Table_ID and Record_ID
	 * @param tableID
	 * @param recordID
	 * @return String
	 */
	public static String getIdentifierColumns(int tableID, int recordID) {
		String value = String.valueOf(tableID);
		if ((tableID > 0) && (recordID > 0)) {
			MTable mTable = MTable.get(Env.getCtx(), tableID);
			String tableName = mTable.getTableName();
			
			ArrayList<MColumn> list = new ArrayList<MColumn>();
			for (String idColumnName : mTable.getIdentifierColumns()) {
				MColumn column = mTable.getColumn(idColumnName);
				list.add (column);
			}
			if(list.size() > 0) {
				StringBuilder displayColumn = new StringBuilder();
				String separator = MSysConfig.getValue(MSysConfig.IDENTIFIER_SEPARATOR, "_", Env.getAD_Client_ID(Env.getCtx()));
				
				for(int i = 0; i < list.size(); i++) {
					MColumn identifierColumn = list.get(i);
					if(i > 0)
						displayColumn.append("||'").append(separator).append("'||");
					
					displayColumn.append("NVL(")
								.append(DB.TO_CHAR(identifierColumn.getColumnName(),
													identifierColumn.getAD_Reference_ID(),
													Env.getAD_Language(Env.getCtx())))
								.append(",'')");
				}
				StringBuilder sql = new StringBuilder("SELECT ");
				sql.append(displayColumn.toString());
				sql.append(" FROM ").append(tableName);
				sql.append(" WHERE ")
					.append(tableName).append(".").append(tableName).append("_ID=?");
				
				value = DB.getSQLValueStringEx(null, sql.toString(), recordID);
			}
		}
		return value;
    }
}
