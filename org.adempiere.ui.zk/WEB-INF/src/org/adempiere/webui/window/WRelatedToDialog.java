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
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.adempiere.webui.window;

import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WRecordIDEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.factory.ButtonFactory;
import org.compiere.model.GridField;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MTable;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Vlayout;

/**
 * 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class WRelatedToDialog extends Window implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8126107952514403099L;
	
	private Page page;
	private WRecordIDEditor editor;
	private GridField tableIDGridField;
	
	private Div contentDiv;
	private Div labelsDiv;
	private Div fieldsDiv;
	private Div confirmPanelDiv;
	private WTableDirEditor tableIDEditorCopy;
	
	private Button okBtn;
	private Button cancelBtn;
	private Textbox parentTextBox;
	private WSearchEditor recordsEditor;
	
	private Integer value;
	
	public WRelatedToDialog(Page page, WRecordIDEditor editor, GridField tableIDGridField) {
		super();
		
		this.page = page;
		this.editor = editor;
		this.tableIDGridField = tableIDGridField;
		if(editor.getValue() instanceof String)
			this.value = Integer.valueOf((String)editor.getValue());
		else
			this.value = (Integer)editor.getValue();
		
		init();
	}
	
	private void init() {
		Vlayout vLayout = new Vlayout();
		labelsDiv = new Div();
		fieldsDiv = new Div();
		contentDiv = new Div();
		confirmPanelDiv = new Div();
    	okBtn = ButtonFactory.createNamedButton(ConfirmPanel.A_OK, true, true);;
    	cancelBtn = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL, true, true);;
    	tableIDEditorCopy = new WTableDirEditor("AD_Table_ID", false, false, true, tableIDGridField.getLookup(), true);
		tableIDEditorCopy.setValue(tableIDGridField.getValue());
    	recordsEditor = new WSearchEditor("Record_ID", false, false, true, getRecordsLookup());
    	parentTextBox = new Textbox();
    	
		setPage(page);
		setClosable(true);
		setTitle(Msg.getMsg(Env.getCtx(), "ChooseRelatedRecord"));
		setPosition("center");
		setSclass("related-to-dialog");
		doHighlighted();
		
		contentDiv.setSclass("related-to-dialog-content");
		confirmPanelDiv.setSclass("related-to-dialog-confirm");
		
		parentTextBox.setReadonly(true);
		parentTextBox.setValue(WRecordIDEditor.getIdentifierColumns(
				editor.getGridField().getGridTab().getAD_Table_ID(), editor.getGridField().getGridTab().getRecord_ID()));
		
		tableIDEditorCopy.getComponent().addEventListener(Events.ON_SELECT, this);
		
		recordsEditor.setValue(value);
		
		okBtn.addEventListener(Events.ON_CLICK, this);
		okBtn.setSclass("related-to-dialog-confirm");
		cancelBtn.addEventListener(Events.ON_CLICK, this);
		cancelBtn.setSclass("related-to-dialog-confirm");
		
		Text text = new Text(Msg.getMsg(Env.getCtx(), "Parent"));
		labelsDiv.appendChild(text);
		text = new Text(Msg.getMsg(Env.getCtx(), "Table"));
		labelsDiv.appendChild(text);
		text = new Text(Msg.getMsg(Env.getCtx(), "Record"));
		labelsDiv.appendChild(text);
		labelsDiv.setSclass("related-to-dialog-labels");
		
		fieldsDiv.setSclass("related-to-dialog-fields");
		
		fieldsDiv.appendChild(parentTextBox);
		fieldsDiv.appendChild(tableIDEditorCopy.getComponent());
		fieldsDiv.appendChild(recordsEditor.getComponent());
		
		contentDiv.appendChild(labelsDiv);
		contentDiv.appendChild(fieldsDiv);
		
		confirmPanelDiv.appendChild(okBtn);
		confirmPanelDiv.appendChild(cancelBtn);
		
		vLayout.appendChild(contentDiv);
		vLayout.appendChild(confirmPanelDiv);
		
		appendChild(vLayout);
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getName().equalsIgnoreCase(Events.ON_CLICK)) {
			if(event.getTarget().equals(okBtn)) {
				value = (Integer) recordsEditor.getValue();
				tableIDGridField.getGridTab().setValue("AD_Table_ID", tableIDEditorCopy.getValue());
				editor.setValue(value);
				onClose();
			}
			else if(event.getTarget().equals(cancelBtn)) {
				onClose();
			}
		}
		if(event.getName().equalsIgnoreCase(Events.ON_SELECT)) {
			if (event.getTarget().equals(tableIDEditorCopy.getComponent())) {
				recordsEditor.getComponent().detach();
				recordsEditor = new WSearchEditor("Record_ID", false, false, true, getRecordsLookup());
				fieldsDiv.appendChild(recordsEditor.getComponent());
			}
		}
	}
	
	private MLookup getRecordsLookup() {
		if(tableIDEditorCopy == null || tableIDEditorCopy.getValue() == null)
			return null;
		MTable mTable = MTable.get(Env.getCtx(), (int)tableIDEditorCopy.getValue(), null);
		String[] keyColumns = mTable.getKeyColumns();
		String keyColumn = "";
		if(keyColumns.length > 0)
			keyColumn = keyColumns[0];
		MColumn mColumn = MColumn.get(Env.getCtx(), mTable.getTableName(), keyColumn);
			
		int tabNo = editor.getGridField().getGridTab().getTabNo();
		int windowNo = editor.getGridField().getGridTab().getWindowNo();
		MLookupInfo lookupInfo = MLookupFactory.getLookupInfo (Env.getCtx(), windowNo, tabNo, mColumn.getAD_Column_ID(), DisplayType.Search);
		return new MLookup(lookupInfo, tabNo);
    }
}
