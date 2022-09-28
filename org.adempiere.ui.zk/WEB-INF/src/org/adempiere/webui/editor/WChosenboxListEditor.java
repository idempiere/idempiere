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
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ChosenSearchBox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.model.MRefList;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.addon.chosenbox.Chosenbox;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.DesktopCleanup;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.South;

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
    		
    		if (gridField.getDisplayType() == DisplayType.ChosenMultipleSelectionList) { // The Assistant must be shown for MultipleSelectionList only (not for MultipleSelectionTable editors)
        		Menuitem editor = new Menuitem();
	        		editor.setAttribute("EVENT", WEditorPopupMenu.ASSISTANT_EVENT);
        		editor.setLabel(Msg.getMsg(Env.getCtx(), "Assistant"));
        		if (ThemeManager.isUseFontIconForImage())
        			editor.setIconSclass("z-icon-Wizard");
        		else
        			editor.setImage(ThemeManager.getThemeResource("images/Wizard16.png"));
        		editor.addEventListener(Events.ON_CLICK, popupMenu);
        		popupMenu.appendChild(editor);    			
    		}
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
    	
	if (value != null && value instanceof String && !Util.isEmpty((String) value, true))
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
    		updateValue(getValueFromComponent());
    	}
    }
    
    private void updateValue(Object newValue) {
    	try {
			onselecting = true;

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
		else if (WEditorPopupMenu.ASSISTANT_EVENT.equals(evt.getContextEvent())) {

			final WChosenboxListAssistant wdc = new WChosenboxListAssistant();
			wdc.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					
					Object newValue = wdc.getNewValue();
			    	updateValue(newValue);
			    	setValue(newValue.toString());
				}
			});

			AEnv.showWindow(wdc);
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
	
	private class WChosenboxListAssistant extends Window implements EventListener<Event> {
		private static final long serialVersionUID = 1043859495570181469L;
		private Button bAdd, bRemove, bUp, bDown;
		private SimpleListModel availableModel = new SimpleListModel();
		private SimpleListModel selectedModel = new SimpleListModel();
		private Listbox availableList = new Listbox();
		private Listbox selectedList = new Listbox();
		private Hlayout hlayout;
		private Button bOk = ButtonFactory.createNamedButton(ConfirmPanel.A_OK, false, true);
		private int refID = 0;
		private String m_newValue = "";

		public WChosenboxListAssistant() {
			super();
			refID = gridField.getAD_Reference_Value_ID();
			setTitle(gridField.getHeader() + " " + Msg.getMsg(Env.getCtx(), "Assistant"));
			init();
			load();
			setClosable(true);
			setBorder("normal");
			setShadow(true);
			setMaximizable(true);
			setSizable(true);

			if (!ThemeManager.isUseCSSForWindowSize()) {			
				ZKUpdateUtil.setWindowHeightX(this, 600);
				ZKUpdateUtil.setWindowWidthX(this, 700);
			}
			else
			{
				addCallback(AFTER_PAGE_ATTACHED, t -> {
					ZKUpdateUtil.setCSSHeight(this);
					ZKUpdateUtil.setCSSWidth(this);
				});
			}
			setSclass("chosenbox-assistant-dialog");

			addCallback(AFTER_PAGE_DETACHED, t -> {
				WChosenboxListEditor.this.getComponent().getChosenbox().focus();
			});
		}

		private void init() {
			m_newValue = getValue() != null ? getValue().toString() : "";

			Borderlayout mainLayout = new Borderlayout();
			appendChild(mainLayout);

			Center center = new Center();
			mainLayout.appendChild(center);
			center.setAutoscroll(true);

			EventListener<Event> actionListener = new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					migrateValueAcrossLists(event);
				}
			};

			EventListener<Event> actionListener2 = new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					migrateValueWithinSelectedList(event);
				}
			};

			EventListener<Event> mouseListener = new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					if (Events.ON_DOUBLE_CLICK.equals(event.getName())) {
						migrateValueAcrossLists(event);
					}
				}
			};

			EventListener<Event> crossListMouseListener = new DragListener();

			bUp = createButton("MoveUp16", actionListener2);
			bDown = createButton("MoveDown16", actionListener2);
			bAdd = createButton("MoveRight16", actionListener);
			bRemove = createButton("MoveLeft16", actionListener);
			bOk.addEventListener(Events.ON_CLICK, this);
			
			Hlayout yesButtonLayout = createHlayoutBtn(new Button[] {bUp, bDown});
			Hlayout noButtonLayout = createHlayoutBtn(new Button[] {bRemove, bAdd});

			initListboxAndModel(selectedList, selectedModel, mouseListener, crossListMouseListener, true, Msg.getMsg(Env.getCtx(), "SelectedItems"), yesButtonLayout);
			initListboxAndModel(availableList, availableModel, mouseListener, crossListMouseListener, true, Msg.getMsg(Env.getCtx(), "Available"), noButtonLayout);

			hlayout = createHlayoutLine(new Component[] {availableList, selectedList});
			center.appendChild(hlayout);

			Panel confirmPanel = new Panel();
			confirmPanel.setSclass("confirm-panel-right");
			confirmPanel.appendChild(bOk);

			South south = new South();
			south.setSclass("dialog-footer");
			mainLayout.appendChild(south);
			south.appendChild(confirmPanel);
		}

		private void load() {
			selectedModel.removeAllElements();
			availableModel.removeAllElements();

			// selected
			Object values = getValue();
			ArrayList<String> listSelected = new ArrayList<String>();
			if (values != null && !Util.isEmpty((String) values)) {
				for (String value : ((String) values).split(",")) {
					selectedModel.addElement(new ValueNamePair (value, MRefList.getListName(Env.getCtx(), refID, value)));
					listSelected.add(value);
				}	
			}

			// available (data - available)
			String validationCode = gridField.getVO().ValidationCode;
			if (!Util.isEmpty(validationCode)) {
				validationCode = Env.parseContext(Env.getCtx(), gridField.getWindowNo(), gridField.getVO().TabNo, validationCode, false);
				if (Util.isEmpty(validationCode, true)) {
					//not validated, ensure list is empty
					validationCode = "1=2";
				}
			}

			for (ValueNamePair vnp : MRefList.getList(Env.getCtx(), refID, false, validationCode, "")) {

				if (listSelected.contains(vnp.getValue()))
					continue;

				availableModel.addElement(new ValueNamePair (vnp.getValue(), MRefList.getListName(Env.getCtx(), refID, vnp.getValue())));
				listSelected.add(vnp.getValue());
			}
		}
	
		public void onEvent(Event event) throws Exception {
			if (event.getTarget() == bOk) {

				StringBuilder value = new StringBuilder("");

				for (Listitem le : selectedList.getItems()) {
					int index = selectedList.getIndexOfItem(le);
					ValueNamePair  selObject = (ValueNamePair ) selectedModel.getElementAt(index);
					value.append(selObject.getID()).append(",");
				}

				if (value.length() > 0)
					value = value.deleteCharAt(value.length() - 1);
				m_newValue = value.toString();
				this.detach();
			}
		}

		private Button createButton(String image, EventListener<Event> actionListener) {
			Button btn = ButtonFactory.createButton(null, ThemeManager.getThemeResource("images/" + image + ".png"), null);
			LayoutUtils.addSclass("btn-small", btn);
			LayoutUtils.addSclass("btn-sorttab small-img-btn", btn);
			btn.addEventListener(Events.ON_CLICK, actionListener);
			return btn;
		}

		private void initListboxAndModel(Listbox lb, SimpleListModel model, EventListener<Event> mouseListener, EventListener<Event> crossListMouseListener, boolean isItemDraggable, String headerLabel, Hlayout buttonsLayout) {
			lb.addEventListener(Events.ON_RIGHT_CLICK, this);
			ZKUpdateUtil.setHflex(lb, "1");
			ZKUpdateUtil.setVflex(lb, true);

			if (mouseListener != null)
				lb.addDoubleClickListener(mouseListener);
			if (crossListMouseListener != null)
				lb.addOnDropListener(crossListMouseListener);
			lb.setItemDraggable(isItemDraggable);
			lb.setItemRenderer(model);
			lb.setModel(model);
			model.setMultiple(true);

			ListHead listHead = new ListHead();
			listHead.setParent(lb);
			ListHeader listHeader = new ListHeader();
			listHeader.appendChild(new Label(headerLabel));
			listHeader.setParent(listHead);
			listHeader.appendChild(buttonsLayout);
		}

		private Hlayout createHlayoutBtn(Button[] btns) {
			Hlayout hl = new Hlayout();
			for (Button btn : btns)
				hl.appendChild(btn);
			hl.setStyle("display: inline-block; float: right;");
			return hl;
		}

		private Hlayout createHlayoutLine(Component[] comps) {

			Hlayout	hl = new Hlayout();
			hl.setValign("middle");
			for (Component comp : comps)
				hl.appendChild(comp);
			hl.setVflex("1");
			hl.setStyle("margin-bottom: 5px;");
			return hl;
		}

		private Listbox getListboxFrom(Object source) {
			Listbox retValue = null;
			if (source == bAdd || source == availableList)
				retValue = availableList;
			else if (source == bRemove || source == selectedList)
				retValue = selectedList;

			return retValue;
		}

		private Listbox getListboxTo(Object source) {
			Listbox retValue = null;
			if (source == bAdd || source == availableList)
				retValue = selectedList;
			else if (source == bRemove || source == selectedList)
				retValue = availableList;
			return retValue;
		}

		private SimpleListModel getModel(Listbox listbox) {

			SimpleListModel retValue = null;

			if (listbox == selectedList)
				retValue = selectedModel;
			else if (listbox == availableList)
				retValue = availableModel;

			return retValue;
		}

		private SimpleListModel getModel(SimpleListModel model) {

			SimpleListModel retValue = null;

			if (model == availableModel)
				retValue = selectedModel;
			else if (model == selectedModel)
				retValue = availableModel;

			return retValue;
		}

		private void migrateValueAcrossLists (Event event) {
			Object source = event.getTarget();
			if (source instanceof ListItem)
				source = ((ListItem)source).getListbox();
			Listbox listFrom = getListboxFrom(source);
			Listbox listTo = getListboxTo(source);
			int endIndex = selectedList.getIndexOfItem(listTo.getSelectedItem());

			//Listto is empty. 
			if (endIndex < 0)
				endIndex=0;

			migrateLists (listFrom, listTo, endIndex);
		}	//	migrateValueAcrossLists

		private void migrateLists (final Listbox listFrom, final Listbox listTo, final int endIndex) {
			int index = 0; 
			final SimpleListModel lmFrom = getModel(listFrom);
			final SimpleListModel lmTo = getModel(lmFrom);
			Set<?> selectedItems = listFrom.getSelectedItems();
			List<ValueNamePair > selObjects = new ArrayList<ValueNamePair >();

			for (Object obj : selectedItems) {
				ListItem listItem = (ListItem) obj;
				index = listFrom.getIndexOfItem(listItem);
				ValueNamePair  selObject = (ValueNamePair )lmFrom.getElementAt(index);
				selObjects.add(selObject);
			}

			doTransfer(index, selObjects, lmFrom, lmTo, listFrom, listTo, endIndex);
		}

		private void doTransfer(int index, List<ValueNamePair > selObjects, SimpleListModel lmFrom, SimpleListModel lmTo, Listbox listFrom , Listbox listTo , int endIndex) {

			index = 0;
			Arrays.sort(selObjects.toArray());	
			for (ValueNamePair  selObject : selObjects) {
				lmFrom.removeElement(selObject);
				lmTo.add(endIndex, selObject);
			}

			if (listTo.getSelectedItem() != null) {
				AuFocus focus = new AuFocus(listTo.getSelectedItem());
				Clients.response(focus);
			}
		}

		private class DragListener implements EventListener<Event> 	{
			public DragListener() {
			}

			public void onEvent(Event event) throws Exception {
				if (event instanceof DropEvent) {
					int endIndex = 0;
					DropEvent me = (DropEvent) event;
					ListItem endItem = (ListItem) me.getTarget();
					ListItem startItem = (ListItem) me.getDragged();

					if (!startItem.isSelected())
						startItem.setSelected(true);

					Listbox selListbox = selectedList;
					SimpleListModel selModel = getModel(selListbox);

					if (!(startItem.getListbox() == endItem.getListbox())) {
						Listbox listFrom = (Listbox) startItem.getListbox();
						Listbox listTo = (Listbox) endItem.getListbox();
						endIndex = selListbox.getIndexOfItem(endItem);
						migrateLists (listFrom, listTo, endIndex);
					} else if (startItem.getListbox() == endItem.getListbox() && startItem.getListbox() == selListbox) {
						List<ValueNamePair > selObjects = new ArrayList<ValueNamePair >();
						endIndex = selListbox.getIndexOfItem(endItem);	
						for (Object obj : selListbox.getSelectedItems()) {
							ListItem listItem = (ListItem) obj;
							int index = selListbox.getIndexOfItem(listItem);
							ValueNamePair  selObject = (ValueNamePair ) selModel.getElementAt(index);				
							selObjects.add(selObject);						
						}
						migrateValueWithinSelectedList (selModel, selListbox, endIndex, selObjects);
					}
				}
			}
		}

		private void migrateValueWithinSelectedList (SimpleListModel selModel, Listbox selListbox, int endIndex, List<ValueNamePair > selObjects) {
			int iniIndex =0;
			Arrays.sort(selObjects.toArray());	
			ValueNamePair  selObject= null;
			ValueNamePair  endObject = (ValueNamePair ) selModel.getElementAt(endIndex);
			for (ValueNamePair  selected : selObjects) {
				iniIndex = selModel.indexOf(selected);
				selObject = (ValueNamePair ) selModel.getElementAt(iniIndex);
				selModel.removeElement(selObject);
				endIndex = selModel.indexOf(endObject);
				selModel.add(endIndex, selObject);			
			}

			selListbox.removeAllItems();
			for(int i=0 ; i<selModel.getSize(); i++) { 	
				ValueNamePair  pp = (ValueNamePair ) selModel.getElementAt(i);
				selListbox.addItem(new ValueNamePair(pp.getID(), pp.getName()));
			}
		}

		private void migrateValueWithinSelectedList (Event event) {
			Object[] selObjects = selectedList.getSelectedItems().toArray();
			if (selObjects == null)
				return;
			int length = selObjects.length;
			if (length == 0)
				return;
			//
			int[] indices = selectedList.getSelectedIndices();
			//
			boolean change = false;
			//
			Object source = event.getTarget();
			if (source == bUp) {
				for (int i = 0; i < length; i++) {
					int index = indices[i];
					if (index == 0)
						break;
					ValueNamePair  selObject = (ValueNamePair ) selectedModel.getElementAt(index);
					ValueNamePair  newObject = (ValueNamePair ) selectedModel.getElementAt(index - 1);
					selectedModel.setElementAt(newObject, index);
					selectedModel.setElementAt(selObject, index - 1);
					indices[i] = index - 1;
					change = true;
				}
			}	//	up

			else if (source == bDown) {
				for (int i = length - 1; i >= 0; i--) {
					int index = indices[i];
					if (index  >= selectedModel.getSize() - 1)
						break;
					ValueNamePair  selObject = (ValueNamePair ) selectedModel.getElementAt(index);
					ValueNamePair  newObject = (ValueNamePair ) selectedModel.getElementAt(index + 1);
					selectedModel.setElementAt(newObject, index);
					selectedModel.setElementAt(selObject, index + 1);
					selectedList.setSelectedIndex(index + 1);
					indices[i] = index + 1;
					change = true;
				}
			}	//	down

			//
			if (change) {
				selectedList.setSelectedIndices(indices);
				if ( selectedList.getSelectedItem() != null) {
					AuFocus focus = new AuFocus(selectedList.getSelectedItem());
					Clients.response(focus);
				}
			}
		}

		private String getNewValue() {
			return m_newValue;
		}
	}
}
