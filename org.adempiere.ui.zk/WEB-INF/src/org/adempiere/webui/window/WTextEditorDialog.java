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

import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.zkforge.ckez.CKeditor;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Vlayout;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class WTextEditorDialog extends Window implements EventListener<Event>{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3852236029054284848L;
	private boolean editable;
	private int maxSize;
	private String text;
	private boolean cancelled;
	private Tabbox tabbox;
	private Textbox textBox;
	private CKeditor editor;
	private Label status;
	private Tab htmlTab;

	/**
	 * 
	 * @param title
	 * @param text
	 * @param editable
	 * @param maxSize
	 */
	public WTextEditorDialog(String title, String text, boolean editable, int maxSize) {
		super();
		setTitle(title);
		this.editable = editable;
		this.maxSize = maxSize;
		this.text = text;
		
		init();
	}
	
	private void init() {
		setBorder("normal");
		setHeight("450px");
		setWidth("800px");
		setStyle("position: absolute;");
		setSizable(false);
		setSclass("popup-dialog");
		
		Vlayout vbox = new Vlayout();
		appendChild(vbox);
		vbox.setWidth("100%");
		vbox.setVflex("true");
		vbox.setSclass("dialog-content");
		
		tabbox = new Tabbox();
		vbox.appendChild(tabbox);
		Tabs tabs = new Tabs();
		tabbox.appendChild(tabs);
		Tabpanels tabPanels = new Tabpanels();
		tabbox.appendChild(tabPanels);
		tabbox.setVflex("1");
		tabbox.setHflex("1");
		
		Tab tab = new Tab("Text");
		tabs.appendChild(tab);
		
		Tabpanel tabPanel = new Tabpanel();
		tabPanels.appendChild(tabPanel);
		textBox = new Textbox(text);
		textBox.setCols(80);
		textBox.setRows(30);
		textBox.setHeight("100%");
		textBox.setEnabled(editable);
		textBox.setHflex("1");
		textBox.setVflex("1");
		tabPanel.appendChild(textBox);
		
		htmlTab = new Tab("HTML");
		tabs.appendChild(htmlTab);
		
		tabPanel = new Tabpanel();
		tabPanels.appendChild(tabPanel);
		if (editable) {
			createEditor(tabPanel);
		} else {
			Div div = new Div();
			div.setHeight("100%");
			div.setWidth("100%");
			div.setStyle("overflow: auto; border: 1px solid");
			tabPanel.appendChild(div);
			Html html = new Html();
			div.appendChild(html);
			html.setContent(text);
		}
		
		vbox.appendChild(new Separator());
		
		Div footer = new Div();
		footer.setSclass("dialog-footer");
		ConfirmPanel confirmPanel = new ConfirmPanel(true);
		footer.appendChild(confirmPanel);
		confirmPanel.addButton(confirmPanel.createButton(ConfirmPanel.A_RESET));
		confirmPanel.addActionListener(this);
		appendChild(footer);
		
		if (maxSize > 0) {
			status = new Label();			
			footer.appendChild(status);
			updateStatus(text.length());
			
			status.setStyle("margin-top:10px;");
			textBox.addEventListener(Events.ON_CHANGE, this);
			if (editor != null)
				editor.addEventListener(Events.ON_CHANGE, this);
		}		
		
		tabbox.addEventListener(Events.ON_SELECT, this);
	}

	private void createEditor(org.zkoss.zul.Tabpanel tabPanel) {
		editor = new CKeditor();
		editor.setCustomConfigurationsPath("/js/ckeditor/config.js");
		editor.setToolbar("MyToolbar");
		tabPanel.appendChild(editor);
		editor.setVflex("1");
		editor.setWidth("100%");
		editor.setValue(text);
	}

	public void onEditorCallback(Event event) {
		text = (String) event.getData();
		detach();
	}
	
	/**
	 * @param event
	 */
	public void onEvent(Event event) throws Exception {
		if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL)) {
			cancelled = true;
			detach();
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			if (editable) {
				if (tabbox.getSelectedIndex() == 0) {
					text = textBox.getText();
					detach();
				} else {
					String script = "var w=zk('#"+editor.getUuid()+"').$();var d=w.getEditor().getData();var t=zk('#" +
							this.getUuid()+"').$();var e=new zk.Event(t,'onEditorCallback',d,{toServer:true});zAu.send(e);";
					Clients.response(new AuScript(script));
				}
					
			}			
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_RESET)) {
			textBox.setText(text);
			editor.setValue(text);
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
	
	private void updateStatus(int newLength) {
		if (status != null && maxSize > 0) {
			StringBuilder msg = new StringBuilder();
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
	
	/**
	 * 
	 * @return boolean
	 */
	public boolean isCancelled() {
		return cancelled;
	}
	
	/**
	 * 
	 * @return text
	 */
	public String getText() {
		return text;
	}

}
