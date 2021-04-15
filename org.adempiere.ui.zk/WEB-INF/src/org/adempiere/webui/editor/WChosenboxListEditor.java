/******************************************************************************
 * Project: Trek Global ERP                                                   *
 * Copyright (C) 2009-2018 Trek Global Corporation                			  *
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

import java.beans.PropertyChangeEvent;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.component.ChosenSearchBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.addon.chosenbox.Chosenbox;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.DesktopCleanup;
import org.zkoss.zul.ListModelList;

/**
 * 
 * @author hengsin
 *
 */
public class WChosenboxListEditor extends WEditor implements ContextMenuListener
{
    public final static String[] LISTENER_EVENTS = {Events.ON_SELECT};
    
    @SuppressWarnings("unused")
	private static final CLogger logger;
    
    static
    {
        logger = CLogger.getCLogger(WChosenboxListEditor.class);
    }
    
    private Lookup  lookup;
    private Object oldValue;

	private CCacheListener tableCacheListener;

	private boolean onselecting = false;
	
	private ListModelList<ValueNamePair> model = new ListModelList<>();

	/**
	 * 
	 * @param gridField
	 */
	public WChosenboxListEditor(GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
    public WChosenboxListEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        this(new ChosenSearchBox(new ChosenboxEditor()), gridField, tableEditor, editorConfiguration);
    }
    
    private WChosenboxListEditor(Component comp, GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(comp, gridField, tableEditor, editorConfiguration);
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
    public WChosenboxListEditor(Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
	{
    	this(lookup, label, description, mandatory, readonly, updateable, false);
	}
    
    /**
     * 
     * @param lookup
     * @param label
     * @param description
     * @param mandatory
     * @param readonly
     * @param updateable
     * @param autocomplete
     */
    public WChosenboxListEditor(Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable, boolean autocomplete)
    {
    	this(new ChosenSearchBox(new ChosenboxEditor()), lookup, label, description, mandatory, readonly, updateable);
    }
    
    private WChosenboxListEditor(Component comp, Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
    {
    	super(comp, label, description, mandatory, readonly, updateable);
		
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
    public WChosenboxListEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable, Lookup lookup)
    {
    	this(columnName, mandatory, isReadOnly, isUpdateable, lookup, false);
    }
    
    /**
     * 
     * @param columnName
     * @param mandatory
     * @param isReadOnly
     * @param isUpdateable
     * @param lookup
     * @param autocomplete
     */
    public WChosenboxListEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable, Lookup lookup, boolean autocomplete)
    {
    	this(new ChosenSearchBox(new ChosenboxEditor()), columnName, mandatory, isReadOnly, isUpdateable, lookup);
    }
    
    private WChosenboxListEditor(Component comp, String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable, Lookup lookup)
    {
    	super(comp, columnName, null, null, mandatory, isReadOnly, isUpdateable);
    	if (lookup == null)
		{
			throw new IllegalArgumentException("Lookup cannot be null");
		}
    	this.lookup = lookup;
    	init();
    }
    
    private void init()
    {
        getComponent().setHflex("true"); 
        ((ChosenboxEditor)getComponent().getChosenbox()).editor = this;
        getComponent().getChosenbox().setModel(model);
        String imageUrl;
		if (ThemeManager.isUseFontIconForImage())
			imageUrl = "z-icon-More";
		else
			imageUrl = ThemeManager.getThemeResource("images/ShowMore16.png");
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass(imageUrl);
		else
			getComponent().getButton().setImage(imageUrl);

		getComponent().getButton().addEventListener(Events.ON_CLICK, e -> {
			if (getComponent().isEnabled()) {
				if (!getComponent().getChosenbox().isOpen()) {
					getComponent().getChosenbox().setOpen(true);
					getComponent().getChosenbox().focus();
				}
			}
		});
		
        if (lookup != null)
        {
            lookup.setMandatory(true);
            
            //no need to refresh readonly lookup
            if (isReadWrite()) 
            {
            	refreshLookup();
            }
            else
            {
            	updateModel();
            }
        }
        
        if (gridField != null) 
        {
            popupMenu = new WEditorPopupMenu(false, true, isShowPreference(), false, false, false, lookup);
    		addChangeLogMenu(popupMenu);
        }        
    }

    /**
     * refresh lookup list
     */
	protected void refreshLookup() {
		lookup.refresh();
		updateModel();
	}

    @Override
    public String getDisplay()
    {
        StringBuilder display = new StringBuilder();
        LinkedHashSet<ValueNamePair> selected = getComponent().getChosenbox().getSelectedObjects();
        if (selected != null && selected.size() > 0)
        {
        	for(ValueNamePair pair : selected)
        	{
        		if (display.length() > 0)
        			display.append(", ");
        		display.append(pair.getName());
        	}
        }
        return display.toString();
    }

    @Override
    public Object getValue()
    {
        return oldValue;
    }
    
    private String getValueFromComponent()
	{
		StringBuilder retVal = new StringBuilder();
        LinkedHashSet<ValueNamePair> selected = getComponent().getChosenbox().getSelectedObjects();
        if (selected != null && selected.size() > 0)
        {
        	for(ValueNamePair pair : selected)
        	{
        		if (retVal.length() > 0)
        			retVal.append(",");
        		StringBuilder builder = new StringBuilder(pair.getValue());
        		if (builder.indexOf(",") >= 0)
        		{
        			builder.insert(0, "\"");
        			builder.append("\"");
        		}
        		retVal.append(builder.toString());
        	}
        }
        return retVal.length() > 0 ? retVal.toString() : null;
	}

    /**
     * @param value
     */
    public void setValue(Object value)
    {
    	if (onselecting) {
    		return;
    	}
    	
    	if (value != null)
        {
    		String[] values = ((String)value).split("[,]");
            Set<ValueNamePair> selected = new LinkedHashSet<>();
            for (String key : values) {
            	if (!Util.isEmpty(key)) {
            		if (key.startsWith("\"") && key.endsWith("\"")) {
            			key = key.substring(1, key.length()-1);
            		}
	            	String name = lookup.getDisplay(key);
	            	ValueNamePair pair = new ValueNamePair(key, name);
	            	selected.add(pair);
            	}
            }
			getComponent().getChosenbox().setSelectedObjects(selected);            
            if (getComponent().getChosenbox().getSelectedObjects().size() != selected.size())
            {
            	Object curValue = oldValue;
                oldValue = value;
                
            	if (isReadWrite() && lookup != null)
            	{
            		refreshLookup();
            	}
            	else
            	{
                	updateModel();
            	}
            	getComponent().getChosenbox().setSelectedObjects(selected);
                
                //still not in list, reset to zero
            	if (getComponent().getChosenbox().getSelectedObjects().size() != selected.size())
                {
            		getComponent().getChosenbox().setSelectedObjects(new LinkedHashSet<ValueNamePair>());
            		if (curValue == null)
            			curValue = value;
            		ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), curValue, null);
        	        super.fireValueChange(changeEvent);
            		oldValue = null;
                }
            }
            else
            {
            	oldValue = value;
            }
        }
        else
        {
        	getComponent().getChosenbox().setSelectedObjects(new LinkedHashSet<ValueNamePair>());
            oldValue = value;            
        }
    }
    
    @Override
	public ChosenSearchBox getComponent() {
		return (ChosenSearchBox) component;
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	private void updateModel()
    {
    	List<ValueNamePair> list = new ArrayList<>();

    	if (isReadWrite())
    	{
	        if (lookup != null)
	        {
	            int size = lookup.getSize();
	            
	            for (int i = 0; i < size; i++)
	            {
	                Object obj = lookup.getElementAt(i);
	                if (obj instanceof KeyNamePair)
	                {
	                    KeyNamePair lookupKNPair = (KeyNamePair) obj;
	                    ValueNamePair vnp = new ValueNamePair(Integer.toString(lookupKNPair.getKey()), lookupKNPair.getName());
	                    list.add(vnp);
	                }
	                else if (obj instanceof ValueNamePair)
	                {
	                    ValueNamePair lookupKNPair = (ValueNamePair) obj;
	                    list.add(lookupKNPair);
	            	}
	        	}	        	        
	        }
    	}
    	else
    	{
    		if (lookup != null && oldValue != null)
	        {
    			String[] values = ((String)oldValue).split("[,]");
                List<ValueNamePair> selected = new ArrayList<>();
                for (String key : values) {
                	if (!Util.isEmpty(key)) {
                		if (key.startsWith("\"") && key.endsWith("\"")) {
                			key = key.substring(1, key.length()-1);
                		}
	                	String name = lookup.getDisplay(key);
	                	ValueNamePair pair = new ValueNamePair(key, name);
	                	selected.add(pair);
                	}
                }
    			list = selected;
    		}
    	}

    	model.clear();
    	model.addAll(list);
    }
    
	/**
	 * @param event
	 */
    public void onEvent(Event event)
    {
    	if (Events.ON_SELECT.equalsIgnoreCase(event.getName()))
    	{
    		try {
    			onselecting = true;
		        Object newValue = getValueFromComponent();
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
    		} finally {
    			onselecting = false;
    		}
    	}
    }

	private boolean isValueChange(Object newValue) {
		return (oldValue == null && newValue != null) || (oldValue != null && newValue == null) 
			|| ((oldValue != null && newValue != null) && !oldValue.equals(newValue));
	}
    
	@Override
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	/**
	 * action for requery menu
	 */
    protected void actionRefresh()
    {    	
		if (lookup != null)
        {
			Object curValue = getValue();
			
			if (isReadWrite())
				refreshLookup();
			else
				updateModel();
            if (curValue != null)
            {
            	setValue(curValue);
            }
        }
    }
    
    /**
     * 
     * @return {@link Lookup}
     */
    public Lookup getLookup()
    {
    	return lookup;
    }
    
    @Override
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
	}
	
    @Override
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
			|| (isReadWrite() && lookup.getSize() != getComponent().getChosenbox().getModel().getSize())))
			this.actionRefresh();
		
		super.dynamicDisplay(ctx);
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
	
	private final static class ChosenboxEditor extends Chosenbox<ValueNamePair> {
		
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = 7777300782255405327L;
		private DesktopCleanup listener = null;
		private WChosenboxListEditor editor = null;

		protected ChosenboxEditor() {
		}
		
		@Override
		public void setPage(Page page) {
			super.setPage(page);			
		}

		@Override
		public void onPageAttached(Page newpage, Page oldpage) {
			super.onPageAttached(newpage, oldpage);
			if (editor != null && editor.tableCacheListener == null) {
				editor.createCacheListener();
				if (listener == null) {
					listener = new DesktopCleanup() {						
						@Override
						public void cleanup(Desktop desktop) throws Exception {
							ChosenboxEditor.this.cleanup();
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
		protected void cleanup() {
			if (editor != null && editor.tableCacheListener != null) {
				CacheMgt.get().unregister(editor.tableCacheListener);
				editor.tableCacheListener = null;
			}
		}
	}
	
	private static class CCacheListener extends CCache<String, Object> {
		/**
		 * generated serial
		 */
		private static final long serialVersionUID = 3543247404379028327L;
		private WChosenboxListEditor editor;
		
		protected CCacheListener(String tableName, WChosenboxListEditor editor) {
			super(tableName, tableName+"|CCacheListener", 0, false);
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
			Executions.schedule(editor.getComponent().getDesktop(), new EventListener<Event>() {
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
