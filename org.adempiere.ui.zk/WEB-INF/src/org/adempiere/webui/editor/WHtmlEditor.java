/******************************************************************************
 * Product: BrERP Business Solution (http://brerp.org)                        *
 *                                                                            *
 * Copyright (C) 2014 devCoffee Sistemas de Gestão Integrada Ltda.	          *
 *                                                                            *
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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WTextEditorDialog;
import org.compiere.model.GridField;
import org.compiere.util.CLogger;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;


/**
 * HTML Editor
 * <p> Implementation of an editor to show HTML content </p>
 *
 * Based on contribution from
 * @author muriloht (muriloht@devcoffee.com.br, http://www.devcoffee.com.br)
 * @version $Id: WHTMLEditor.java, v1.0 11/11/2014 20:25:06, muriloht Exp $
 */
public class WHtmlEditor extends WEditor implements ContextMenuListener
{

    private String oldValue;

	private AbstractADWindowContent adwindowContent;

    /** HTML Model         */
	private Html  box = null;

    private boolean m_mandatory;

	private boolean readwrite;

    /**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WHtmlEditor.class);

	/**
	 * 
	 * @param gridField
	 */
	public WHtmlEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WHtmlEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(new Div(), gridField, tableEditor, editorConfiguration);
        init();
    }

    @Override
    public Div getComponent() {
    	return (Div) component;
    }

    private void init()
    {
    	if (log.isLoggable(Level.INFO)) log.info("Initializing component");

    	if (gridField != null)
    	{
			Div div = (Div) getComponent();
			if (gridField.getNumLines() > 1) {
				int height = 24 * gridField.getNumLines();
				div.setHeight(height + "px");
			}
			div.setWidth("100%");
			LayoutUtils.addSclass("html-field", div);
			div.addEventListener(Events.ON_DOUBLE_CLICK, this);

			box = new Html();
			box.setParent(div);

        	popupMenu = new WEditorPopupMenu(false, false, isShowPreference());
        	addTextEditorMenu(popupMenu);
        	addChangeLogMenu(popupMenu);
    	}
    }

     @Override
    public String getDisplay()
    {
    	 return box.getContent();
    }

    @Override
    public Object getValue()
    {
		return box.getContent();
    }

    @Override
    public boolean isMandatory()
    {
        return m_mandatory;
    }


    @Override
    public void setMandatory(boolean mandatory)
    {
    	super.setMandatory(mandatory);
        m_mandatory = mandatory;
    }

    @Override
	public boolean isReadWrite() {
		return readwrite;
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		this.readwrite = readWrite;
	}

	@Override
    public void setValue(Object value)
    {
        if (value != null)
        {
        	box.setContent(value.toString());
        }
        else
        {
        	box.setContent("");
        }
        oldValue = box.getContent();
    }


    @Override
	public String getDisplayTextForGridView(Object value) {
		if (value == null) {
			return "";
		} else {
			return (String)value;
		}
	}

	@Override
	public Component getDisplayComponent() {
		return new Html();
	}

	@Override
	public void onMenu(ContextMenuEvent evt) {
		if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
			return;
		}
		else if (WEditorPopupMenu.EDITOR_EVENT.equals(evt.getContextEvent()))
		{
			editorEvent();
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
	}

	private void editorEvent() {
		adwindowContent = findADWindowContent();
		final WTextEditorDialog dialog = new WTextEditorDialog(gridField.getVO().Header, getDisplay(),
				isReadWrite(), gridField.getFieldLength(), true);
		dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (adwindowContent != null) {
					adwindowContent.hideBusyMask();
				}
				if (!dialog.isCancelled()) {
					box.setContent(WTextEditorDialog.sanitize(dialog.getText()));
					String newText = box.getContent();
			        ValueChangeEvent changeEvent = new ValueChangeEvent(WHtmlEditor.this, WHtmlEditor.this.getColumnName(), oldValue, newText);
			        WHtmlEditor.super.fireValueChange(changeEvent);
			        oldValue = newText;
				}
			}
		});
		if (adwindowContent != null) 
		{
			adwindowContent.getComponent().getParent().appendChild(dialog);
			adwindowContent.showBusyMask(dialog);
			LayoutUtils.openOverlappedWindow(adwindowContent.getComponent().getParent(), dialog, "middle_center");
		}
		else
		{
			SessionManager.getAppDesktop().showWindow(dialog);
		}			
		dialog.focus();
	}

	private AbstractADWindowContent findADWindowContent() {
		Component parent = getComponent().getParent();
		while(parent != null) {
			if (parent.getAttribute(ADWindow.AD_WINDOW_ATTRIBUTE_KEY) != null) {
				ADWindow adwindow = (ADWindow) parent.getAttribute(ADWindow.AD_WINDOW_ATTRIBUTE_KEY);
				return adwindow.getADWindowContent();
			}
			parent = parent.getParent();
		}
		return null;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_DOUBLE_CLICK.equals(event.getName()) && readwrite) {
			editorEvent();
		}
	}

}
