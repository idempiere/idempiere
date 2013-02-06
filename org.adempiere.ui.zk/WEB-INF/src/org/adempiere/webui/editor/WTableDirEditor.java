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

import java.beans.PropertyChangeEvent;

import javax.swing.event.ListDataEvent;
import javax.swing.event.ListDataListener;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.grid.WQuickEntry;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WLocationDialog;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MLocation;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Menuitem;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 12, 2007
 * @version $Revision: 0.10 $
 */
public class WTableDirEditor extends WEditor implements ListDataListener, 
ContextMenuListener, IZoomableEditor
{
    public final static String[] LISTENER_EVENTS = {Events.ON_SELECT};
    
    @SuppressWarnings("unused")
	private static final CLogger logger;
    
    static
    {
        logger = CLogger.getCLogger(WTableDirEditor.class);
    }
    
    private Lookup  lookup;
    private Object oldValue;

    public static final String SHORT_LIST_EVENT = "SHORT_LIST";	// IDEMPIERE 90
    protected boolean onlyShortListItems;	// IDEMPIERE 90

    public WTableDirEditor(GridField gridField)
    {
        super(new Combobox(), gridField);
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
    public WTableDirEditor(Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
	{
		super(new Combobox(), label, description, mandatory, readonly, updateable);
		
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
    public WTableDirEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable,
    		Lookup lookup)
    {
    	super(new Combobox(), columnName, null, null, mandatory, isReadOnly, isUpdateable);
    	if (lookup == null)
		{
			throw new IllegalArgumentException("Lookup cannot be null");
		}
    	this.lookup = lookup;
    	init();
    }
    
    private void init()
    {
        getComponent().setWidth("200px"); 
        getComponent().setAutocomplete(true);
        getComponent().setAutodrop(true);
        getComponent().addEventListener(Events.ON_BLUR, this);

        boolean zoom= false;
        if (lookup != null)
        {
            lookup.addListDataListener(this);
            //always need the empty item for zk to work correctly
            lookup.setMandatory(false);
            
            if ((lookup.getDisplayType() == DisplayType.List && Env.getContextAsInt(Env.getCtx(), "#AD_Role_ID") == 0)
            		|| lookup.getDisplayType() != DisplayType.List) 
            {
    			zoom= true;
            }
            
            //no need to refresh readonly lookup
            if (isReadWrite())
            	lookup.refresh();
            refreshList();
        }
        
        if (gridField != null) 
        {
        	String columnName = getColumnName();
    		if ((columnName.toUpperCase().equals("C_BPARTNER_LOCATION_ID"))
    				|| (columnName.toUpperCase().equals("BILL_LOCATION_ID"))
    				|| (columnName.toUpperCase().equals("DROPSHIP_LOCATION_ID")))
    		{
    			popupMenu = new WEditorPopupMenu(true, true, isShowPreference(), false, false, true, lookup);
    		} else {
            	popupMenu = new WEditorPopupMenu(zoom, true, isShowPreference(), false, false, false, lookup);
    		}
        	addChangeLogMenu(popupMenu);

        	//	IDEMPIERE 90
        	boolean isShortListAvailable = false;	// Short List available for this lookup
        	if (lookup != null && (lookup.getDisplayType() == DisplayType.TableDir || lookup.getDisplayType() == DisplayType.Table))	// only for Table & TableDir
        	{
        		String tableName_temp = lookup.getColumnName();	// Returns AD_Org.AD_Org_ID
        		int posPoint = tableName_temp.indexOf(".");
        		String tableName = tableName_temp.substring(0, posPoint);
    			MTable table = MTable.get(Env.getCtx(), tableName);
    			isShortListAvailable = (table.getColumnIndex("IsShortList") >= 0);
        		if (isShortListAvailable)
        		{
        			onlyShortListItems=true;
        			lookup.setShortList(true);
        			getLabel().setText(">" + getGridField().getHeader() + "<");
        			actionRefresh();

        			// add in popup menu
        			Menuitem searchMode;
        			searchMode = new Menuitem();
        			searchMode.setAttribute(WEditorPopupMenu.EVENT_ATTRIBUTE, SHORT_LIST_EVENT);
        			searchMode.setLabel(Msg.getMsg(Env.getCtx(), "ShortListSwitchSearchMode"));
        			searchMode.setImage("/images/Lock16.png");
        			searchMode.addEventListener(Events.ON_CLICK, popupMenu);
        			popupMenu.appendChild(searchMode);
        		}
        	}
        	//	IDEMPIERE 90
        }
    }

    @Override
    public String getDisplay()
    {

        String display = null;
        Comboitem selItem = getComponent().getSelectedItem();
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
        Comboitem selItem = getComponent().getSelectedItem();
        if (selItem != null)
        {
            retVal = selItem.getValue();
            if ((retVal instanceof Integer) && (Integer)retVal == -1)
            	retVal = null;
        }
        return retVal;
    }

    public void setValue(Object value)
    {
    	if (value != null && (value instanceof Integer || value instanceof String))
        {

            getComponent().setValue(value);            
            if (!getComponent().isSelected(value))
            {
            	if (isReadWrite() && lookup != null)
            		lookup.refresh();
            	Object curValue = oldValue;
                oldValue = value;
                refreshList();
                
                //still not in list, reset to zero
                if (!getComponent().isSelected(value))
                {
                	if (value instanceof Integer && gridField != null && gridField.getDisplayType() != DisplayType.ID) // for IDs is ok to be out of the list
                	{
                		getComponent().setValue(null);
                		if (curValue == null)
                			curValue = value;
                		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), curValue, null);
            	        super.fireValueChange(changeEvent);
                		oldValue = null;
                	}
                }
            }
            else
            {
            	oldValue = value;
            }
        }
        else
        {
            getComponent().setValue(null);
            oldValue = value;
        }                                
    }
    
    @Override
	public Combobox getComponent() {
		return (Combobox) component;
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
	            	NamePair pair = lookup.getDirect(oldValue, false, false);
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
    			NamePair pair = lookup.getDirect(oldValue, false, false);
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
    	if (Events.ON_SELECT.equalsIgnoreCase(event.getName()))
    	{
	        Object newValue = getValue();
	        if (isValueChange(newValue)) {
		        ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
		        super.fireValueChange(changeEvent);
		        oldValue = newValue;
	        }
    	}
    	else if (Events.ON_BLUR.equalsIgnoreCase(event.getName()))
    	{
    		Comboitem item = getComponent().getSelectedItem();
    		if (item == null) 
    		{
    			setValue(oldValue);
    		}
    		else 
    		{
    			//on select not fire for empty label item
    			if (item.getLabel().equals(""))
    			{
    				Object newValue = getValue();
    				if (isValueChange(newValue)) {
	    				ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
	    		        super.fireValueChange(changeEvent);
	    		        oldValue = newValue;
    				}
    			}
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

    public void contentsChanged(ListDataEvent e)
    {
        refreshList();
    }

    public void intervalAdded(ListDataEvent e)
    {}

    public void intervalRemoved(ListDataEvent e)
    {}
    
    public void actionRefresh()
    {    	
		if (lookup != null)
        {
			Object curValue = getValue();
			
			if (isReadWrite())
				lookup.refresh();
            refreshList();
            if (curValue != null)
            {
            	setValue(curValue);
            }
        }
    }
    
    /* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IZoomableEditor#actionZoom()
	 */
    public void actionZoom()
	{
    	AEnv.actionZoom(lookup, getValue());
	}
    
	/**
	 *	Action - Special Quick Entry Screen
	 *  @param newRecord true if new record should be created
	 */
	private void actionQuickEntry (boolean newRecord)
	{
		if(!getComponent().isEnabled())
			return;

		final WQuickEntry vqe = new WQuickEntry (lookup.getWindowNo(), lookup.getZoom());
		int Record_ID = 0;

		Object value = getValue();
		//  if update, get current value
		if (!newRecord)
		{
			if (value instanceof Integer)
				Record_ID = ((Integer)value).intValue();
			else if (value != null && "".compareTo(value.toString())!= 0)
				Record_ID = Integer.parseInt(value.toString());
		}

		vqe.loadRecord (Record_ID);

		final int finalRecord_ID = Record_ID;
		vqe.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				// get result
				int result = vqe.getRecord_ID();

				if (result == 0					//	0 = not saved
					&& result == finalRecord_ID)	//	the same
					return;

				//  Maybe new Record - put in cache
				Object newValue = new Integer(result);
				lookup.getDirect(newValue, false, true);
				setValue(new Integer(result));
		        ValueChangeEvent changeEvent = new ValueChangeEvent(this, getColumnName(), oldValue, newValue);
		        fireValueChange(changeEvent);
		        oldValue = newValue;
			}
		});

		vqe.setVisible(true);
		AEnv.showWindow(vqe);		
	}	//	actionQuickEntry

	private void actionLocation() {
		int BPLocation_ID = 0;
		Object value = getValue();
		if (value instanceof Integer)
			BPLocation_ID = ((Integer)value).intValue();
		else if (value != null)
			BPLocation_ID = Integer.parseInt(value.toString());

		if (BPLocation_ID>0)
		{
			MBPartnerLocation bpl = new MBPartnerLocation(Env.getCtx(), BPLocation_ID, null);
			MLocation location= new MLocation(Env.getCtx(), bpl.getC_Location_ID(), null);

			final WLocationDialog vbp = new WLocationDialog(Msg.getMsg(Env.getCtx(), "Location"), location);
			vbp.setVisible(true);
			AEnv.showWindow(vbp);		
		}

	} // actionLocation

	public void onMenu(ContextMenuEvent evt) 
	{
		if (WEditorPopupMenu.REQUERY_EVENT.equals(evt.getContextEvent()))
		{
			actionRefresh();
		}
		else if (WEditorPopupMenu.ZOOM_EVENT.equals(evt.getContextEvent()))
		{
			actionZoom();
		}
		else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
			return;
		}
		else if (WEditorPopupMenu.NEW_EVENT.equals(evt.getContextEvent()))
		{
			actionQuickEntry(true);
		}
		else if (WEditorPopupMenu.UPDATE_EVENT.equals(evt.getContextEvent()))
		{
			actionQuickEntry(false);
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
		else if (WEditorPopupMenu.SHOWLOCATION_EVENT.equals(evt.getContextEvent()))
		{
			actionLocation();
		}
		// IDEMPIERE 90
		else if (SHORT_LIST_EVENT.equals(evt.getContextEvent()))
		{
			String champ = getGridField().getHeader();

			if(onlyShortListItems)
			{
				onlyShortListItems=false;
				lookup.setShortList(false);
				actionRefresh();			
				getLabel().setText(champ);
			}else{
				onlyShortListItems=true;
				lookup.setShortList(true);
				actionRefresh();
				getLabel().setText(">" + champ + "<");
			}
		}
		// IDEMPIERE 90
	}
	
	public  void propertyChange(PropertyChangeEvent evt)
	{
		if ("FieldValue".equals(evt.getPropertyName()))
		{
			setValue(evt.getNewValue());
		}
	}
	
	@Override
	public void dynamicDisplay()
    {    	
		if ((lookup != null) && (!lookup.isValidated() || !lookup.isLoaded()
			|| (isReadWrite() && lookup.getSize() != getComponent().getItemCount())))
			this.actionRefresh();
    }
}
