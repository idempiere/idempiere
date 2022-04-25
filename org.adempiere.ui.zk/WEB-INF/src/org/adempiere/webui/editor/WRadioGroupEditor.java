/******************************************************************************
 * Project: Trek Global ERP                                                   *                       
 * Copyright (C) 2009-2018 Trek Global Corporation                            *
 *                                                                            *
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

import java.beans.PropertyChangeEvent;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;

import javax.swing.event.ListDataEvent;
import javax.swing.event.ListDataListener;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.GridTable;
import org.compiere.model.Lookup;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.SystemIDs;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.NamePair;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Radio;
import org.zkoss.zul.Radiogroup;

/**
 * 
 * @author hengsin
 *
 */
public class WRadioGroupEditor extends WEditor implements ContextMenuListener, ListDataListener, IZoomableEditor
{
    public final static String[] LISTENER_EVENTS = {Events.ON_CHECK};
    
    @SuppressWarnings("unused")
	private static final CLogger logger;
    
    static
    {
        logger = CLogger.getCLogger(WRadioGroupEditor.class);
    }
    
    private Lookup  lookup;
    private Object oldValue;

	private boolean onselecting = false;

	/**
	 * 
	 * @param gridField
	 */
	public WRadioGroupEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WRadioGroupEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(new RadioGroupEditor(), gridField, tableEditor, editorConfiguration);
        lookup = gridField.getLookup();
        init();
    }
	
	/** 
	 * Constructor for use if a grid field is unavailable
	 * 
	 * @param lookup		Store of selectable data
	 * @param label			column name (not displayed)
	 * @param description	description of component
	 * @param mandatory		whether a selection must be made
	 * @param readonly		whether or not the editor is read only
	 * @param updateable	whether the editor contents can be changed
	 */   
    public WRadioGroupEditor(Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
	{
		super(new RadioGroupEditor(), label, description, mandatory, readonly, updateable);
		if (lookup == null)
		{
			throw new IllegalArgumentException("Lookup cannot be null");
		}
		
		this.lookup = lookup;
		super.setColumnName(lookup.getColumnName());
		init();
	}
    
    /**
     * For ease of porting swing form
     * @param columnName
     * @param mandatory
     * @param isReadOnly
     * @param isUpdateable
     * @param lookup
     */
    public WRadioGroupEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable,
    		Lookup lookup)
    {
    	super(new RadioGroupEditor(), columnName, null, null, mandatory, isReadOnly, isUpdateable);
    	if (lookup == null)
		{
			throw new IllegalArgumentException("Lookup cannot be null");
		}
    	this.lookup = lookup;
    	init();
    }
    
    private void init()
    {
    	boolean zoom= false;
        if (lookup != null)
        {
        	lookup.addListDataListener(this);
        	lookup.setMandatory(true);
            lookup.setMandatory(isMandatory());
            
            if ((lookup.getDisplayType() == DisplayType.List && Env.getContextAsInt(Env.getCtx(), Env.AD_ROLE_ID) == SystemIDs.ROLE_SYSTEM)
            		|| lookup.getDisplayType() != DisplayType.List) 
            {
    			zoom= true;
            }       
            
            //no need to refresh readonly lookup
            if (isReadWrite())
            	lookup.refresh();
            else
            	refreshList();
        }
        
        popupMenu = new WEditorPopupMenu(zoom, true, isShowPreference(), false, false, false, lookup);
        addChangeLogMenu(popupMenu);
    }
    
    @Override
    public String getDisplay()
    {

        String display = "";
        Radio selItem = getComponent().getSelectedItem();
        if (selItem != null)
        {
        	display = selItem.getLabel();
        }
        return display;
    }

    @Override
    public Object getValue()
    {
        Object retVal = null;
        Radio selItem = getComponent().getSelectedItem();
        if (selItem != null)
        {
            retVal = selItem.getValue();
            if ((retVal instanceof Integer) && (Integer)retVal == -1)
            	retVal = null;
            else if ((retVal instanceof String) && "".equals(retVal))
            	retVal = null;
        }
        return retVal;
    }

    public void setValue(Object value)
    {
    	if (onselecting) {
    		return;
    	}
    	
    	if (value != null && (value instanceof Integer || value instanceof String || value instanceof Timestamp || value instanceof BigDecimal))
        {

            getComponent().setValue(value);            
            if (!getComponent().isSelected(value))
            {
            	Object curValue = oldValue;
                oldValue = value;
                
                if (isReadWrite() && lookup != null)
            	{
            		lookup.refresh();
            	}
            	else
            	{
                	refreshList();
            	}
                
                //still not in list, reset to zero
                if (!getComponent().isSelected(value))
                {                	
	            	if (value instanceof Integer && gridField != null && gridField.getDisplayType() != DisplayType.ID && 
	            			(gridTab==null || !gridTab.getTableModel().isImporting())) // for IDs is ok to be out of the list
	            	{
	            		//if it is problem with record lock, just keep value (no trigger change) and set field readonly
	            		MRole role = MRole.getDefault(Env.getCtx(), false);
	            		int refTableID = -1;
	            		if (gridTab != null) // fields process para don't represent a column ID
	            		{
	                		MColumn col = MColumn.get(Env.getCtx(), gridField.getAD_Column_ID());
	                		if (col.get_ID() > 0) {
	                			String refTable = col.getReferenceTableName();
	                			if (refTable != null) {
	                    			MTable table = MTable.get(Env.getCtx(), refTable);
	                    			refTableID = table.getAD_Table_ID();
	                			}
	                		}
	            		}
	            		if (refTableID > 0 && ! role.isRecordAccess(refTableID, (int)value, false))
                		{
                			oldValue = value;
                			setReadWrite(false);
                			gridField.setLockedRecord(true);
                		}
                		else
                		{
		            		getComponent().setValue(null);
		            		if (curValue == null)
		            			curValue = value;
		            		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), curValue, null);
		        	        super.fireValueChange(changeEvent);
		            		oldValue = null;
		            		if (gridField!=null)
                				gridField.setLockedRecord(false);
                		}
	            	}
                }
            }
            else
            {
            	oldValue = value;
				if (gridField!=null)
            		gridField.setLockedRecord(false);
            }
        }
        else
        {
            getComponent().setValue(null);
            oldValue = null;
        }
    }
    
    @Override
	public RadioGroupEditor getComponent() {
		return (RadioGroupEditor) component;
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	private void refreshList()
    {
    	if (getComponent().getItemCount() > 0)
    		getComponent().removeAllItems();

    	if (isReadWrite())
    	{
	        if (lookup != null)
	        {
	        	lookup.refresh();
	            int size = lookup.getSize();
	            
	            boolean found = false;
	            for (int i = 0; i < size; i++)
	            {
	                Object obj = lookup.getElementAt(i);
	                if (obj instanceof KeyNamePair)
	                {
	                    KeyNamePair lookupKNPair = (KeyNamePair) obj;
	                    getComponent().appendItem(lookupKNPair.getName(), lookupKNPair.getKey());
	                    if (!found && oldValue != null && oldValue instanceof Integer &&
	                    	lookupKNPair.getKey() == (Integer)oldValue)
	                    {
	                    	found = true;
	                	}
	                }
	                else if (obj instanceof ValueNamePair)
	                {
	                    ValueNamePair lookupKNPair = (ValueNamePair) obj;
	                    getComponent().appendItem(lookupKNPair.getName(), lookupKNPair.getValue());
	                    if (!found && oldValue != null && lookupKNPair.getValue().equals(oldValue.toString()))
		                {
	                    	found = true;
	                	}
	            	}
	        	}	        	        
	            if (!found && oldValue != null)
	            {
	            	NamePair pair = lookup.getDirect(oldValue, false, true);
	            	if (pair != null) {
		    			if (pair instanceof KeyNamePair) {
		    				int key = ((KeyNamePair)pair).getKey();
		    				getComponent().appendItem(pair.getName(), key);
		    			} else if (pair instanceof ValueNamePair) {
		    				ValueNamePair valueNamePair = (ValueNamePair) pair;
		                    getComponent().appendItem(valueNamePair.getName(), valueNamePair.getValue());
		    			}
	            	}
	            }
	        }
    	}
    	else
    	{
    		if (lookup != null)
	        {
    			String trxName = null;
    			if (   gridField != null
   					&& gridField.getGridTab() != null
   					&& gridField.getGridTab().getTableModel() != null) {
    				GridTable gt = gridField.getGridTab().getTableModel();
    				if (gt.isImporting()) {
    					trxName = gt.get_TrxName();
    				}
    			}
    			NamePair pair = lookup.getDirect(oldValue, false, false, trxName);
    			if (pair != null) {
    				if (pair instanceof KeyNamePair) {
    					int key = ((KeyNamePair)pair).getKey();
    					getComponent().appendItem(pair.getName(), key);
    				} else if (pair instanceof ValueNamePair) {
    					ValueNamePair valueNamePair = (ValueNamePair) pair;
                    	getComponent().appendItem(valueNamePair.getName(), valueNamePair.getValue());
    				}
	        	}
    		}
    	}
    	getComponent().setValue(oldValue);
    }
    
    public void onEvent(Event event)
    {
    	if (Events.ON_CHECK.equalsIgnoreCase(event.getName()))
    	{
    		try {
    			onselecting = true;
		        Object newValue = getValue();
		        if (isValueChange(newValue)) {
		        	try {
		        		if (gridField != null) 
		        			gridField.setLookupEditorSettingValue(true);
				        ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
				        super.fireValueChange(changeEvent);
				        oldValue = newValue;
		    			getComponent().setValue(newValue);
		        	} finally {
		        		if (gridField != null) 
		        			gridField.setLookupEditorSettingValue(false);
		        	}
		        }
    		} finally {
    			onselecting = false;
    		}
    	}
    }

	private boolean isValueChange(Object newValue) {
		return (oldValue == null && newValue != null) || (oldValue != null && newValue == null) 
			|| ((oldValue != null && newValue != null) && !oldValue.equals(newValue));
	}
    
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

    public void actionRefresh()
    {    	
		if (lookup != null)
        {
			Object curValue = getValue();
			
			if (isReadWrite())
			{
				if (lookup instanceof MLookup)
					((MLookup) lookup).refreshItemsAndCache();
				else
					lookup.refresh();
			}
			else
				refreshList();
            if (curValue != null)
            {
            	setValue(curValue);
            }
        }
    }
    
    public Lookup getLookup()
    {
    	return lookup;
    }
    
	public void onMenu(ContextMenuEvent evt) 
	{
		if (WEditorPopupMenu.REQUERY_EVENT.equals(evt.getContextEvent()))
		{
			actionRefresh();
		}
		else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
			return;
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
		else if (WEditorPopupMenu.ZOOM_EVENT.equals(evt.getContextEvent()))
		{
			actionZoom();
		}
	}
	
	public  void propertyChange(PropertyChangeEvent evt)
	{
		if ("FieldValue".equals(evt.getPropertyName()))
		{
			setValue(evt.getNewValue());
		}
	}
	
	@Override
	public void dynamicDisplay(Properties ctx) 
	{
		if (oldValue != null && getComponent().getItemCount() > 0 && getComponent().getSelectedItem() == null)
		{
			getComponent().setValue(oldValue);
		}
		
		if (lookup instanceof MLookup) 
		{
			((MLookup) lookup).getLookupInfo().ctx = ctx;
		}
		if ((lookup != null) && (!lookup.isValidated() || !lookup.isLoaded()
			|| (isReadWrite() && lookup.getSize() != getComponent().getItemCount())))
			this.actionRefresh();

		super.dynamicDisplay(ctx);
		
		if (!ClientInfo.isMobile() && getPopupMenu().getParent() != null && getComponent().radioGroup.getContext() == null)
			getPopupMenu().addContextElement(getComponent().radioGroup);
    }
	
	private static class RadioGroupEditor extends Hlayout {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = -8814498538711459900L;
		private Radiogroup radioGroup;
		private boolean enabled;
		
		private RadioGroupEditor() {
			newRadioGroup();
			appendChild(radioGroup);
			enabled = true;
			setSpacing("0");
			setStyle("white-space: normal");
		}

		private void newRadioGroup() {
			radioGroup = new Radiogroup();
		}
		
		public boolean isEnabled() {
			return enabled;
		}

		public void setEnabled(boolean readWrite) {
			enabled = readWrite;
			List<Radio> items = radioGroup.getItems();
			for (Radio radio : items) {
				radio.setDisabled(!readWrite);
			}
		}

		public boolean isSelected(Object value) {
			Radio radio = getSelectedItem();
			if (radio != null && radio.getValue() != null && value != null) {
				return radio.getValue().equals(value);
			}
			return false;
		}

		public Radio getSelectedItem() {
			return radioGroup.getSelectedItem();
		}

		public void setSelectedItem(Radio item) {
			if (item != null && item.isSelected())
				item.setSelected(false);
			radioGroup.setSelectedItem(item);	
		}
		
		public void removeAllItems() {
			List<Radio> items = radioGroup.getItems();
			for (Radio radio : items) {
				radio.detach();
			}
		}

		public void setValue(Object newValue) {			
			boolean found = false;
			if (newValue != null) {
				List<Radio> items = radioGroup.getItems();
				for (Radio radio : items) {
					if (radio.getValue() != null && radio.getValue().equals(newValue)) {
						setSelectedItem(radio);
						found = true;
						break;
					}
				}
			}
			if (!found)
				setSelectedItem(null);
		}

		public int getItemCount() {
			return radioGroup.getItemCount();
		}

		public void appendItem(String name, String value) {
			if (Util.isEmpty(name))
				return;
			Radio radio = newRadio(name, value);
			radioGroup.appendChild(radio);
		}

		protected Radio newRadio(String name, Object value) {
			Radio radio = new Radio(name);
			radio.setValue(value);
			radio.setDisabled(!enabled);
			radio.setStyle("padding-right:1em");
			return radio;
		}

		public void appendItem(String name, int key) {
			if (Util.isEmpty(name))
				return;
			Radio radio = newRadio(name, key);
			radioGroup.appendChild(radio);
		}

		@Override
		public boolean addEventListener(String evtnm, EventListener<? extends Event> listener) {
			if (Events.ON_CHECK.equals(evtnm))
				return radioGroup.addEventListener(evtnm, listener);
			else
				return super.addEventListener(evtnm, listener);
		}

		@Override
		public boolean addEventListener(int priority, String evtnm, EventListener<? extends Event> listener) {
			if (Events.ON_CHECK.equals(evtnm))
				return radioGroup.addEventListener(priority, evtnm, listener);
			else
				return super.addEventListener(priority, evtnm, listener);
		}

		@Override
		public boolean removeEventListener(String evtnm, EventListener<? extends Event> listener) {
			if (Events.ON_CHECK.equals(evtnm))
				return radioGroup.removeEventListener(evtnm, listener);
			else
				return super.removeEventListener(evtnm, listener);
		}		
	}

	@Override
	public void intervalAdded(ListDataEvent e) {
	}

	@Override
	public void intervalRemoved(ListDataEvent e) {
	}

	@Override
	public void contentsChanged(ListDataEvent e) {
		refreshList();
	}
	
	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IZoomableEditor#actionZoom()
	 */
    public void actionZoom()
	{
   		AEnv.actionZoom(lookup, getValue());
	}
}
