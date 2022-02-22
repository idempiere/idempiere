/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin  All Rights Reserved.                      *
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

package org.adempiere.webui.editor;


import java.util.logging.Level;

import org.adempiere.webui.component.ColorBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridField;
import org.compiere.util.CLogger;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;

/**
 *
 * @author Low Heng Sin
 *
 */
public class WColorEditor extends WEditor implements ContextMenuListener
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK, Events.ON_CHANGE, Events.ON_OK};

	private static final CLogger log = CLogger.getCLogger(WColorEditor.class);

	private String oldValue;

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
		super(new ColorBox(), gridField, tableEditor, editorConfiguration);

		init();

		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-pencil"); // TODO find a brush
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/Process16.png")); // TODO find a brush 

		if (gridField != null)
			getComponent().getTextbox().setPlaceholder(gridField.getPlaceholder());
	}

	private void init()
	{
		if (log.isLoggable(Level.INFO)) log.info("Initializing component");

		popupMenu = new WEditorPopupMenu(false, false, isShowPreference());
		addTextEditorMenu(popupMenu);
		addChangeLogMenu(popupMenu);
	}

	public void onMenu(ContextMenuEvent evt)
	{
		if (WEditorPopupMenu.RESET_EVENT.equals(evt.getContextEvent()))
		{
			System.out.println("reset");
			processNewValue("");
		}
	}

	@Override
	public ColorBox getComponent()
	{
		return (ColorBox) component;
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
		return getComponent().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	public void onEvent(Event event)
	{
		String newValue = null;

		if (Events.ON_CLICK.equalsIgnoreCase(event.getName()))
		{
			System.out.println("click");
		}
		else if (Events.ON_CHANGE.equals(event.getName()) || Events.ON_OK.equals(event.getName()))
		{
			System.out.println("change/ok");
			newValue = getComponent().getText();
		}
		else
		{
			return;
		}

		processNewValue(newValue);
	}

	protected void processNewValue(String newValue) {
		if (oldValue != null && newValue != null && oldValue.equals(newValue)) {
			return;
		}
		if (oldValue == null && newValue == null) {
			return;
		}
		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
		fireValueChange(changeEvent);
	}

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
	public Component getDisplayComponent() {
		return new ColorBox();
	}


	@Override
	public String getDisplayTextForGridView(Object value) {
		if (value == null) {
			return "";
		} else {
			return (String)value;
		}
	}
}
