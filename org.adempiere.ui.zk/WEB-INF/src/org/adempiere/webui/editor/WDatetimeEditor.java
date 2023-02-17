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
package org.adempiere.webui.editor;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.TimeZone;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.MClientInfo;
import org.compiere.model.MOrgInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;

/**
 *
 * @author Low Heng Sin
 */
public class WDatetimeEditor extends WEditor implements ContextMenuListener
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CHANGE, Events.ON_OK};
    @SuppressWarnings("unused")
	private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(WDatetimeEditor.class);
    }

    private Timestamp oldValue = new Timestamp(0);

    /**
    *
    * @param gridField
    */
    public WDatetimeEditor(GridField gridField)
    {
    	this(gridField, false, null);
    }
    
    /**
     *
     * @param gridField
     */
    public WDatetimeEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(new DatetimeBox(), gridField, tableEditor, editorConfiguration);
        init();
    }


	/**
	 * Constructor for use if a grid field is unavailable
	 *
	 * @param label
	 *            column name (not displayed)
	 * @param description
	 *            description of component
	 * @param mandatory
	 *            whether a selection must be made
	 * @param readonly
	 *            whether or not the editor is read only
	 * @param updateable
	 *            whether the editor contents can be changed
	 */
	public WDatetimeEditor (String label, String description, boolean mandatory, boolean readonly, boolean updateable)
	{
		super(new DatetimeBox(), label, description, mandatory, readonly, updateable);
		setColumnName("Datetime");
		init();
	}

	public WDatetimeEditor()
	{
		this(Msg.getMsg(Env.getCtx(), "DateTime"), Msg.getMsg(Env.getCtx(), "DateTime"), false, false, true);
	}   // WDatetimeEditor

	/**
	 *
	 * @param columnName
	 * @param mandatory
	 * @param readonly
	 * @param updateable
	 * @param title
	 */
	public WDatetimeEditor(String columnName, boolean mandatory, boolean readonly, boolean updateable,
			String title)
	{
		super(new DatetimeBox(), columnName, title, null, mandatory, readonly, updateable);
		init();
	}

	private void init()
	{
		popupMenu = new WEditorPopupMenu(false, false, isShowPreference());
		popupMenu.addMenuListener(this);
		addChangeLogMenu(popupMenu);
		if (gridField != null)
			getComponent().getDatebox().setPlaceholder(gridField.getPlaceholder());
		
		if (isTimestampWithTimeZone()) 
		{
			MOrgInfo orgInfo = MOrgInfo.get(Env.getAD_Org_ID(Env.getCtx()));
			String timezoneId = orgInfo.getTimeZone();
			if (Util.isEmpty(timezoneId, true)) {
				MClientInfo clientInfo = MClientInfo.get();
				timezoneId = clientInfo.getTimeZone();
				if (Util.isEmpty(timezoneId, true))
					timezoneId = Env.getContext(Env.getCtx(), Env.CLIENT_INFO_TIME_ZONE);
			}
			
			if (!Util.isEmpty(timezoneId, true))
			{
				TimeZone tz = TimeZone.getTimeZone(timezoneId);
				if (tz != null && timezoneId.equals(tz.getID()))
				{
					getComponent().setTimeZone(tz);
					getComponent().getTimebox().setFormat("hh:mm:ss a z");
				}
			}
		}
	}

	private boolean isTimestampWithTimeZone() 
	{
		if (gridField != null)
		{
			int displayType = gridField.getDisplayType();
			return DisplayType.isTimestampWithTimeZone(displayType);
		}
		return false;
	}
	
	@Override
	public void onEvent(Event event)
    {
		if (Events.ON_CHANGE.equalsIgnoreCase(event.getName()) || Events.ON_OK.equalsIgnoreCase(event.getName()))
		{
	        Date date = getComponent().getValue();
	        Timestamp newValue = null;

	        if (date != null)
	        {
	        	if (isTimestampWithTimeZone())
	        	{
	        		newValue = Timestamp.from(date.toInstant());
	        	}
	        	else
	        	{
	        		newValue = Timestamp.valueOf(date.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
	        	}
	        }
	        if (oldValue != null && newValue != null && oldValue.equals(newValue)) {
	    	    return;
	    	}
	        if (oldValue == null && newValue == null) {
	        	return;
	        }
	        ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
	        super.fireValueChange(changeEvent);
	        oldValue = newValue;
		}
    }

    @Override
    public String getDisplay()
    {
    	// Elaine 2008/07/29
    	return getComponent().getText();
    	//
    }

    @Override
    public Object getValue()
    {
    	// Elaine 2008/07/25
    	if(getComponent().getValue() == null) return null;
    	return Timestamp.valueOf(getComponent().getValue().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
    	//
    }

    @Override
    public void setValue(Object value)
    {
    	if (value == null || value.toString().trim().length() == 0)
    	{
    		oldValue = null;
    		getComponent().setValue(null);
    	}
    	else if (value instanceof Timestamp)
        {
    		Timestamp ts = (Timestamp) value;
    		if (isTimestampWithTimeZone())
    		{
    			ZonedDateTime zdt = ts.toInstant().atZone(getComponent().getDatebox().getTimeZone().toZoneId());
    			getComponent().setValueInZonedDateTime(zdt);
    			ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, value);
                super.fireValueChange(changeEvent);
    		}
    		else
    		{
	    		LocalDateTime localTime = ts.toLocalDateTime();
	    		getComponent().setValueInLocalDateTime(localTime);
	    		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, value);
	            super.fireValueChange(changeEvent);
    		}
            oldValue = ts;
        }
    	else
    	{
    		try
    		{
    			getComponent().setText(value.toString());
    		} catch (Exception e) {}
    		if (getComponent().getValue() != null)
    		{
    			if (isTimestampWithTimeZone())
    				oldValue = Timestamp.from(getComponent().getDatebox().getValue().toInstant());
    			else
    				oldValue = Timestamp.valueOf(getComponent().getDatebox().getValue().toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime());
    		}
    		else
    		{
    			oldValue = null;
    		}
    	}
    }

	@Override
	public DatetimeBox getComponent() {
		return (DatetimeBox) component;
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}


	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }


	@Override
	public void onMenu(ContextMenuEvent evt) {
		if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		} 
		else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
		}
	}


	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setFieldStyle(java.lang.String)
	 */
	@Override
	protected void setFieldStyle(String style) {
		getComponent().getDatebox().setStyle(style);
		getComponent().getTimebox().setStyle(style);
	}
	
}
