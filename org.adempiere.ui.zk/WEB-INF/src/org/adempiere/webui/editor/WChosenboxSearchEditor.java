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
import java.util.LinkedHashSet;
import java.util.Properties;
import java.util.Set;
import java.util.logging.Level;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ChosenSearchBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.factory.InfoManager;
import org.adempiere.webui.panel.IHelpContext;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.Lookup;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.ListSubModel;

/**
 * 
 * @author hengsin
 *
 */
public class WChosenboxSearchEditor extends WEditor implements ContextMenuListener
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK, Events.ON_SELECT};
	private Lookup 				lookup;
	private String				m_tableName = null;
	private String				m_keyColumnName = null;
	private String 				columnName;
    private String              value;
    private InfoPanel			infoPanel = null;
	private String 				imageUrl;
	private MyListModel 		model = new MyListModel();
	private InfoListSubModel	subModel = null;

	private static final CLogger log = CLogger.getCLogger(WChosenboxSearchEditor.class);
	private static final int DEFAULT_MAX_AUTO_COMPLETE_ROWS = 500;
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
     * @param columnName columnName
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
			if ("C_BPartner_ID".equals(mlookup.getLookupInfo().KeyColumn))
			{
				if (ThemeManager.isUseFontIconForImage())
					imageUrl = "z-icon-BPartner";
				else
					imageUrl = ThemeManager.getThemeResource("images/BPartner16.png");
			}
			else if ("M_Product_ID".equals(mlookup.getLookupInfo().KeyColumn))
			{
				if (ThemeManager.isUseFontIconForImage())
					imageUrl = "z-icon-Product";
				else
					imageUrl = ThemeManager.getThemeResource("images/Product16.png");
			}
		}
		popupMenu = new WEditorPopupMenu(false, true, isShowPreference(), false, false, false, lookup);
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

	private boolean isValueChange(Object newValue) {
		return (value == null && newValue != null) || (value != null && newValue == null) 
			|| ((value != null && newValue != null) && !value.equals(newValue));
	}
	
	@Override
	public void propertyChange(PropertyChangeEvent evt)
	{
		if ("FieldValue".equals(evt.getPropertyName()))
		{
			setValue(evt.getNewValue());
		}
	}

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
		}
	}

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


	protected void fireValueChangeEvent(Object newValue) {
		ValueChangeEvent evt = new ValueChangeEvent(this, this.getColumnName(), getValue(), newValue);
		// -> ADTabpanel - valuechange
		fireValueChange(evt);
	}

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

		final InfoPanel ip = InfoManager.create(lookup, gridField, m_tableName, m_keyColumnName, null, false, whereClause);
		if (ip != null)
			showInfoPanel(ip);
	}


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
	 * 	Sets m_tableName and m_keyColumnName
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
			// no field - the search editor is defined programatically
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


	public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}

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
	
	private class MyListModel extends ListModelList<ValueNamePair> implements ListSubModel<ValueNamePair> {

		/**
		 * 
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
