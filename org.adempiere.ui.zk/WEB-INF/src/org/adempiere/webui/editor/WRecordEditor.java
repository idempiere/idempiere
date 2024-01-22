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

import java.io.Serializable;

import org.adempiere.util.GridRowCtx;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.FindWindow;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WRecordIDDialog;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.ComponentCtrl;
import org.zkoss.zul.Div;

/**
 * Default editor for {@link DisplayType#RecordID} and {@link DisplayType#RecordUU}.<br/>
 * Implemented with composite component of {@link Textbox} and {@link ToolBarButton}.<br/>
 * The editor uses {@link WRecordIDDialog} for edit or viewing. 
 * @author Peter Takacs, Cloudempiere
 *
 */
public abstract class WRecordEditor<T> extends WEditor implements ContextMenuListener, IZoomableEditor {

	/** Is Read/Write enabled on the editor */
	private boolean m_ReadWrite;
	/** Record_ID or Record_UU value */
	protected Object recordIDValue;
	/** AD_Table_ID value */
	protected Object tableIDValue;

	/** Current tab's AD_Table_ID GridField */
	protected GridField tableIDGridField;
	/** Window Number */
	int windowNo;
	/** Tab Number */
	int tabNo;

	// UI components
	protected Textbox recordTextBox;
	protected ToolBarButton editButton;
	protected ToolBarButton zoomButton;

	// image url for toolbar button
	private static final String IMAGES_CONTEXT_ZOOM_PNG = "images/Zoom16.png";
	private static final String IMAGES_CONTEXT_EDIT_RECORD_PNG = "images/EditRecord16.png";

	/**
	 * Constructor
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WRecordEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new Div(), gridField, tableEditor, editorConfiguration);
		tabNo = gridTab != null ? gridTab.getTabNo() : FindWindow.TABNO;
		windowNo = gridTab != null ? gridTab.getWindowNo() : gridField.getWindowNo();
		getComponent().setSclass("recordid-editor");
		getComponent().addEventListener(Events.ON_RIGHT_CLICK, this);

		init();
	}

	/**
	 * Init component and context menu
	 */
	protected void init() {
		if(gridTab != null) {
			tableIDGridField = gridTab.getField("AD_Table_ID");

			if(tableIDGridField == null) {
				throw new RuntimeException("AD_Table_ID field not found");
			}

			tableIDGridField.addPropertyChangeListener(evt -> {
				if (GridField.PROPERTY.equals(evt.getPropertyName())) {
					tableIDValue = evt.getNewValue();
				}
			});
		} else {
			String tableIdTxt = Env.getContext(gridField.getVO().ctx, gridField.getWindowNo(), FindWindow.TABNO, "AD_Table_ID", true);
			if (!Util.isEmpty(tableIdTxt, true)) {
				tableIDValue = Integer.parseInt(tableIdTxt);
			}

			getComponent().addCallback(ComponentCtrl.AFTER_PAGE_ATTACHED, t -> afterPageAttached(t));
		}

		recordTextBox = new Textbox();
		recordTextBox.setParent(getComponent());
		recordTextBox.setWidth("100%");
		recordTextBox.setReadonly(true);

		editButton = new ToolBarButton();
		editButton.setStyle("right: 21px;");
		if (ThemeManager.isUseFontIconForImage())
			editButton.setIconSclass("z-icon-Edit");
		else
			editButton.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_EDIT_RECORD_PNG));
		editButton.setParent(getComponent());
		editButton.addEventListener(Events.ON_CLICK, this);
		editButton.setTooltiptext(Msg.getMsg(Env.getCtx(), "Edit"));

		zoomButton = new ToolBarButton();
		if (ThemeManager.isUseFontIconForImage())
			zoomButton.setIconSclass("z-icon-Zoom");
		else
			zoomButton.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_ZOOM_PNG));
		zoomButton.setParent(getComponent());
		zoomButton.addEventListener(Events.ON_CLICK, this);
		zoomButton.setTooltiptext(Msg.getMsg(Env.getCtx(), "Zoom"));

		if (gridField != null)
		{
			popupMenu = new WEditorPopupMenu(true, true, isShowPreference());
			popupMenu.addMenuListener(this);
			addChangeLogMenu(popupMenu);
		}
	}

	/**
	 * Handle AFTER_PAGE_ATTACHED callback to get AD_Table_ID grid field from find window
	 * @param t
	 */
	private void afterPageAttached(Object t) {
		if (t instanceof Component) {
			Component component = (Component) t;
			Component parent = component.getParent();
			while (parent != null) {
				if (parent instanceof FindWindow)
					break;
				parent = parent.getParent();
			}

			if (parent != null && parent instanceof FindWindow) {
				FindWindow fw = (FindWindow) parent;
				GridField field = fw.getTargetMField("AD_Table_ID");
				if (field != null) {
					//search field initialisation code duplicated from FindWindow
					field = field.clone(gridField.getVO().ctx);
					field.loadLookupNoValidate();
					Lookup lookup = field.getLookup();
					if (lookup != null && lookup instanceof MLookup)
					{
						MLookup mLookup = (MLookup) lookup;
						mLookup.getLookupInfo().tabNo = FindWindow.TABNO;

						if (field.getVO().ValidationCodeLookup != null && !field.getVO().ValidationCodeLookup.isEmpty())
						{
							mLookup.getLookupInfo().ValidationCode = field.getVO().ValidationCodeLookup;
							mLookup.getLookupInfo().IsValidated = false;
						}
					}
					tableIDGridField = field;
					if (tableIDValue != null)
						tableIDGridField.setValue(tableIDValue, false);
				}
			}
		}
	}

	/**
	 * Refresh text box display text
	 */
	private void actionRefresh()
	{
		recordTextBox.setValue(getDisplay());
	}

	@Override
	public void onMenu(ContextMenuEvent evt)
	{
		if (WEditorPopupMenu.REQUERY_EVENT.equals(evt.getContextEvent()))
		{
			actionRefresh();
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

	@Override
	public void setValue(Object value) {
		setValue(value, true);
	}

	/**
	 * 	Set Value
	 *	@param value new value
	 *	@param fire true to fire value change event
	 */	
	protected void setValue (Object value, boolean fire) {
		if (value == null || Util.isEmpty(value.toString(), true)) {
			recordTextBox.setValue("");
			value = null;
		} else {
			recordTextBox.setValue(value.toString());
			//get initial ad_table_id value
			if (tableIDValue == null && tableIDGridField != null) {
				tableIDValue = tableIDGridField.getValue();
			}
			if(value != null && tableIDValue != null) {
				int tableID = Integer.parseInt(String.valueOf(tableIDValue));
				if (tableID > 0) {
					Serializable recordID = (Serializable) toKeyValue(value);
					if(recordID != null && tableID > 0) {
						recordTextBox.setValue(MLookup.getIdentifier(tableID, recordID, tabNo, windowNo, isUseUUIDKey()));
					}
				}
			}
		}

		if (fire 
				&& 
				(     (value == null && recordIDValue != null) 
						|| (value != null && recordIDValue == null) 
						|| (value != null && !value.equals(recordIDValue))
						)) {
			// Record_ID
			ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), recordIDValue, value);
			super.fireValueChange(changeEvent);
		}
		recordIDValue = value;
	}

	@Override
	public Object getValue() {
		return recordIDValue;
	}

	@Override
	public String getDisplay() {
		if (recordIDValue == null)
			return "";
		if((tableIDValue != null) && (recordIDValue != null)) {
			int tableID;
			Serializable recordID;
			try {
				tableID = Integer.parseInt(String.valueOf(tableIDValue));
				recordID = (Serializable) toKeyValue(recordIDValue);
			} catch (NumberFormatException e) {
				return recordIDValue.toString();
			}
			return MLookup.getIdentifier(tableID, recordID, tabNo, windowNo, isUseUUIDKey());
		}
		else {
			return recordIDValue.toString();
		}
	}

	@Override
	public String getDisplayTextForGridView(GridRowCtx gridRowCtx, Object value) {
		if (value == null)
			return "";
		if (gridTab != null) {
			String key = gridTab.getWindowNo() + "|AD_Table_ID";
			Object rowTableIdValue = gridRowCtx.get(key);
			int rowTableID;
			Serializable rowRecordID;
			try {
				rowTableID = Integer.parseInt(String.valueOf(rowTableIdValue));
				rowRecordID = (Serializable) toKeyValue(value);
			} catch (NumberFormatException e) {
				return value.toString();
			}
			return MLookup.getIdentifier(rowTableID, rowRecordID, tabNo, windowNo, isUseUUIDKey());
		} else {
			return value.toString();
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getName().equalsIgnoreCase(Events.ON_CLICK)) {
			if(event.getTarget().equals(zoomButton)) {
				actionZoom();
			}
			else if(event.getTarget().equals(editButton)) {
				if (tableIDGridField != null) {
					//for find window context
					if (gridTab == null) {
						String tableIdTxt = Env.getContext(gridField.getVO().ctx, gridField.getWindowNo(), FindWindow.TABNO, "AD_Table_ID", true);
						if (!Util.isEmpty(tableIdTxt, true)) {
							tableIDValue = Integer.parseInt(tableIdTxt);
						}
					}
					if (tableIDValue != null && tableIDValue instanceof Integer) {
						String error = validateTableIdValue((int) tableIDValue);
						if (!Util.isEmpty(error)) {
							Dialog.error(tableIDGridField.getWindowNo(), error);
							return;
						}
					}
					new WRecordIDDialog(recordTextBox.getPage(), this, tableIDGridField);
				}
			}
		}
		else if(event.getName().equalsIgnoreCase(Events.ON_RIGHT_CLICK)) {
			if(event.getTarget().equals(getComponent())) {
				popupMenu.open(getComponent());
			}
		}
	}

	/**
	 * Get AD_Table_ID
	 * @return AD_Table_ID value
	 */
	public Object getAD_Table_ID() {
		return tableIDValue;
	}

	/**
	 * Set AD_Table_ID
	 * @param tableID
	 */
	public void setAD_Table_ID(Object tableID){
		// Data Binding
		// AD_Table_ID
		if (gridTab != null) {
			Object oldValue = gridTab.getValue("AD_Table_ID");
			gridTab.setValue(tableIDGridField, tableID);
			ValueChangeEvent changeEvent = new ValueChangeEvent(this, "AD_Table_ID", oldValue, tableID);
			super.fireValueChange(changeEvent);
		} else {
			ValueChangeEvent changeEvent = new ValueChangeEvent(this, "AD_Table_ID", tableIDValue, tableID);
			super.fireValueChange(changeEvent);
		}

		tableIDValue = tableID;
	}

	@Override
	public Div getComponent() {
		return (Div) super.getComponent();
	}

	/**
	 * Use UUID as key column
	 * @return Key column name
	 */
	public abstract boolean isUseUUIDKey();

	/**
	 * Convert value to key value type
	 * @param value
	 * @return key value
	 */
	public abstract T toKeyValue(Object value);

	/**
	 * Validate selected table id value
	 * @param tableId
	 * @return error message or null
	 */
	public abstract String validateTableIdValue(int tableId);		
}
