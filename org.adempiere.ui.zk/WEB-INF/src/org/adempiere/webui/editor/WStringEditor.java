/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.editor;

import java.util.List;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WTextEditorDialog;
import org.compiere.model.GridField;
import org.compiere.model.I_R_MailText;
import org.compiere.util.DisplayType;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 11, 2007
 * @version $Revision: 0.10 $
 */
public class WStringEditor extends WEditor implements ContextMenuListener
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CHANGE, Events.ON_OK};

    private String oldValue;

	private AbstractADWindowContent adwindowContent;

    /**
     * to ease porting of swing form
     */
    public WStringEditor()
    {
    	this("String", false, false, true, 30, 30, "", null);
    }

    /**
     * 
     * @param gridField
     */
    public WStringEditor(GridField gridField) {
    	this(gridField, false);
    }

    /**
     * 
     * @param gridField
     * @param tableEditor
     */
    public WStringEditor(GridField gridField, boolean tableEditor)
    {
    	this(gridField, tableEditor, null);
    }
    
    /**
     * 
     * @param gridField
     * @param tableEditor
     * @param editorConfiguration
     */
    public WStringEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(gridField.isAutocomplete() ? new Combobox() : new Textbox(), gridField, tableEditor, editorConfiguration);

        if (gridField.getVFormat() != null && !gridField.getVFormat().isEmpty())
        	getComponent().setWidgetListener("onBind", "jq(this).mask('" + gridField.getVFormat() + "');");

        init(gridField.getObscureType());
    }

    /**
     * to ease porting of swing form
     * @param columnName
     * @param mandatory
     * @param isReadOnly
     * @param isUpdateable
     * @param displayLength
     * @param fieldLength
     * @param wVFormat
     * @param obscureType
     */
    public WStringEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable,
    		int displayLength, int fieldLength, String wVFormat, String obscureType)
    {
    	super(new Textbox(), columnName, null, null, mandatory, isReadOnly,isUpdateable);

    	if (wVFormat != null &&  !wVFormat.isEmpty())
    		getComponent().setWidgetListener("onBind", "jq(this).mask('" + wVFormat + "');");

    	init(obscureType);
    }

    @Override
    public org.zkoss.zul.Textbox getComponent() {
    	return (org.zkoss.zul.Textbox) component;
    }

    @Override
	public boolean isReadWrite() {
		return !getComponent().isReadonly();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setReadonly(!readWrite);
	}

	private void init(String obscureType)
    {
		setChangeEventWhenEditing (true);
		if (gridField != null)
		{
	        getComponent().setMaxlength(gridField.getFieldLength());
	        int displayLength = gridField.getDisplayLength();
	        if (displayLength <= 0 || displayLength > MAX_DISPLAY_LENGTH)
	        {
	            displayLength = MAX_DISPLAY_LENGTH;
	        }
	        if (!tableEditor)
	        	getComponent().setCols(displayLength);
	        if (tableEditor)
	        	getComponent().setMultiline(false);
	        else if (gridField.getDisplayType() == DisplayType.Text)
	        {
	            getComponent().setMultiline(true);
	        }
	        else if (gridField.getDisplayType() == DisplayType.TextLong)
	        {
	            getComponent().setMultiline(true);
	        }
	        else if (gridField.getDisplayType() == DisplayType.Memo)
	        {
	            getComponent().setMultiline(true);
	        }
	        else
	            getComponent().setMultiline(false);
	        if (! gridField.isAutocomplete()) // avoid -> Combobox doesn't support multiple rows
	        	getComponent().setRows(gridField.getNumLines() <= 0 || tableEditor ? 1 : gridField.getNumLines());

	        if (getComponent() instanceof Textbox)
	        	((Textbox)getComponent()).setObscureType(obscureType);


	        if(!(this instanceof WPasswordEditor)){ // check password field
	        	popupMenu = new WEditorPopupMenu(false, gridField.isAutocomplete(), isShowPreference());
	        	addTextEditorMenu(popupMenu);
	        	addChangeLogMenu(popupMenu);
	        }

	        if (gridField.isAutocomplete()) {
	        	Combobox combo = (Combobox)getComponent();
	        	combo.setAutodrop(true);
	        	combo.setAutocomplete(true);
	        	combo.setButtonVisible(false);
	        	List<String> items = gridField.getEntries();
	        	for(String s : items) {
	        		combo.appendItem(s);
	        	}
	        }
	        if ("email".equalsIgnoreCase(gridField.getColumnName()))
	        	getComponent().setClientAttribute("type", "email");
	        if (gridField != null)
	        	getComponent().setPlaceholder(gridField.getPlaceholder());
		}
    }

	public void onEvent(Event event)
    {
		boolean isStartEdit = INIT_EDIT_EVENT.equalsIgnoreCase (event.getName());
    	if (Events.ON_CHANGE.equals(event.getName()) || Events.ON_OK.equals(event.getName()) || isStartEdit)
    	{
	        String newValue = getComponent().getValue();
	        if (!isStartEdit && oldValue != null && newValue != null && oldValue.equals(newValue)) {
	    	    return;
	    	}
	        if (!isStartEdit && oldValue == null && newValue == null) {
	        	return;
	        }
	        ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
	        
	        changeEvent.setIsInitEdit(isStartEdit);
	        
	        super.fireValueChange(changeEvent);
	        oldValue = getComponent().getValue(); // IDEMPIERE-963 - check again the value could be changed by callout
    	}
    }

    @Override
    public String getDisplay()
    {
        return getComponent().getValue();
    }

    @Override
    public Object getValue()
    {
        return getComponent().getValue();
    }

    @Override
    public void setValue(Object value)
    {
        if (value != null)
        {
            getComponent().setValue(value.toString());
        }
        else
        {
            getComponent().setValue("");
        }
        oldValue = getComponent().getValue();
    }

    protected void setTypePassword(boolean password)
    {
        if (password)
        {
            getComponent().setType("password");
        }
        else
        {
            getComponent().setType("text");
        }
    }

    @Override
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

    public void onMenu(ContextMenuEvent evt)
	{
		if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
			return;
		}
		else if (WEditorPopupMenu.EDITOR_EVENT.equals(evt.getContextEvent()))
		{
			adwindowContent = findADWindowContent();
			boolean isHtml = false;
			if ((   gridField.getDisplayType() == DisplayType.Text 
				 || gridField.getDisplayType() == DisplayType.TextLong
				 || gridField.getDisplayType() == DisplayType.Memo)
				&& adwindowContent != null
				&& adwindowContent.getActiveGridTab() != null
				&& adwindowContent.getActiveGridTab().getAD_Table_ID() == I_R_MailText.Table_ID) {
				isHtml = adwindowContent.getActiveGridTab().getValueAsBoolean("IsHtml");
			}
			final WTextEditorDialog dialog = new WTextEditorDialog(gridField.getVO().Header, getDisplay(),
					isReadWrite(), gridField.getFieldLength(), isHtml);
			dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					if (adwindowContent != null) {
						adwindowContent.hideBusyMask();
					}
					if (!dialog.isCancelled()) {
						getComponent().setText(dialog.getText());
						String newText = getComponent().getValue();
				        ValueChangeEvent changeEvent = new ValueChangeEvent(WStringEditor.this, WStringEditor.this.getColumnName(), oldValue, newText);
				        WStringEditor.super.fireValueChange(changeEvent);
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
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
		else if (WEditorPopupMenu.REQUERY_EVENT.equals(evt.getContextEvent()))
		{
			actionRefresh();
		}
	}
    
	@Override
	public void dynamicDisplay() {
		super.dynamicDisplay();
		actionRefresh();
	}

	public void actionRefresh() {
		//refresh auto complete list
		if (gridField.isAutocomplete()) {
			Combobox combo = (Combobox)getComponent();
			List<String> items = gridField.getEntries();
			combo.removeAllItems();
			for(String s : items) {
				combo.appendItem(s);
			}
		}
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

}
