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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.editor;

import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.GridField;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Menu;
import org.zkoss.zul.Menuitem;

/**
 * @author hengsin
 *
 */
public class WTimeZoneEditor extends WEditor implements ContextMenuListener {
	
	private static final String[] LISTENER_EVENTS = {Events.ON_CHANGE};
	private static final String TIME_ZONE = "TIME_ZONE";
	private static final String TIME_ZONE_ADDED = "TIME_ZONE_ADDED";
	private static final String TIME_ZONE_ITEM_ATTR = "TIME_ZONE_ITEM";
	private static final String TIME_ZONE_ID_ATTR = "TIME_ZONE_ID";
		
	private String oldValue;
	
	/**
	 * @param gridField
	 */
	public WTimeZoneEditor(GridField gridField) {
		this(gridField, false);
	}

	/**
	 * @param gridField
	 * @param rowIndex
	 */
	public WTimeZoneEditor(GridField gridField, boolean tableEditor) {
		super(new Combobox(), gridField);
		this.tableEditor = tableEditor;
		init();
	}

	/**
	 * @param label
	 * @param description
	 * @param mandatory
	 * @param readonly
	 * @param updateable
	 */
	public WTimeZoneEditor(String label, String description,
			boolean mandatory, boolean readonly, boolean updateable) {
		super(new Combobox(), label, description, mandatory, readonly, updateable);
		init();
	}

	/**
	 * @param columnName
	 * @param label
	 * @param description
	 * @param mandatory
	 * @param readonly
	 * @param updateable
	 */
	public WTimeZoneEditor(String columnName, String label,
			String description, boolean mandatory, boolean readonly,
			boolean updateable) {
		super(new Combobox(), columnName, label, description, mandatory, readonly,
				updateable);
		init();
	}

	private void init() {
		popupMenu = new WEditorPopupMenu(false, false, isShowPreference());
		popupMenu.addMenuListener(this);
		popupMenu.addEventListener(Events.ON_OPEN, this);
		
		Set<String> ids = ZoneId.getAvailableZoneIds();
		List<Integer> rawOffsets = new ArrayList<Integer>();
		Map<Integer, List<NamePair>> map = new HashMap<Integer, List<NamePair>>();
		for(String id : ids) {
			if (id.startsWith("Etc/") || id.startsWith("SystemV/") || id.indexOf("/") < 0)
				continue;
			TimeZone tz = TimeZone.getTimeZone(ZoneId.of(id));
			String label = getLabel(tz);
			int rawOffset = tz.getRawOffset();
			if (!rawOffsets.contains(rawOffset))
				rawOffsets.add(rawOffset);
			List<NamePair> timezones = map.get(rawOffset);
			if (timezones == null) {
				timezones = new ArrayList<NamePair>();
				map.put(rawOffset, timezones);
			}
			ValueNamePair valueNamePair = new ValueNamePair(id, label);
			timezones.add(valueNamePair);			
		}
		Collections.sort(rawOffsets);
		for(int rawOffset : rawOffsets) {
			List<NamePair> namePairs = map.get(rawOffset);
			Collections.sort(namePairs);
			for(NamePair namePair : namePairs) {
				getComponent().appendItem(namePair.getName(), namePair.getID());
			}
		}
		
		getComponent().addEventListener(Events.ON_BLUR, e -> onBlur());
	}
	
	private void onBlur() {
		Comboitem item = getComponent().getSelectedItem();
		if (item == null) 
		{
			setValue(oldValue);
		}
		else 
		{
			//on select not fire for empty label item
			if (Util.isEmpty(item.getLabel(),true))
			{
				String newValue = getValue();
				if (isValueChange(newValue)) {
					try {
		        		if (gridField != null) 
		        			gridField.setLookupEditorSettingValue(true);
	    				ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
	    		        super.fireValueChange(changeEvent);
	    		        oldValue = newValue;
					} finally {
						if (gridField != null) 
		        			gridField.setLookupEditorSettingValue(false);
					}
				}
			}
		}
	}

	private boolean isValueChange(String newValue) {
		return (oldValue == null && newValue != null) || (oldValue != null && newValue == null) 
			|| ((oldValue != null && newValue != null) && !oldValue.equals(newValue));
	}
	
	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.event.EventListener#onEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CHANGE.equalsIgnoreCase(event.getName())) {
	        String id = getComponent().getSelectedItem() != null ? (String)getComponent().getSelectedItem().getValue() : (String)null;
	        String newValue = null;

	        if (id != null) {
	            newValue = id;
	        } else if (!Util.isEmpty(getComponent().getText(), true)) {
	        	String customId = getComponent().getText();
	        	if (processCustomZoneId(customId))
	        		newValue = customId;
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
		} else if (Events.ON_OPEN.equals(event.getName())) {
			addTimeZoneMenu(popupMenu);
		}
	}

	private boolean processCustomZoneId(String customId) {
    	TimeZone timeZone = TimeZone.getTimeZone(customId);
    	if (timeZone != null && timeZone.getID().equals(customId)) {
    		getComponent().appendItem(customId, customId);
    		getComponent().setSelectedIndex(getComponent().getItemCount()-1);
    		return true;
    	}
    	return false;
	}
	
	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setReadWrite(boolean)
	 */
	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setReadonly(!readWrite);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isReadWrite()
	 */
	@Override
	public boolean isReadWrite() {
		return !getComponent().isReadonly();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setValue(java.lang.Object)
	 */
	@Override
	public void setValue(Object value) {
		if (value == null || value.toString().trim().length() == 0) {
    		oldValue = null;
    		getComponent().setValue((Object)null);
    		getComponent().setSelectedItem(null);
    		getComponent().setText("");
    	} else if (value instanceof TimeZone) {
    		TimeZone tz = (TimeZone)value;
            getComponent().setValue((Object)tz.getID());
            oldValue = tz.getID();
        } else {
    		getComponent().setValue(value);
    		if (getComponent().getSelectedItem() != null) {
    			oldValue = getComponent().getSelectedItem().getValue();
    		} else {
    			if (processCustomZoneId(value.toString()))
    				oldValue = getComponent().getSelectedItem().getValue();
    			else
    				oldValue = null;
    		}
    	}
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getValue()
	 */
	@Override
	public String getValue() {
		return getComponent().getValue();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getDisplay()
	 */
	@Override
	public String getDisplay() {
		return getComponent().getName(); 
	}

	@Override
	public String getDisplayTextForGridView(Object value) {
		if (value == null)
			return "";
		if (value instanceof TimeZone) {
			return getLabel((TimeZone) value);
		} else if (value instanceof String) {
			String id = (String) value;
			if (Util.isEmpty(id, true))
				return (String) value;
			TimeZone tz = TimeZone.getTimeZone((String) value);
			if (tz != null && tz.getID().equals((String)value))
				return getLabel(tz);
			else
				return (String) value;
		}
		return value.toString();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#getComponent()
	 */
	@Override
	public Combobox getComponent() {
		return (Combobox) super.getComponent();
	}

	@Override
	public void onMenu(ContextMenuEvent evt) {
		if (TIME_ZONE.equals(evt.getContextEvent())) {
			if (isReadWrite()) {
				Component target = evt.getTarget();
				if (target != null && target.getAttribute(TIME_ZONE_ID_ATTR) != null) {
					String id = (String) target.getAttribute(TIME_ZONE_ID_ATTR);
					setTimeZoneFromContextMenu(id);
				}
			}
		} else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()) && gridField != null) {
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
		}
		
	}

	private void setTimeZoneFromContextMenu(String id) {
		String newValue = id;
		String currentValue = oldValue;
		setValue(id);
		if (getComponent().getSelectedItem() == null) {
			newValue = null;
		}
		if (newValue != null) {
			ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), currentValue, newValue);
	        super.fireValueChange(changeEvent);
	        oldValue = newValue;
		} else if (currentValue != null) {
			setValue(currentValue);
		}
	}

	@Override
	public String[] getEvents() {
        return LISTENER_EVENTS;
    }
	
	/**
	 * @param popupMenu
	 */
    private void addTimeZoneMenu(WEditorPopupMenu popupMenu) {
		if (popupMenu != null && isReadWrite() && popupMenu.getAttribute(TIME_ZONE_ADDED) == null) {
			ClientInfo clientInfo = SessionManager.getAppDesktop().getClientInfo();
			if (clientInfo != null && clientInfo.timeZone != null) {
				TimeZone firstSameRule = null;
				TimeZone found = null;
				for(int i = 0; i < getComponent().getItemCount(); i++) {
					String id = getComponent().getItemAtIndex(i).getValue();
					TimeZone tz = TimeZone.getTimeZone(id);
					if (tz.getID().equals(clientInfo.timeZone.getID())) {
						found = tz;
						break;
					} else if (tz.getRawOffset() == clientInfo.timeZone.getRawOffset() &&
							tz.getDSTSavings() == clientInfo.timeZone.getDSTSavings() &&
							tz.useDaylightTime() == clientInfo.timeZone.useDaylightTime()) {
						if (firstSameRule == null)
							firstSameRule = tz;
					}
				}
				TimeZone tz = found != null ? found : firstSameRule;
				if (tz != null) {
					Menuitem item = new Menuitem();
					item.setLabel(getLabel(clientInfo.timeZone));
					item.addEventListener(Events.ON_CLICK, popupMenu);
					item.setAttribute(WEditorPopupMenu.EVENT_ATTRIBUTE, TIME_ZONE);
					item.setAttribute(TIME_ZONE_ID_ATTR, tz.getID());
					item.setAttribute(TIME_ZONE_ITEM_ATTR, Boolean.TRUE);
					popupMenu.appendChild(item);
					popupMenu.setAttribute(TIME_ZONE_ADDED, Boolean.TRUE);
				}
				
				if (popupMenu.getAttribute(TIME_ZONE_ADDED) == null) {
					List<String> labels = new ArrayList<String>();
					List<String> ids = new ArrayList<String>();
					for(int i = 0; i < getComponent().getItemCount(); i++) {
						String id = getComponent().getItemAtIndex(i).getValue();
						tz = TimeZone.getTimeZone(id);
						if (tz.getRawOffset() == clientInfo.timeZone.getRawOffset()) {
							labels.add(getLabel(tz));
							ids.add(id);
						}
					}					
					if (labels.size() == 1) {
						Menuitem item = new Menuitem();
						item.setLabel(labels.get(0));
						item.addEventListener(Events.ON_CLICK, popupMenu);
						item.setAttribute(WEditorPopupMenu.EVENT_ATTRIBUTE, TIME_ZONE);
						item.setAttribute(TIME_ZONE_ID_ATTR, ids.get(0));
						item.setAttribute(TIME_ZONE_ITEM_ATTR, Boolean.TRUE);
						popupMenu.appendChild(item);
					} else {
						Menu menu = new Menu();
						menu.setLabel(Msg.getElement(Env.getCtx(), "TimeZone"));
						menu.setAttribute(TIME_ZONE_ITEM_ATTR, Boolean.TRUE);
						popupMenu.appendChild(menu);
						Menupopup subPopup = new Menupopup();
						menu.appendChild(subPopup);
						for(int i = 0; i < labels.size(); i++) {
							String label = labels.get(i);
							String id = ids.get(i);
							Menuitem item = new Menuitem();
							item.setLabel(label);
							item.addEventListener(Events.ON_CLICK, popupMenu);
							item.setAttribute(WEditorPopupMenu.EVENT_ATTRIBUTE, TIME_ZONE);
							item.setAttribute(TIME_ZONE_ID_ATTR, id);
							subPopup.appendChild(item);
						}
					}
					popupMenu.setAttribute(TIME_ZONE_ADDED, Boolean.TRUE);
				}				
			}
		} else if (popupMenu != null) {
			List<Component> childs = popupMenu.getChildren();
			for(Component c : childs) {
				if (c.getAttribute(TIME_ZONE_ITEM_ATTR) != null) {
					if (isReadWrite()) {
						if (!c.isVisible())
							c.setVisible(true);
					} else {
						if (c.isVisible())
							c.setVisible(false);
					}
				}
			}
		}
	}

    /**
     * 
     * @param tz
     * @return UTC offset + time zone id
     */
	private String getLabel(TimeZone tz) {
		String name = tz.getID();
		int rawOffset = tz.getRawOffset();
		int offsetMinutes = rawOffset / (60 * 1000);
        boolean negative = false;

        if (offsetMinutes < 0) {
        	negative = true;
            offsetMinutes = -offsetMinutes;
        }

        final int h = offsetMinutes / 60;
        final int m = offsetMinutes - h * 60;

		StringBuilder fullName = new StringBuilder("UTC")
			.append(((negative) ? "-" : "+"))
			.append(((h < 10) ? "0" : "")).append(h).append(":")
			.append(((m < 10) ? "0" : "")).append(m).append(" ")
			.append(name);
		return fullName.toString();
	}
}
