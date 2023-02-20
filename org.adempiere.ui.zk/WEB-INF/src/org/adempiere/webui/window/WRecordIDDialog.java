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

import java.util.Objects;

import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WRecordIDEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.factory.ButtonFactory;
import org.compiere.model.GridField;
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
public class WRecordIDDialog extends Window implements EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8126107952514403099L;
	
	/** Page for the window */
	private Page page;
	/** Record_ID editor from which the window is opened */
	private WRecordIDEditor editor;
	/** Current tab's AD_Table_ID GrodField */
	private GridField tableIDGridField;
	/** Current value (Record_ID) */
	private Integer recordIDValue;
	
	// UI components
	private Div contentDiv;
	private Div labelsDiv;
	private Div fieldsDiv;
	private Div confirmPanelDiv;
	private WTableDirEditor tableIDEditor;
	private Button okBtn;
	private Button cancelBtn;
	private Textbox parentTextBox;
	private WSearchEditor recordsEditor;
	
	/**
	 * Constructor
	 * @param page
	 * @param editor
	 * @param tableIDGridField
	 */
	public WRecordIDDialog(Page page, WRecordIDEditor editor, GridField tableIDGridField) {
		super();
		
		this.page = page;
		this.editor = editor;
		this.tableIDGridField = tableIDGridField;
		if(editor.getValue() instanceof String)
			this.recordIDValue = Integer.valueOf((String)editor.getValue());
		else
			this.recordIDValue = (Integer)editor.getValue();
		
		init();
	}
	
	private void init() {
		Vlayout vLayout = new Vlayout();
		labelsDiv = new Div();
		fieldsDiv = new Div();
		contentDiv = new Div();
		confirmPanelDiv = new Div();
    	okBtn = ButtonFactory.createNamedButton(ConfirmPanel.A_OK, true, true);
    	cancelBtn = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL, true, true);;
    	tableIDEditor = new WTableDirEditor("AD_Table_ID", false, false, true, tableIDGridField.getLookup(), true);
		tableIDEditor.setValue(tableIDGridField.getValue());
		editor.setAD_Table_ID(tableIDGridField.getValue());
		int tableID = Integer.parseInt(String.valueOf(tableIDGridField.getValue()));
    	recordsEditor = new WSearchEditor("Record_ID", false, false, true, editor.getRecordsLookup(tableID));
    	parentTextBox = new Textbox();
    	
		setPage(page);
		setClosable(true);
		setTitle(Msg.getMsg(Env.getCtx(), "ChooseRelatedRecord"));
		setPosition("center");
		setSclass("recordid-dialog");
		
		contentDiv.setSclass("recordid-dialog-content");
		confirmPanelDiv.setSclass("recordid-dialog-confirm");
		
		parentTextBox.setReadonly(true);
		parentTextBox.setValue(editor.getIdentifier(
				editor.getGridField().getGridTab().getAD_Table_ID(), editor.getGridField().getGridTab().getRecord_ID()));
		
		tableIDEditor.getComponent().addEventListener(Events.ON_SELECT, this);
		
		recordsEditor.setValue(recordIDValue);
		
		okBtn.addEventListener(Events.ON_CLICK, this);
		okBtn.setSclass("recordid-dialog-confirm");
		cancelBtn.addEventListener(Events.ON_CLICK, this);
		cancelBtn.setSclass("recordid-dialog-confirm");
		
		Text text = new Text(Msg.getMsg(Env.getCtx(), "Parent"));
		labelsDiv.appendChild(text);
		text = new Text(Msg.getMsg(Env.getCtx(), "Table"));
		labelsDiv.appendChild(text);
		text = new Text(Msg.getMsg(Env.getCtx(), "Record"));
		labelsDiv.appendChild(text);
		labelsDiv.setSclass("recordid-dialog-labels");
		
		fieldsDiv.setSclass("recordid-dialog-fields");
		
		fieldsDiv.appendChild(parentTextBox);
		fieldsDiv.appendChild(tableIDEditor.getComponent());
		fieldsDiv.appendChild(recordsEditor.getComponent());
		
		contentDiv.appendChild(labelsDiv);
		contentDiv.appendChild(fieldsDiv);
		
		confirmPanelDiv.appendChild(okBtn);
		confirmPanelDiv.appendChild(cancelBtn);
		
		vLayout.appendChild(contentDiv);
		vLayout.appendChild(confirmPanelDiv);
		
		appendChild(vLayout);
		doHighlighted();
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getName().equalsIgnoreCase(Events.ON_CLICK)) {
			if(event.getTarget().equals(okBtn)) {
				// set the selected values to the editors
				recordIDValue = (Integer) recordsEditor.getValue();
				tableIDGridField.getGridTab().setValue("AD_Table_ID", tableIDEditor.getValue());
				editor.setAD_Table_ID(tableIDGridField.getValue());
				editor.setValue(recordIDValue);
				onClose();
			}
			else if(event.getTarget().equals(cancelBtn)) {
				// dismiss the selected values
				onClose();
			}
		}
		if(event.getName().equalsIgnoreCase(Events.ON_SELECT)) {
			if (event.getTarget().equals(tableIDEditor.getComponent())) {
				// the Record_ID should be cleared when a different AD_Table_ID is selected
				recordsEditor.getComponent().detach();
				int tableID = Integer.parseInt(Objects.toString(tableIDEditor.getValue(), "-1"));
				if(tableID > 0) {
			    	recordsEditor = new WSearchEditor("Record_ID", false, false, true, editor.getRecordsLookup(tableID));
					fieldsDiv.appendChild(recordsEditor.getComponent());
				}
			}
		}
	}
}
