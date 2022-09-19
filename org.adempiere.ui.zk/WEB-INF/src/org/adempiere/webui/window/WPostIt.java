/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.window;

import java.util.HashMap;
import java.util.Map;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.VerticalBox;
import org.adempiere.webui.component.Window;
import org.compiere.model.MPostIt;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.zkforge.ckez.CKeditor;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Separator;

/**
 * bas� sur WTextEditorDialog
 * @author Nico
 *
 */
public class WPostIt extends Window implements EventListener<Event>{

	private static final long serialVersionUID = -3852236029054284848L;
	private boolean editable;
	private int maxSize;
	private String note;
	private Tabbox tabbox;
	private Textbox textBox;
	private CKeditor editor;
	private Label status;
	private Label createdBox;
	private Label updatedBox;
	private String created;
	private String updated;
	private MPostIt m_postIt;

	/**
	 * @param title
	 * @param postItID
	 * @param tableID
	 * @param recordID
	 * @param trxName
	 */
	public WPostIt(String title, int postItID, int tableID, int recordID, /*String created, String updated,*/ String trxName) {
		super();
		setTitle(title);
		this.editable = true;
		this.maxSize = 2000;

		if (postItID > 0)
			m_postIt = new MPostIt (Env.getCtx(), postItID, trxName);
		else
			m_postIt = new MPostIt (Env.getCtx(), tableID, recordID, trxName);

		String created = null;
		if (m_postIt.getAD_PostIt_ID() > 0)
			created = m_postIt.getCreatedString();
		String updated = m_postIt.getUpdatedString();

		this.created = created;
		this.updated = updated;
		this.note = m_postIt.getText();

		init();
	}

	private void init() {
		setBorder("normal");
		setMaximizable(true);

		VerticalBox vbox = new VerticalBox();
		appendChild(vbox);

		tabbox = new Tabbox();
		tabbox.setMaximalHeight(true);
		vbox.appendChild(tabbox);
		Tabs tabs = new Tabs();
		tabbox.appendChild(tabs);
		Tabpanels tabPanels = new Tabpanels();
		tabbox.appendChild(tabPanels);

		Tab tab = new Tab("Text");
		tabs.appendChild(tab);

		Tabpanel tabPanel = new Tabpanel();
		tabPanels.appendChild(tabPanel);
		textBox = new Textbox(note);
		textBox.setCols(80);
		textBox.setMultiline(true);
		textBox.setEnabled(editable);
		if (ClientInfo.minWidth(730))
			textBox.setWidth("700px");
		else
			textBox.setWidth(ClientInfo.get().desktopWidth-30 + "px");
		if (ClientInfo.minHeight(700))
			textBox.setHeight("500px");
		else
			textBox.setHeight(ClientInfo.get().desktopHeight-190 +"px");
		tabPanel.appendChild(textBox);

		tab = new Tab("HTML");
		tabs.appendChild(tab);

		tabPanel = new Tabpanel();
		tabPanels.appendChild(tabPanel);

		editor = new CKeditor();
		tabPanel.appendChild(editor);
		if (ClientInfo.minWidth(730))
			editor.setWidth("700px");
		else
			editor.setWidth(ClientInfo.get().desktopWidth-30 + "px");
		editor.setVflex("1");
		editor.setValue(note);
		if (ClientInfo.isMobile())
			editor.setCustomConfigurationsPath("/js/ckeditor/config-min.js");
		else
			editor.setCustomConfigurationsPath("/js/ckeditor/config.js");
		editor.setToolbar("MyToolbar");
		Map<String,Object> lang = new HashMap<String,Object>();
		lang.put("language", Language.getLoginLanguage().getAD_Language());
		editor.setConfig(lang);

		vbox.appendChild(new Separator());
		createdBox = new Label();	
		createdBox.setText(created);
		vbox.appendChild(createdBox);
		updatedBox = new Label();	
		updatedBox.setText(updated);
		vbox.appendChild(updatedBox);

		vbox.appendChild(new Separator());

		ConfirmPanel confirmPanel = new ConfirmPanel(true);
		vbox.appendChild(confirmPanel);
		confirmPanel.addActionListener(this);

		if (maxSize > 0) {
			status = new Label();			
			appendChild(status);
			updateStatus(note==null ? 0 : note.length());

			status.setStyle("margin-top:10px;");
			textBox.addEventListener(Events.ON_CHANGE, this);
			editor.addEventListener(Events.ON_CHANGE, this);
		}		

		tabbox.addEventListener(Events.ON_SELECT, this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}

	/**
	 * @param event
	 */
	public void onEvent(Event event) throws Exception {
		if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL)) {
			onCancel();
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			if (editable) {
				String text = tabbox.getSelectedIndex() == 0 ? textBox.getText() : editor.getValue();
				m_postIt.setText(text);
				m_postIt.saveEx();
			}
			detach();
		} else if (event.getName().equals(Events.ON_SELECT)) {
			if (editable) {
				if (tabbox.getSelectedIndex() == 0) {
					textBox.setText(editor.getValue());
					updateStatus(textBox.getText().length());
				} else {
					editor.setValue(textBox.getText());
					updateStatus(editor.getValue().length());
				}
			}
		} else if (event.getName().equals(Events.ON_CHANGE)) {
			if (event.getTarget() == textBox) {
				updateStatus(textBox.getText().length());
			} else if (event.getTarget() == editor) {
				updateStatus(editor.getValue().length());
			}
		}		
	}

	private void onCancel() {
		detach();
	}

	private void updateStatus(int newLength) {
		if (status != null && maxSize > 0) {
			StringBuffer msg = new StringBuffer();
			msg.append(newLength);
			if (newLength == maxSize)
				msg.append(" = ");
			else if (newLength < maxSize)
				msg.append(" < ");
			else
				msg.append(" > ");
			msg.append(maxSize);

			status.setValue(msg.toString());	
		}
	}

	public void showWindow() 
	{		
		textBox.focus();
	}
}
