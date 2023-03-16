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
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WRecordIDEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.factory.ButtonFactory;
import org.compiere.model.GridField;
import org.compiere.model.MLookup;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.WrongValueException;
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
public class WRecordIDDialog extends Window implements EventListener<Event>, ValueChangeListener {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8126107952514403099L;
	
	/** Record_ID editor from which the window is opened */
	private WRecordIDEditor editor;
	/** Current tab's AD_Table_ID GrodField */
	private GridField tableIDGridField;
	/** Current Record_ID value from {@link #editor} */
	private Integer recordIDValue;
	/** Current AD_Table_ID value from {@link #editor} */
	private Integer tableIDValue;
	
	// UI components
	private Div contentDiv;
	private Div labelsDiv;
	private Div fieldsDiv;
	private Div confirmPanelDiv;
	private WEditor tableIDEditor;
	private Button okBtn;
	private Button cancelBtn;
	private Textbox parentTextBox;
	private WSearchEditor recordsEditor;
	private Text recordsEditorLabel;
	
	/**
	 * Constructor
	 * @param page
	 * @param editor
	 * @param tableIDGridField
	 */
	public WRecordIDDialog(Page page, WRecordIDEditor editor, GridField tableIDGridField) {
		super();
		
		this.editor = editor;
		this.tableIDGridField = tableIDGridField;
		if(editor.getValue() instanceof Integer) {
			this.recordIDValue = (Integer)editor.getValue();
		} else {
			if (editor.getValue() == null)
				this.recordIDValue = null;
			else
				this.recordIDValue = Integer.valueOf(editor.getValue().toString());
		}

		if (editor.getAD_Table_ID() instanceof Integer) {
			tableIDValue = (Integer) editor.getAD_Table_ID();
		} else {
			if (editor.getAD_Table_ID() == null)
				tableIDValue = null;
			else
				tableIDValue = Integer.valueOf(editor.getAD_Table_ID().toString());
		}

		init(page);
	}
	
	private void init(Page page) {
		Vlayout vLayout = new Vlayout();
		labelsDiv = new Div();
		fieldsDiv = new Div();
		contentDiv = new Div();
		confirmPanelDiv = new Div();
    	okBtn = ButtonFactory.createNamedButton(ConfirmPanel.A_OK, true, true);
    	cancelBtn = ButtonFactory.createNamedButton(ConfirmPanel.A_CANCEL, true, true);
    	
    	if(DisplayType.Search == tableIDGridField.getDisplayType()) {
    		tableIDEditor = new WSearchEditor("AD_Table_ID", false, false, true, tableIDGridField.getLookup());
    	}
    	else {
    		tableIDEditor = new WTableDirEditor("AD_Table_ID", false, false, true, tableIDGridField.getLookup(), true);
    	}
    	tableIDEditor.addValueChangeListener(this);
		tableIDEditor.setValue(tableIDValue);
		
		int tableID = tableIDValue != null ? tableIDValue.intValue() : 0;
		MLookup recordsLookup = editor.getRecordsLookup(tableID);
		if(recordsLookup != null)
			recordsEditor = new WSearchEditor("Record_ID", false, false, true, recordsLookup);
		
		setPage(page);
		setClosable(true);
		setTitle(Msg.getMsg(Env.getCtx(), "ChooseRelatedRecord"));
		setPosition("center");
		setSclass("recordid-dialog");
		
		contentDiv.setSclass("recordid-dialog-content");
		confirmPanelDiv.setSclass("recordid-dialog-confirm");
		
		if (editor.getGridField().getGridTab() != null) {
			parentTextBox = new Textbox();
			parentTextBox.setReadonly(true);
			parentTextBox.setValue(editor.getIdentifier(
					editor.getGridField().getGridTab().getAD_Table_ID(), editor.getGridField().getGridTab().getRecord_ID()));
		}
		
		if (recordsEditor != null)
			recordsEditor.setValue(recordIDValue);
		
		okBtn.addEventListener(Events.ON_CLICK, this);
		okBtn.setSclass("recordid-dialog-confirm");
		cancelBtn.addEventListener(Events.ON_CLICK, this);
		cancelBtn.setSclass("recordid-dialog-confirm");
		
		if (parentTextBox != null) {
			Text text = new Text(Msg.getMsg(Env.getCtx(), "Parent"));
			labelsDiv.appendChild(text);
		}
		Text text = new Text(Msg.getMsg(Env.getCtx(), "Table"));
		labelsDiv.appendChild(text);
		recordsEditorLabel = new Text(Msg.getMsg(Env.getCtx(), "Record"));
		if (recordsEditor != null)
			labelsDiv.appendChild(recordsEditorLabel);
		labelsDiv.setSclass("recordid-dialog-labels");
		
		fieldsDiv.setSclass("recordid-dialog-fields");
		
		if (parentTextBox != null)
			fieldsDiv.appendChild(parentTextBox);
		fieldsDiv.appendChild(tableIDEditor.getComponent());
		if (recordsEditor != null)
			fieldsDiv.appendChild(recordsEditor.getComponent());
		
		contentDiv.appendChild(labelsDiv);
		contentDiv.appendChild(fieldsDiv);
		
		confirmPanelDiv.appendChild(okBtn);
		confirmPanelDiv.appendChild(cancelBtn);
		
		vLayout.appendChild(contentDiv);
		vLayout.appendChild(confirmPanelDiv);
		
		appendChild(vLayout);
		doHighlighted();
		
		if(tableIDEditor.getComponent() instanceof HtmlBasedComponent)
			((HtmlBasedComponent) tableIDEditor.getComponent()).focus();
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getName().equalsIgnoreCase(Events.ON_CLICK)) {
			if(event.getTarget().equals(okBtn)) {
				// set the selected values to the editors
				editor.setAD_Table_ID(tableIDEditor.getValue());
				if(recordsEditor != null)
					editor.setValue(recordsEditor.getValue());
				onClose();
			}
			else if(event.getTarget().equals(cancelBtn)) {
				// dismiss the selected values
				onClose();
			}
		}
	}
	
	@Override
	public void valueChange(ValueChangeEvent evt) {
		if (evt.getSource().equals(tableIDEditor)) {
			// the Record_ID should be cleared when a different AD_Table_ID is selected
			if (recordsEditor != null) {
				recordsEditor.setValue(null);
				recordsEditorLabel.detach();
				recordsEditor.getComponent().detach();
			}
			int tableID = Integer.parseInt(Objects.toString(evt.getNewValue(), "-1"));
			
			MLookup recordsLookup = editor.getRecordsLookup(tableID);
			if(recordsLookup != null) {
				recordsEditor = new WSearchEditor("Record_ID", false, false, true, recordsLookup);
		    	labelsDiv.appendChild(recordsEditorLabel);
				fieldsDiv.appendChild(recordsEditor.getComponent());
				recordsEditor.getComponent().focus();
			}
			else if(tableID > 0) {
				throw new WrongValueException(tableIDEditor.getComponent(), Msg.getMsg(Env.getCtx(), "TableHasNoKeyColumn"));
			}
			else if(tableIDEditor.getComponent() instanceof HtmlBasedComponent) {
				((HtmlBasedComponent) tableIDEditor.getComponent()).focus();
			}
		}
	}
}
