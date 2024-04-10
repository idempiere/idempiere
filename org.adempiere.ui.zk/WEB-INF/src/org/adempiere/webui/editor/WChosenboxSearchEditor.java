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

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.logging.Level;

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
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.factory.InfoManager;
import org.adempiere.webui.panel.IHelpContext;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.addon.chosenbox.Chosenbox;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.DropEvent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.ListSubModel;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.South;

/**
 * Default editor for {@link DisplayType#ChosenMultipleSelectionSearch}.
 * Implemented with {@link ChosenSearchBox} component.
 * @author hengsin
 */
public class WChosenboxSearchEditor extends WEditor implements ContextMenuListener
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK, Events.ON_SELECT};
	private Lookup 				lookup;
	/** Foreign table name */
	private String				m_tableName = null;
	/** Foreign key column name */
	private String				m_keyColumnName = null;
	/** Column name for {@link #lookup} */
	private String 				columnName;
	/** comma separated value list of selected records */
    private String              value;
    private InfoPanel			infoPanel = null;
    /** Image URL or font icon sclass for choosebox button */
	private String 				imageUrl;
	private MyListModel 		model = new MyListModel();
	/** Model for {@link Chosenbox} */
	private InfoListSubModel	subModel = null;

	private static final CLogger log = CLogger.getCLogger(WChosenboxSearchEditor.class);
	private static final int DEFAULT_MAX_AUTO_COMPLETE_ROWS = 500;
	/** true when editor is handling ON_SELECT event */
	private boolean onselecting;

	/**
	 * 
	 * @param gridField
	 */
	public WChosenboxSearchEditor (GridField gridField)
	{
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WChosenboxSearchEditor (GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
	{
		super(new ChosenSearchBox(), gridField, tableEditor, editorConfiguration);

		lookup = gridField.getLookup();

		if (lookup != null)
			columnName = lookup.getColumnName();

		init();
	}


    @Override
	public ChosenSearchBox getComponent() {
		return (ChosenSearchBox) super.getComponent();
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}


	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
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
	public WChosenboxSearchEditor (Lookup lookup, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
	{
		super(new ChosenSearchBox(), label, description, mandatory, readonly, updateable);

		if (lookup == null)
		{
			throw new IllegalArgumentException("Lookup cannot be null");
		}

		this.lookup = lookup;
        columnName = lookup.getColumnName();
		super.setColumnName(columnName);
		init();
	}

	/**
	 * @param columnName
	 * @param mandatory
	 * @param readonly
	 * @param updateable
	 * @param lookup
	 */
	public WChosenboxSearchEditor(String columnName, boolean mandatory, boolean readonly, boolean updateable,
    		Lookup lookup)
	{
		super(new ChosenSearchBox(), null, null, mandatory, readonly, updateable);

		if (lookup == null)
		{
			throw new IllegalArgumentException("Lookup cannot be null");
		}

		this.lookup = lookup;
        this.columnName = columnName;
		super.setColumnName(columnName);
		init();
	}


	/**
     * initialise editor
	 */
	private void init()
	{
		columnName = this.getColumnName();
		if (ThemeManager.isUseFontIconForImage())
			imageUrl = "z-icon-More";
		else
			imageUrl = ThemeManager.getThemeResource("images/PickOpen16.png");
		if (lookup instanceof MLookup) 
		{
			MLookup mlookup = (MLookup) lookup;
			if ("C_BPartner_ID".equals(mlookup.getLookupInfo().KeyColumn)
				|| (mlookup.getLookupInfo().KeyColumn != null && mlookup.getLookupInfo().KeyColumn.endsWith(".C_BPartner_ID")))
			{
				if (ThemeManager.isUseFontIconForImage())
					imageUrl = "z-icon-BPartner";
				else
					imageUrl = ThemeManager.getThemeResource("images/BPartner16.png");
			}
			else if ("M_Product_ID".equals(mlookup.getLookupInfo().KeyColumn)
					|| (mlookup.getLookupInfo().KeyColumn != null && mlookup.getLookupInfo().KeyColumn.endsWith(".M_Product_ID")))
			{
				if (ThemeManager.isUseFontIconForImage())
					imageUrl = "z-icon-Product";
				else
					imageUrl = ThemeManager.getThemeResource("images/Product16.png");
			}
		}
		popupMenu = new WEditorPopupMenu(false, true, isShowPreference(), false, false, false, lookup);
		popupMenu.removeNewUpdateMenu();

		Menuitem editor = new Menuitem();
		editor.setAttribute("EVENT", WEditorPopupMenu.ASSISTANT_EVENT);
		editor.setLabel(Msg.getMsg(Env.getCtx(), "Assistant"));
		if (ThemeManager.isUseFontIconForImage())
			editor.setIconSclass("z-icon-Wizard");
		else
			editor.setImage(ThemeManager.getThemeResource("images/Wizard16.png"));
		editor.addEventListener(Events.ON_CLICK, popupMenu);
		popupMenu.appendChild(editor);

		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass(imageUrl);
		else
			getComponent().getButton().setImage(imageUrl);
		
		setTableAndKeyColumn();
		subModel = new InfoListSubModel(lookup, gridField, m_tableName, m_keyColumnName);
		getComponent().getChosenbox().setModel(model);

		addChangeLogMenu(popupMenu);
		
		return;
	}

	@Override
	public void setValue(Object value)
	{
		if (onselecting) {
    		return;
    	}
		
		if (value != null && value instanceof Integer) {
			value = value.toString();
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
            model.clear();
            model.addAll(selected);
			getComponent().getChosenbox().setSelectedObjects(selected);
            this.value = (String)value;
        }
        else
        {
        	model.clear();
        	getComponent().getChosenbox().setSelectedObjects(new LinkedHashSet<ValueNamePair>());
            this.value = null;            
        }                                
    }

	@Override
	public Object getValue()
	{
		return value;
	}
	
	/**
	 * @return comma separated value list of selected records
	 */
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
	 * @return comma separated name list of selected records
	 */
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
	public void onEvent(Event e)
	{
		if (Events.ON_CLICK.equals(e.getName()))
		{
			if (infoPanel != null)
			{
				infoPanel.detach();
				infoPanel = null;
			}
			actionButton();
		}
		else if (Events.ON_SELECT.equalsIgnoreCase(e.getName()))
    	{
    		try {
    			onselecting = true;
		        String newValue = getValueFromComponent();
		        if (isValueChange(newValue)) {
		        	try {
		        		if (gridField != null) 
		        			gridField.setLookupEditorSettingValue(true);
				        ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), value, newValue);
				        super.fireValueChange(changeEvent);				        
				        value = newValue;
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

	/**
	 * @param newValue
	 * @return true if newValue is different from {@link #value}
	 */
	private boolean isValueChange(Object newValue) {
		return (value == null && newValue != null) || (value != null && newValue == null) 
			|| ((value != null && newValue != null) && !value.equals(newValue));
	}
	
	@Override
	public void onMenu(ContextMenuEvent evt)
	{
		if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
			return;
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		} else if (WEditorPopupMenu.ASSISTANT_EVENT.equals(evt.getContextEvent())) {
			final WChosenboxSearchAssistant wdc = new WChosenboxSearchAssistant();
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

	/**
	 * Handle ON_SELECT event
	 * @param newValue
	 */
	private void updateValue(Object newValue) {
		try {
			onselecting = true;

			if (isValueChange(newValue)) {
				try {
					if (gridField != null) 
						gridField.setLookupEditorSettingValue(true);
					ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), "", newValue);
					super.fireValueChange(changeEvent);				        
					this.value = newValue.toString();
				} finally {
					if (gridField != null) 
						gridField.setLookupEditorSettingValue(false);
				}
			}
		} finally {
			onselecting = false;
		}
	}

	/**
	 * Process selected items from info panel/window
	 * @param value
	 */
	private void processSelectedKeys (Object value)
	{
		if (log.isLoggable(Level.FINE))
			log.fine("Value=" + value);
	
		try 
		{
			if (gridField != null)
				gridField.setLookupEditorSettingValue(true);
		
			String newValue = this.value;
			if (newValue == null) 
			{
				if (value instanceof Object[])
				{
					if (((Object[])value).length > 0)
					{
						StringBuilder builder = new StringBuilder();
						for(Object obj : (Object[])value)
						{
							if (obj != null)
							{
								if (builder.length() > 0)
									builder.append(",");
								builder.append(obj.toString());
							}
						}
						newValue = builder.toString();
					}
				}
				else
				{
					newValue = value != null ? value.toString() : null;
				}
			}
			else if (value != null)
			{
				if (value instanceof Object[])
				{
					if (((Object[])value).length > 0)
					{
						StringBuilder builder = new StringBuilder(newValue);
						for(Object obj : (Object[])value)
						{
							if (obj != null)
							{
								if (newValue.contains(obj.toString()))
									continue;
								if (builder.length() > 0)
									builder.append(",");
								builder.append(obj.toString());
							}
						}
						newValue = builder.toString();
					}
				}
				else
				{
					if (!newValue.contains(value.toString()))
						newValue = newValue + "," + value.toString();
				}
			}
			fireValueChangeEvent(newValue);
	
			//  is the value updated ?
			boolean updated = false;
			if (newValue == null && getValue() == null) {
				updated = true;
			} else if (newValue != null && newValue.equals(getValue())) {
				updated = true;
			}
			if (!updated)
			{
				setValue(newValue);
			}				
		} 
		finally 
		{
			if (gridField != null)
				gridField.setLookupEditorSettingValue(false);
		}
		
	}	//	actionCombo

	/**
	 * Fire ValueChangeEvent for newValue
	 * @param newValue
	 */
	protected void fireValueChangeEvent(Object newValue) {
		ValueChangeEvent evt = new ValueChangeEvent(this, this.getColumnName(), getValue(), newValue);
		// -> ADTabpanel - valuechange
		fireValueChange(evt);
	}

	/**
	 * Open info panel/window
	 */
	private void actionButton()
	{
		if (lookup == null)
			return;		//	leave button disabled

		/**
		 *  Three return options:
		 *  - Value Selected & OK pressed   => store result => result has value
		 *  - Cancel pressed                => store null   => result == null && cancelled
		 *  - Window closed                 -> ignore       => result == null && !cancalled
		 */

		//  Validation
		String whereClause = getWhereClause();

		if (m_tableName == null)	//	sets table name & key column
			setTableAndKeyColumn();

		final InfoPanel ip = InfoManager.create(lookup, gridField, m_tableName, m_keyColumnName, null, true, whereClause);
		if (ip != null)
			showInfoPanel(ip);
	}

	/**
	 * Open {@link InfoPanel}
	 * @param ip InfoPanel
	 */
	protected void showInfoPanel(final InfoPanel ip) {
		ip.setVisible(true);
		ip.setStyle("border: 2px");
		ip.setClosable(true);
		infoPanel = ip;
		ip.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				Component component = SessionManager.getAppDesktop().getActiveWindow();
				if (component instanceof IHelpContext)
					Events.sendEvent(new Event(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, component));
				else
					SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0);
				
				boolean cancelled = ip.isCancelled();
				Object[] result = ip.getSelectedKeys();

				infoPanel = null;
				//  Result
				if (!cancelled && result != null && result.length > 0)
				{
					//ensure data binding happen
					if (result.length > 1)
						processSelectedKeys (result);
					else
						processSelectedKeys (result[0]);
				}
				getComponent().getChosenbox().focus();
			}
		});
		ip.setId(ip.getTitle()+"_"+ip.getWindowNo());
		AEnv.showWindow(ip);
	}

	/**
	 * 	Set {@link #m_tableName} and {@link #m_keyColumnName}
	 */
	private void setTableAndKeyColumn() {
		if (lookup != null && lookup instanceof MLookup) {
			// foreign table defined in lookup
			m_keyColumnName = ((MLookup)lookup).getColumnName();
			if (m_keyColumnName.contains(".")) {
				m_tableName = m_keyColumnName.substring(0, m_keyColumnName.indexOf("."));
				m_keyColumnName = m_keyColumnName.substring(m_keyColumnName.indexOf(".")+1);
			} else {
				m_tableName = m_keyColumnName.substring(0, m_keyColumnName.length()-3);
			}
		} else if (getGridField() != null && getGridField().getGridTab() != null && getGridField().getAD_Column_ID() > 0) {
			// field - this search editor comes from a window, when it comes from process parameter it doesn't have a gridtab
			MColumn column = MColumn.get(Env.getCtx(), getGridField().getAD_Column_ID());
			m_tableName = column.getReferenceTableName();
			MTable table = MTable.get(Env.getCtx(), m_tableName);
			m_keyColumnName = table.getKeyColumns()[0];
		} else {
			// no field - the search editor is defined programmatically
			m_keyColumnName = getColumnName();
			m_tableName = m_keyColumnName.substring(0, m_keyColumnName.length()-3);
		}
		if (m_keyColumnName.equals("M_Product_ID")) {
			//	Reset
			Env.setContext(Env.getCtx(), lookup.getWindowNo(), Env.TAB_INFO, "M_Product_ID", "0");
			Env.setContext(Env.getCtx(), lookup.getWindowNo(), Env.TAB_INFO, "M_AttributeSetInstance_ID", "0");
			Env.setContext(Env.getCtx(), lookup.getWindowNo(), Env.TAB_INFO, "M_Locator_ID", "0");
		}
	}
	
	/**
	 * @return where clause from {@link #lookup} validation code.
	 */
	private String getWhereClause()
	{
		String whereClause = "";

		if (lookup == null)
			return "";

		String validation = lookup.getValidation();

		if (validation == null)
			validation = "";

		if (whereClause.length() == 0)
			whereClause = validation;
		else if (validation.length() > 0)
			whereClause += " AND " + validation;

		if (whereClause.indexOf('@') != -1)
		{
			Properties ctx = lookup instanceof MLookup ? ((MLookup)lookup).getLookupInfo().ctx : Env.getCtx();
			String validated = Env.parseContext(ctx, lookup.getWindowNo(), whereClause, false);

			if (validated.length() == 0)
				log.severe(getColumnName() + " - Cannot Parse=" + whereClause);
			else
			{
				if (log.isLoggable(Level.FINE))
					log.fine(getColumnName() + " - Parsed: " + validated);
				return validated;
			}
		}
		return whereClause;
	}	//	getWhereClause

	@Override
	public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}

	/**
	 * @return {@link Lookup}
	 */
	public Lookup getLookup() {
		return lookup;
	}
	
	
	@Override
	public void dynamicDisplay(Properties ctx) {
		if (lookup instanceof MLookup) {
			((MLookup) lookup).getLookupInfo().ctx = ctx;
		}
		super.dynamicDisplay(ctx);
	}
	
	/**
	 * Assistant dialog to manage selection of items and to change ordering of selected items. 
	 */
	private class WChosenboxSearchAssistant extends Window implements EventListener<Event> {
		private static final long serialVersionUID = 1043859495570181469L;
		private Button bRemoveAll, bUp, bDown;
		private SimpleListModel selectedModel = new SimpleListModel();
		private Listbox selectedList = new Listbox();
		private Hlayout hlayout;
		private Button bOk, bCancel;
		private String m_newValue = "";

		public WChosenboxSearchAssistant() {
			super();
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
				WChosenboxSearchEditor.this.getComponent().getChosenbox().focus();
			});
		}

		private void init() {
			m_newValue = getValue() != null ? getValue().toString() : "";

			Borderlayout mainLayout = new Borderlayout();
			appendChild(mainLayout);

			Center center = new Center();
			mainLayout.appendChild(center);
			center.setAutoscroll(true);



			//Listener for up and down button
			EventListener<Event> actionListenerUpDown = new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					migrateValueWithinSelectedList(event);
				}
			};
			//Listener for up and down button
			EventListener<Event> actionListenerRemoveAll = new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					deleteAllValuesList(event);
				}
			};


			EventListener<Event> mouseListener = new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					if (Events.ON_DOUBLE_CLICK.equals(event.getName())) {
						deleteValueList(event);
					}
				}
			};

			EventListener<Event> crossListMouseListener = new DragListener();

			bUp = createButton("MoveUp16", actionListenerUpDown);
			bDown = createButton("MoveDown16", actionListenerUpDown);

			Hlayout yesButtonLayout = createHlayoutBtn(new Button[] {bUp, bDown});
			boolean isEditable = gridField.isEditable(true);

			initListboxAndModel(selectedList, selectedModel, mouseListener, crossListMouseListener, isEditable, Msg.getMsg(Env.getCtx(), "SelectedItems"), yesButtonLayout);

			hlayout = createHlayoutLine(new Component[] {selectedList});
			center.appendChild(hlayout);

			ConfirmPanel confirmPanel = new ConfirmPanel(true, false, true, false, false, false);
			bOk = confirmPanel.getOKButton();
			bOk.addEventListener(Events.ON_CLICK, this);
			bCancel = confirmPanel.getButton(ConfirmPanel.A_CANCEL);
			bCancel.addEventListener(Events.ON_CLICK, this);
			bRemoveAll = confirmPanel.getButton(ConfirmPanel.A_RESET);
			bRemoveAll.addEventListener(Events.ON_CLICK, actionListenerRemoveAll);

			South south = new South();
			south.setSclass("dialog-footer");
			mainLayout.appendChild(south);
			south.appendChild(confirmPanel);

			if (! isEditable) {
				bUp.setVisible(false);
				bDown.setVisible(false);
				bRemoveAll.setVisible(false);
			}
		}

		private void load() {
			selectedModel.removeAllElements();

			// selected
			Object values = getValue();
			ArrayList<String> listSelected = new ArrayList<String>();
			if (values != null && !Util.isEmpty((String) values)) {
				for (String value : ((String) values).split(",")) {

					String name = lookup.getDisplay(value);
					selectedModel.addElement(new ValueNamePair(value, name));
					listSelected.add(value);
				}	
			}
		}

		@Override
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
			} else if (event.getTarget() == bCancel) {
				this.detach();
			}
		}

		/**
		 * Delete All Values from List
		 * @param event
		 */
		private void deleteAllValuesList(Event event) {
			selectedModel.removeAllElements();
		}

		/**
		 * Remove selected item
		 * @param event
		 */
		private void deleteValueList (Event event) {
			Object source = event.getTarget();
			if (source instanceof ListItem listItem) {
				int index = listItem.getIndex();
				selectedModel.removeElement(selectedModel.getElementAt(index));
			}
		}

		private Button createButton(String image, EventListener<Event> actionListener) {
			Button btn = ButtonFactory.createButton(null, ThemeManager.getThemeResource("images/" + image + ".png"), null);
			LayoutUtils.addSclass("btn-small", btn);
			LayoutUtils.addSclass("btn-sorttab small-img-btn", btn);
			if(actionListener != null)
				btn.addEventListener(Events.ON_CLICK, actionListener);
			return btn;
		}

		/**
		 * @param lb
		 * @param model
		 * @param mouseListener
		 * @param crossListMouseListener
		 * @param isItemDraggable
		 * @param headerLabel
		 * @param buttonsLayout
		 */
		private void initListboxAndModel(Listbox lb, SimpleListModel model, EventListener<Event> mouseListener, EventListener<Event> crossListMouseListener, boolean isItemDraggable, String headerLabel, Hlayout buttonsLayout) {
			lb.addEventListener(Events.ON_RIGHT_CLICK, this);
			ZKUpdateUtil.setHflex(lb, "1");
			ZKUpdateUtil.setVflex(lb, true);

			if (mouseListener != null && isItemDraggable)
				lb.addDoubleClickListener(mouseListener);
			if (crossListMouseListener != null && isItemDraggable)
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

		private SimpleListModel getModel(Listbox listbox) {

			SimpleListModel retValue = null;

			if (listbox == selectedList)
				retValue = selectedModel;

			return retValue;
		}

		/**
		 * Listener for DropEvent 
		 */
		private class DragListener implements EventListener<Event> 	{
			public DragListener() {
			}

			@Override
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

					if (startItem.getListbox() == endItem.getListbox() && startItem.getListbox() == selListbox) {
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

		/**
		 * Move selected items to endIndex
		 * @param selModel
		 * @param selListbox
		 * @param endIndex
		 * @param selObjects
		 */
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

		/**
		 * Handle event from up and down button. <br/>
		 * Move selected items up/down within {@link #selectedList}.
		 * @param event
		 */
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

	/**
	 * {@link ListSubModel} for {@link Chosenbox} auto complete
	 */
	private class MyListModel extends ListModelList<ValueNamePair> implements ListSubModel<ValueNamePair> {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = -1210525428410505409L;

		@Override
		public ListModel<ValueNamePair> getSubModel(Object value, int nRows) {
			subModel.setWhereClause(getWhereClause());
			int maxRows = MSysConfig.getIntValue(MSysConfig.ZK_SEARCH_AUTO_COMPLETE_MAX_ROWS, DEFAULT_MAX_AUTO_COMPLETE_ROWS, Env.getAD_Client_ID(Env.getCtx()));
			ListModel<ValueNamePair> model = subModel.getSubModel(value, maxRows);
			getComponent().getChosenbox().setSubListModel(model);
			return model;
		}
		
	}
}
