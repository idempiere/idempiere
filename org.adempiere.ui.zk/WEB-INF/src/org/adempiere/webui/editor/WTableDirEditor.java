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
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import javax.swing.event.ListDataEvent;
import javax.swing.event.ListDataListener;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.AutoComplete;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.grid.WQuickEntry;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WLocationDialog;
import org.compiere.model.GridField;
import org.compiere.model.GridTable;
import org.compiere.model.Lookup;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MColumn;
import org.compiere.model.MLocation;
import org.compiere.model.MLocator;
import org.compiere.model.MLookup;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zk.ui.sys.SessionCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.DesktopCleanup;
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

	private CCacheListener tableCacheListener;

	private boolean onselecting = false;

	/**
	 * 
	 * @param gridField
	 */
	public WTableDirEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WTableDirEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(gridField.isAutocomplete() ? new EditorAutoComplete() : new EditorCombobox(), gridField, tableEditor, editorConfiguration);
        ((ITableDirEditor)getComponent()).setEditor(this);
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
    	this(lookup, label, description, mandatory, readonly, updateable, false);
	}
    
    public WTableDirEditor(Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable, boolean autocomplete)
    {
    	this(autocomplete ? new EditorAutoComplete() : new EditorCombobox(), lookup, label, description, mandatory, readonly, updateable);
    }
    
    private WTableDirEditor(Component comp, Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
    {
    	super(comp, label, description, mandatory, readonly, updateable);
    	((ITableDirEditor)getComponent()).setEditor(this);
		
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
    public WTableDirEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable, Lookup lookup)
    {
    	this(columnName, mandatory, isReadOnly, isUpdateable, lookup, false);
    }
    
    public WTableDirEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable, Lookup lookup, boolean autocomplete)
    {
    	this(autocomplete ? new EditorAutoComplete() : new EditorCombobox(), columnName, mandatory, isReadOnly, isUpdateable, lookup);
    }
    
    private WTableDirEditor(Component comp, String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable, Lookup lookup)
    {
    	super(comp, columnName, null, null, mandatory, isReadOnly, isUpdateable);
    	((ITableDirEditor)getComponent()).setEditor(this);
    	if (lookup == null)
		{
			throw new IllegalArgumentException("Lookup cannot be null");
		}
    	this.lookup = lookup;
    	init();
    }
    
    private void init()
    {
    	ZKUpdateUtil.setWidth(getComponent(), "200px"); 
        getComponent().setAutocomplete(true);
        getComponent().setAutodrop(true);
    	getComponent().addEventListener(Events.ON_BLUR, this);
        if (getComponent() instanceof EditorAutoComplete) {
        	;
        } else {
        	getComponent().addEventListener(Events.ON_CHANGING, this);
        }

        boolean zoom= false;
        if (lookup != null)
        {
            lookup.addListDataListener(this);
            lookup.setMandatory(isMandatory());
            
            if ((lookup.getDisplayType() == DisplayType.List && Env.getContextAsInt(Env.getCtx(), "#AD_Role_ID") == 0)
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
        
        String tableName_temp = lookup.getColumnName();	// Returns AD_Org.AD_Org_ID
        int posPoint = tableName_temp.indexOf(".");
		String tableName = tableName_temp.substring(0, posPoint);
		
        if (tableName.toUpperCase().equals("C_BPARTNER_LOCATION"))    				
		{
			popupMenu = new WEditorPopupMenu(true, true, isShowPreference(), false, false, true, lookup);
		} else {
        	popupMenu = new WEditorPopupMenu(zoom, true, isShowPreference(), false, false, false, lookup);
		}
    	addChangeLogMenu(popupMenu);
    	
        if (gridField != null) 
        {
        	//	IDEMPIERE 90
        	boolean isShortListAvailable = false;	// Short List available for this lookup
        	if (lookup != null && (lookup.getDisplayType() == DisplayType.TableDir || lookup.getDisplayType() == DisplayType.Table))	// only for Table & TableDir
        	{
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
        			if(ThemeManager.isUseFontIconForImage())
        				searchMode.setIconSclass("z-icon-Lock");
        			else
        				searchMode.setImage(ThemeManager.getThemeResource("images/Lock16.png"));
        			searchMode.addEventListener(Events.ON_CLICK, popupMenu);
        			popupMenu.appendChild(searchMode);
        		}
        	}
        	//	IDEMPIERE 90
        }
        if (gridField != null)
        	getComponent().setPlaceholder(gridField.getPlaceholder());
    }

	private void createCacheListener() {
		if (lookup != null) {
			String columnName = lookup.getColumnName();
			int dotIndex = columnName.indexOf(".");
			if (dotIndex > 0) {
				String tableName = columnName.substring(0, dotIndex);
				tableCacheListener = new CCacheListener(tableName, this);
			}
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
            getComponent().setSelectedItem(null);
            oldValue = value;
            
            if (getComponent() instanceof EditorAutoComplete && gridField!=null)	// IDEMPIERE-4442 Fix NPE, for Autocomplete in non Grid Usage.
            	updateStyle();
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
		getComponent().setButtonVisible(readWrite);
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
	                else if (obj instanceof MLocator)
	                {
	                	MLocator lookupKNPair = (MLocator) obj;
	                    getComponent().appendItem(lookupKNPair.getValue(), lookupKNPair.getM_Locator_ID());
	                    if (!found && oldValue != null && lookupKNPair.getM_Locator_ID() == (Integer) oldValue)
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

    	if (getComponent() instanceof EditorAutoComplete) {
    		EditorAutoComplete editor = (EditorAutoComplete) getComponent();
    		editor.setDict(null);
    		editor.setValues(null);
    		editor.setDescription(null);
        	
    		String[] dict = new String[getComponent().getItemCount()];
    		Object[] values = new Object[getComponent().getItemCount()];
    		String[] description = new String[getComponent().getItemCount()];
        	for (int i = 0; i < dict.length; i++) {
        		Comboitem item = getComponent().getItemAtIndex(i);
        		dict[i] = item.getLabel();
        		values[i] = item.getValue();
        	}
        	editor.setDict(dict, false);
        	editor.setDescription(description);
        	editor.setValues(values);
    	}
    	
    	getComponent().setValue(oldValue);
    }
    
    public void onEvent(Event event)
    {
    	if (Events.ON_SELECT.equalsIgnoreCase(event.getName()))
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
		        if (newValue != null)
		        	focusNext();
    		} finally {
    			onselecting = false;
    		}
    		Events.echoEvent("onPostSelect", getComponent(), null);
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
    	} else if (event.getName().equals(Events.ON_CHANGING)) {
    		onChanging((InputEvent) event);
    	} else if (event.getName().equals("onPostSelect")) {
    		if (getComponent().isOpen()) {
	    		getComponent().select();
	    		getComponent().setOpen(false);
	    		getComponent().setOpen(true);
    		}
    	} 
    }

    private void onChanging(InputEvent event) {
		String v = event.getValue();
		if (!Util.isEmpty(v)) {
			v = v.toLowerCase();
			int count = getComponent().getItemCount();
			for(int i = 0; i < count; i++) {
				Comboitem item = getComponent().getItemAtIndex(i);
				if(item.getLabel() != null && item.getLabel().toLowerCase().startsWith(v)) {
					Clients.scrollIntoView(item);
					break;
				}
			}
		} else if (getComponent().getItemCount() > 0) {
			Comboitem item = getComponent().getItemAtIndex(0);
			Clients.scrollIntoView(item);
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
    
    /* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IZoomableEditor#actionZoom()
	 */
    public void actionZoom()
	{
   		AEnv.actionZoom(lookup, getValue());
	}
    
    public Lookup getLookup()
    {
    	return lookup;
    }
    
	/**
	 *	Action - Special Quick Entry Screen
	 *  @param newRecord true if new record should be created
	 */
	protected void actionQuickEntry (boolean newRecord)
	{
		if(!getComponent().isEnabled())
			return;

		int tabNo = gridField != null && gridField.getGridTab() != null ? gridField.getGridTab().getTabNo() : 0;
		final WQuickEntry vqe = new WQuickEntry(lookup.getWindowNo(), tabNo, lookup.getZoom());
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
				Object newValue = Integer.valueOf(result);
				lookup.getDirect(newValue, false, true);
				setValue(Integer.valueOf(result));
		        ValueChangeEvent changeEvent = new ValueChangeEvent(this, getColumnName(), oldValue, newValue);
		        fireValueChange(changeEvent);
		        oldValue = newValue;
			}
		});

		vqe.setVisible(true);
		AEnv.showWindow(vqe);		
	}	//	actionQuickEntry

	protected void actionLocation() {
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
				ValuePreference.start (getComponent(), this.getGridField(), getValue(), getDisplay());
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
	public void dynamicDisplay(Properties ctx) 
	{
		if (lookup instanceof MLookup) 
		{
			((MLookup) lookup).getLookupInfo().ctx = ctx;
		}
		if ((lookup != null) && (!lookup.isValidated() || !lookup.isLoaded()
			|| (isReadWrite() && lookup.getSize() != getComponent().getItemCount())))
			this.actionRefresh();
		
		super.dynamicDisplay(ctx);
    }
	
	private interface ITableDirEditor {
		public void setEditor(WTableDirEditor editor);
		public void cleanup();
	}
		
	@Override
	public String getDisplayTextForGridView(Object value) {
		String s = super.getDisplayTextForGridView(value);
		if (ClientInfo.isMobile( )&& MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_MOBILE_LINE_BREAK_AS_IDENTIFIER_SEPARATOR, true)) {
			String separator = MSysConfig.getValue(MSysConfig.IDENTIFIER_SEPARATOR, null, Env.getAD_Client_ID(Env.getCtx()));
			if (!Util.isEmpty(separator, true) && s.indexOf(separator) >= 0) {
				s = s.replace(separator, "\n");
			}
		}
		return s;
	}

	private static class EditorCombobox extends Combobox implements ITableDirEditor {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = 9087317631313577239L;
		private WTableDirEditor editor;
		private DesktopCleanup listener = null;

		protected EditorCombobox() {
			
		}
		
		@Override
		public void setPage(Page page) {
			super.setPage(page);			
		}

		@Override
		public void onPageAttached(Page newpage, Page oldpage) {
			super.onPageAttached(newpage, oldpage);
			if (editor.tableCacheListener == null) {
				editor.createCacheListener();
				if (listener == null) {
					listener = new DesktopCleanup() {						
						@Override
						public void cleanup(Desktop desktop) throws Exception {
							EditorCombobox.this.cleanup();
						}
					};
					newpage.getDesktop().addListener(listener);
				}
			}
		}

		@Override
		public void onPageDetached(Page page) {
			super.onPageDetached(page);
			if (listener != null && page.getDesktop() != null)
				page.getDesktop().removeListener(listener);
			cleanup();
		}

		/**
		 * 
		 */
		public void cleanup() {
			if (editor.tableCacheListener != null) {
				CacheMgt.get().unregister(editor.tableCacheListener);
				editor.tableCacheListener = null;
			}
		}

		@Override
		public void setEditor(WTableDirEditor editor) {
			this.editor = editor;
		}		
	}
	
	private static class EditorAutoComplete extends AutoComplete implements ITableDirEditor {	
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = 8435677226644775152L;
		protected WTableDirEditor editor;
		private DesktopCleanup listener = null;

		protected EditorAutoComplete() {
			
		}
		
		@Override
		public void setPage(Page page) {
			super.setPage(page);			
		}

		@Override
		public void onPageAttached(Page newpage, Page oldpage) {
			super.onPageAttached(newpage, oldpage);
			if (editor.tableCacheListener == null) {
				editor.createCacheListener();
				if (listener == null) {
					listener = new DesktopCleanup() {						
						@Override
						public void cleanup(Desktop desktop) throws Exception {
							EditorAutoComplete.this.cleanup();
						}
					};
					newpage.getDesktop().addListener(listener);
				}
			}
		}

		@Override
		public void onPageDetached(Page page) {
			super.onPageDetached(page);
			if (listener != null && page.getDesktop() != null)
				page.getDesktop().removeListener(listener);
			cleanup();
		}

		/**
		 * 
		 */
		public void cleanup() {
			if (editor.tableCacheListener != null) {
				CacheMgt.get().unregister(editor.tableCacheListener);
				editor.tableCacheListener = null;
			}
		}

		@Override
		public void setEditor(WTableDirEditor editor) {
			this.editor = editor;
		}
		
		@Override
		public void setValue(String value) 
		{
			setText(value);
			if (Util.isEmpty(value)) {
				refresh("");
			}
		}
		
		
	}
	
	private static class CCacheListener extends CCache<String, Object> {
		/**
		 * generated serial
		 */
		private static final long serialVersionUID = 3543247404379028327L;
		private WTableDirEditor editor;
		
		protected CCacheListener(String tableName, WTableDirEditor editor) {
			super(tableName, tableName+"|CCacheListener", 0, 0, true);
			this.editor = editor;
		}

		@Override
		public int reset() {			
			if (editor.getComponent().getDesktop() != null && editor.isReadWrite()) {
				refreshLookupList();
			}
			return 0;					
		}

		private void refreshLookupList() {
			Desktop desktop = editor.getComponent().getDesktop();
			boolean alive = false;
			if (desktop.isAlive() && desktop.getSession() != null) {
				SessionCtrl ctrl = (SessionCtrl) desktop.getSession();
				alive = !ctrl.isInvalidated();
			}
			if (!alive) {
				((ITableDirEditor)editor.getComponent()).cleanup();
				return;
			}
			Executions.schedule(desktop, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) {
					try {
						if (editor.isReadWrite())
							editor.actionRefresh();
					} catch (Exception e) {}
				}
			}, new Event("onResetLookupList"));
		}
				
		@Override
		public void newRecord(int record_ID) {
			if (editor.getComponent().getDesktop() != null && editor.isReadWrite()) {
				refreshLookupList();
			}
		}
	}
}
