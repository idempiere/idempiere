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
import org.adempiere.webui.component.Window;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.Language;
import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;
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
	private static final long serialVersionUID = -1857623453350849161L;

	private boolean editable;
	private int maxSize;
	private String text;
	private boolean cancelled;
	private Tabbox tabbox;
	private Textbox textBox;
	private CKeditor editor;
	private Label status;
	private Tab htmlTab;
	private boolean isShowHTMLTab = true;

	/**
	 * 
	 * @param title
	 * @param text
	 * @param editable
	 * @param maxSize
	 * @param IsHtml - select the html tab at start
	 */
	public WTextEditorDialog(String title, String text, boolean editable, int maxSize, boolean IsHtml) {
		this(title, text, editable, maxSize, IsHtml, true);
	}
	
	/**
	 * @param title
	 * @param text
	 * @param editable
	 * @param maxSize
	 * @param IsHtml - select the html tab at start
	 * @param IsShowHTMLTab - Is to shown HTML tab
	 */
	public WTextEditorDialog(String title, String text, boolean editable, int maxSize,boolean IsHtml, boolean IsShowHTMLTab) {
		super();
		setTitle(title);
		this.editable = editable;
		this.maxSize = maxSize;
		this.text = text;
		this.isShowHTMLTab = IsShowHTMLTab;
		
		init();
		if (IsHtml && IsShowHTMLTab)
			tabbox.setSelectedTab(htmlTab);
	}

	public WTextEditorDialog(String title, String text, boolean editable, int maxSize) {
		this(title, text, editable, maxSize, false);
	}

	private void init() {
		setBorder("normal");
		if (ThemeManager.isUseCSSForWindowSize()) {
			ZKUpdateUtil.setWindowHeightX(this, 450);
			ZKUpdateUtil.setWindowWidthX(this, 800);
		}
		setStyle("position: absolute;");
		setSizable(false);
		setSclass("popup-dialog text-editor-dialog");
		
		Vlayout vbox = new Vlayout();
		appendChild(vbox);
		ZKUpdateUtil.setWidth(vbox, "100%");
		ZKUpdateUtil.setVflex(vbox, "true");
		vbox.setSclass("dialog-content");
		
		tabbox = new Tabbox();
		vbox.appendChild(tabbox);
		Tabs tabs = new Tabs();
		tabbox.appendChild(tabs);
		Tabpanels tabPanels = new Tabpanels();
		tabbox.appendChild(tabPanels);
		ZKUpdateUtil.setVflex(tabbox, "1");
		ZKUpdateUtil.setHflex(tabbox, "1");
		
		Tab tab = new Tab("Text");
		tabs.appendChild(tab);
		
		Tabpanel tabPanel = new Tabpanel();
		tabPanels.appendChild(tabPanel);
		textBox = new Textbox(text);
		textBox.setCols(80);
		textBox.setMultiline(true);
		ZKUpdateUtil.setHeight(textBox, "100%");
		textBox.setEnabled(editable);
		ZKUpdateUtil.setHflex(textBox, "1");
		ZKUpdateUtil.setVflex(textBox, "1");
		tabPanel.appendChild(textBox);
		
		if (isShowHTMLTab) {
			htmlTab = new Tab("HTML");
			tabs.appendChild(htmlTab);

			tabPanel = new Tabpanel();
			tabPanels.appendChild(tabPanel);
			if (editable) {
				createEditor(tabPanel);
			} else {
				Div div = new Div();
			ZKUpdateUtil.setHeight(div, "100%");
			ZKUpdateUtil.setWidth(div, "100%");
				div.setStyle("overflow: auto; border: 1px solid");
				tabPanel.appendChild(div);
				Html html = new Html();
				div.appendChild(html);
				html.setContent(text);
			}
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
			if (isShowHTMLTab && editor != null)
				editor.addEventListener(Events.ON_CHANGE, this);
		}		
		
		tabbox.addEventListener(Events.ON_SELECT, this);
		//Bug IDEMPIERE-1992 Ensure that text editor dialog has a close button
		setClosable(true);
		setSizable(true);
		setMaximizable(true);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
		addEventListener(Events.ON_SIZE, e -> onSize());
		addEventListener(Events.ON_MAXIMIZE, e -> onSize());
	}

	private void createEditor(org.zkoss.zul.Tabpanel tabPanel) {		
		editor = new CKeditor();
		if (ClientInfo.isMobile())
			editor.setCustomConfigurationsPath("/js/ckeditor/config-min.js");
		else
			editor.setCustomConfigurationsPath("/js/ckeditor/config.js");
		editor.setToolbar("MyToolbar");
		Map<String,Object> lang = new HashMap<String,Object>();
		lang.put("language", Language.getLoginLanguage().getAD_Language());
		editor.setConfig(lang);
		tabPanel.appendChild(editor);
		editor.setVflex("1");
		editor.setWidth("100%");
		editor.setValue(text);
	}

	public void onEditorCallback(Event event) {
		text = sanitize((String) event.getData());
		detach();
	}
	
	/**
	 * @param event
	 */
	public void onEvent(Event event) throws Exception {
		if (event.getTarget().getId().equals(ConfirmPanel.A_CANCEL)) {
			onCancel();
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_OK)) {
			if (editable) {
				if (tabbox.getSelectedIndex() == 0) {
					text = textBox.getText();
					detach();
				} else {
					String script = "(function(){let w=zk('#"+editor.getUuid()+"').$();let d=w.getEditor().getData();let t=zk('#" +
							this.getUuid()+"').$();let e=new zk.Event(t,'onEditorCallback',d,{toServer:true});zAu.send(e);})()";
					Clients.response(new AuScript(script));
				}
					
			}			
		} else if (event.getTarget().getId().equals(ConfirmPanel.A_RESET)) {
			textBox.setText(text);
			if (editor != null)
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

	private void onCancel() {
		cancelled = true;
		detach();
	}
	
	private void onSize() {
		editor.invalidate();
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

	public static String sanitize(String untrustedHTML) {
		final PolicyFactory policy = Sanitizers.BLOCKS
				.and(Sanitizers.FORMATTING)
				.and(Sanitizers.IMAGES)
				.and(Sanitizers.LINKS)
				.and(Sanitizers.STYLES)
				.and(Sanitizers.TABLES);

		String ret = policy.sanitize(untrustedHTML);
		ret = ret.replaceAll("&#35;", "#");
		ret = ret.replaceAll("&#64;", "@");

		return ret;
	}
}
