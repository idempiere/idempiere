/***********************************************************************
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
 * - Nicolas Micoud (TGI)		                                       *
 * - Low Heng Sin		                                               *
 **********************************************************************/

package org.adempiere.webui.editor;


import java.util.logging.Level;

import org.adempiere.util.GridRowCtx;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridField;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.ComponentCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Html;
import org.zkoss.zul.Menuitem;

/**
 * Default editor for {@link DisplayType#Color}.<br/>
 * Implemented with {@link EditorBox} component and HTML color type (&lt;input type="color"&gt;).
 * @author Nicolas Micoud (TGI)
 *
 */
public class WColorEditor extends WEditor implements ContextMenuListener
{
	private static final CLogger log = CLogger.getCLogger(WColorEditor.class);
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
    public static final String COLOR_PICKER_EVENT = "COLOR_PICKER";

    /** Hex coded color value, for e.g #FF0000 */
	private String oldValue;
	/** Place holder text for text box */
	private String placeHolder;
	/** Hidden text box with type set to color. Use to open HTML native color picker. */
	private Textbox colorbox;

	/**
	 * 
	 * @param gridField
	 */
	public WColorEditor(GridField gridField)
	{
		this(gridField, false, null);
	}

	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WColorEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
	{
		super(new EditorBox(), gridField, tableEditor, editorConfiguration);

		init();

		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-pencil");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/ColorPicker16.png")); 

		if (gridField != null)
			placeHolder = gridField.getPlaceholder();
		if (Util.isEmpty(placeHolder, true))
			placeHolder = Msg.getMsg(Env.getCtx(), "ColorFieldPlaceholder");
		getComponent().getTextbox().setPlaceholder(placeHolder);
		getComponent().getTextbox().setReadonly(true);

		colorbox = new Textbox();
		colorbox.setClientAttribute("type", "color");
		colorbox.setStyle("position:absolute;top:0;left:0;height:0px !important;width:0px !important;"
				+ "border:none !important;margin:0 !important;padding:0 !important;visibility:hidden;");
		
		//append colorbox to getComponent doesn't with with table/grid
		if (!tableEditor) {
			getComponent().appendChild(colorbox);
		} else {
			getComponent().getTextbox().addCallback(ComponentCtrl.AFTER_PAGE_ATTACHED, t -> afterPageAttached());
			getComponent().getTextbox().addCallback(ComponentCtrl.AFTER_PAGE_DETACHED, t -> afterPageDetached());
		}

		colorbox.addEventListener("onInput", e -> {
			processNewValue((String)e.getData());
		});
		
		colorbox.setWidgetOverride("__doOnInput", "function(evt) {"
				+ "  let v=this.$n().value;"
				+ "  this.fire('onInput',v,{toServer:true});"
				+ "}");
		colorbox.setWidgetOverride("bind_", "function() {"
				+ "  this.$supers('bind_',arguments);"
				+ "  this.domListen_(this.$n(),'oninput','__doOnInput');"
				+ "}");
		colorbox.setWidgetOverride("unbind_", "function() {"
				+ "  this.domUnlisten_(this.$n(),'oninput','__doOnInput');"
				+ "  this.$supers('unbind_',arguments);"
				+ "}");
	}

	/**
	 * Handle after page detached callback. This is use when editor is use within grid/table.
	 * @return null
	 */
	private Object afterPageDetached() {
		if (colorbox.getPage() != null && colorbox.getParent() != getComponent()) {
			colorbox.detach();
		}
		
		//need to attach callback again as editor is reuse in grid view
		getComponent().getTextbox().addCallback(ComponentCtrl.AFTER_PAGE_ATTACHED, t -> afterPageAttached());
		getComponent().getTextbox().addCallback(ComponentCtrl.AFTER_PAGE_DETACHED, t -> afterPageDetached());
		
		return null;
	}

	/**
	 * Handle after page attached callback. This is use when editor is use within grid/table.
	 * @return null
	 */
	private Object afterPageAttached() {
		if (colorbox.getParent() == null) {
			colorbox.setPage(this.getComponent().getPage());
		}
		fillTextbox();
		return null;
	}

	/**
	 * Init component and context menu
	 */
	private void init()
	{
		if (log.isLoggable(Level.INFO)) log.info("Initializing component");

		popupMenu = new WEditorPopupMenu(false, false, isShowPreference());
		addColorEditorMenu(popupMenu);
		addChangeLogMenu(popupMenu);
	}

	/**
	 * Add entries to popup context menu
	 * @param popupMenu
	 */
	protected void addColorEditorMenu(WEditorPopupMenu popupMenu) {
		Menuitem editor = new Menuitem();
		editor.setAttribute("EVENT", WEditorPopupMenu.RESET_EVENT);
		editor.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Erase")).intern());
		if (ThemeManager.isUseFontIconForImage())
			editor.setIconSclass("z-icon-eraser");
		else
			editor.setImage(ThemeManager.getThemeResource("images/Erase16.png"));
		editor.addEventListener(Events.ON_CLICK, popupMenu);
		popupMenu.appendChild(editor);

		editor = new Menuitem();
		editor.setAttribute("EVENT", COLOR_PICKER_EVENT);
		editor.setLabel(Msg.getMsg(Env.getCtx(), "ColorPicker"));
		if (ThemeManager.isUseFontIconForImage())
			editor.setIconSclass("z-icon-pencil");
		else
			editor.setImage(ThemeManager.getThemeResource("images/ColorPicker16.png"));
		editor.addEventListener(Events.ON_CLICK, popupMenu);
		popupMenu.appendChild(editor);
	}

	@Override
	public void onMenu(ContextMenuEvent evt)
	{
		if (WEditorPopupMenu.RESET_EVENT.equals(evt.getContextEvent()))
		{
			processNewValue(null);
			colorbox.setValue(oldValue);

		}
		else if (COLOR_PICKER_EVENT.equals(evt.getContextEvent()))
		{
			openColorPicker();
		}
	}

	@Override
	public EditorBox getComponent()
	{
		return (EditorBox) component;
	}

	@Override
	public void setValue(Object value)
	{
		if (value == null)
		{
			oldValue = null;
			getComponent().setText("");
		}
		else
		{
			oldValue = String.valueOf(value);
			getComponent().setText(oldValue);
		}
		colorbox.setValue(oldValue);

		fillTextbox();
	}

	/**
	 * Fill half of text box with entered color value
	 */
	private void fillTextbox() {
		String style="background-color: transparent !important;";
		if (!Util.isEmpty(oldValue, true))
			style = getBackgroundFillStyle(oldValue);
		String script = "jq('#"+getComponent().getTextbox().getUuid()+"').attr('style','"+style+"');";
		if (Executions.getCurrent() != null && getComponent().getPage() != null)
			Clients.response(new AuScript(script));
		else if (getComponent().getDesktop() != null)
			Executions.schedule(getComponent().getDesktop(), e -> Clients.response(new AuScript(script)), new Event("onFillTextBox"));
	}

	/**
	 * @param color hex coded color string
	 * @return background fill style
	 */
	protected String getBackgroundFillStyle(String color) {
		return "background: linear-gradient(to right, rgba(255,0,0,0) 50%, "
				+ color + " 50%) !important;";
	}

	@Override
	public Object getValue()
	{
		return getComponent().getText();
	}

	@Override
	public String getDisplay()
	{
		return getComponent().getText();
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().getButton().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().getButton().setEnabled(readWrite);
	}

	@Override
	public void onEvent(Event event)
	{
		if (Events.ON_CLICK.equalsIgnoreCase(event.getName()))
		{
			openColorPicker();
		}
		else
		{
			return;
		}
	}

	/**
	 * Open HTML native color picker
	 */
	public void openColorPicker() {
		String uid = colorbox.getUuid();
		String script = "(function(){let wgt = zk.Widget.$('#"+uid+"');wgt.$n().click();})()";
		Clients.response(new AuScript(script));		
	}

	/**
	 * Process newValue from color picker
	 * @param newValue
	 */
	protected void processNewValue(String newValue) {
		if (oldValue != null && newValue != null && oldValue.equals(newValue)) {
			return;
		}
		if (oldValue == null && newValue == null) {
			return;
		}
		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
		fireValueChange(changeEvent);
		oldValue = getComponent().getTextbox().getValue();                
	}

	@Override
	public String[] getEvents()
	{
		return LISTENER_EVENTS;
	}

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}

	@Override
	public String getDisplayTextForGridView(GridRowCtx gridRowCtx, Object value) {
		if (value == null) {
			return "";
		} else {
			return "<div class='grid-view-color-fieldtype-display'>"
					+ "	<div style='background: "+value.toString()+";'></div>"
					+ "</div>";
		}
	}

	@Override
	public Component getDisplayComponent() {
		return new Html();
	}
	
}
