/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

import javax.swing.event.ListDataListener;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.adwindow.ADTabpanel;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.form.WPaymentFormFactory;
import org.adempiere.webui.apps.form.WPaymentFormWindow;
import org.adempiere.webui.component.Paymentbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.grid.IPaymentForm;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MPaymentLookup;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.NamePair;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;

/**
 * 
 * @author Elaine
 *
 */
public class WPaymentEditor extends WEditor implements ListDataListener, ContextMenuListener {

	public final static String ON_SAVE_PAYMENT = "onSavePayment";
	
	public final static String[] LISTENER_EVENTS = {Events.ON_SELECT};
	
	private MPaymentLookup lookup;
	private Object oldValue;
	
	public WPaymentEditor(GridField gridField) {
		super(new Paymentbox(), gridField);
		lookup = (MPaymentLookup) gridField.getLookup();
		init();
	}
	
	private void init()
    {
        getComponent().getCombobox().setAutocomplete(true);
        getComponent().getCombobox().setAutodrop(true);
        getComponent().getCombobox().addEventListener(Events.ON_BLUR, this);
        if (ThemeManager.isUseFontIconForImage())
        	getComponent().getButton().setIconSclass("z-icon-Payment");
        else
        	getComponent().setButtonImage(ThemeManager.getThemeResource("images/Payment16.png"));        
        getComponent().getButton().addActionListener(this);

        if (lookup != null)
        {
            lookup.addListDataListener(this);
            //always need the empty item for zk to work correctly
            lookup.setMandatory(false);
            
            //no need to refresh readonly lookup
            if (isReadWrite())
            	lookup.refresh();
            refreshList();
        }
    	popupMenu = new WEditorPopupMenu(false, true, isShowPreference());
    	addChangeLogMenu(popupMenu);
    	if (gridField != null)
    		getComponent().getCombobox().setPlaceholder(gridField.getPlaceholder());
    }
	
	@Override
	public String getDisplay() {
		String display = null;
        Comboitem selItem = getComponent().getCombobox().getSelectedItem();
        if (selItem != null)
        {
        	display = selItem.getLabel();
        }
        return display;
	}

	@Override
	public Object getValue() {
		Object retVal = null;
        Comboitem selItem = getComponent().getCombobox().getSelectedItem();
        if (selItem != null)
        {
            retVal = selItem.getValue();
            if ((retVal instanceof Integer) && (Integer)retVal == -1)
            	retVal = null;
        }
        return retVal;
	}

	@Override
	public void setValue(Object value) {
		if (value != null && (value instanceof Integer || value instanceof String))
        {
            getComponent().getCombobox().setValue(value);            
            if (!getComponent().getCombobox().isSelected(value))
            {
            	if (isReadWrite() && lookup != null)
            		lookup.refresh();
            	Object curValue = oldValue;
                oldValue = value;
                refreshList();
                
                //still not in list, reset to zero
                if (!getComponent().getCombobox().isSelected(value))
                {
                	if (value instanceof Integer && gridField != null && gridField.getDisplayType() != DisplayType.ID) // for IDs is ok to be out of the list
                	{
                		getComponent().getCombobox().setValue(null);
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
            getComponent().getCombobox().setValue(null);
            oldValue = value;
        }
	}
	
	@Override
	public Paymentbox getComponent() {
		return (Paymentbox) super.getComponent();
	}
	
	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}
	
	@Override
	public void setReadWrite(boolean readWrite) {
		GridTab m_mTab = gridField.getGridTab();
		boolean m_onlyRule = false;
		if (m_mTab != null) {
			String m_DocStatus = (String) m_mTab.getValue("DocStatus");
			// DocStatus
			if (m_DocStatus == null)
				m_DocStatus = "";
			// Is the Trx closed? Reversed / Voided / Cloased
			if (m_DocStatus.equals("RE") || m_DocStatus.equals("VO") || m_DocStatus.equals("CL"))
			{
				getComponent().setEnabled(readWrite, false);
				return;
			}
			
			// Document is not complete - allow to change the Payment Rule only
			if (m_DocStatus.equals("CO") || m_DocStatus.equals("WP"))
				m_onlyRule = false;
			else
				m_onlyRule = true;
			
			boolean m_isSOTrx = "Y".equals(Env.getContext(Env.getCtx(), gridField.getWindowNo(), "IsSOTrx"));
			// PO only Rule
			if (!m_onlyRule // Only order has Warehouse
					&& !m_isSOTrx && m_mTab.getValue("M_Warehouse_ID") != null)
				m_onlyRule = true;
			if (!m_onlyRule && m_mTab.needSave(true, false)) // don't show button until change on payment rule is saved
				m_onlyRule = true;
		}

		getComponent().setEnabled(readWrite, readWrite && !m_onlyRule);
	}
	
	private void refreshList()
    {
    	if (getComponent().getCombobox().getItemCount() > 0)
    		getComponent().getCombobox().removeAllItems();

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
	                    getComponent().getCombobox().appendItem(lookupKNPair.getName(), lookupKNPair.getKey());
	                    if (!found && oldValue != null && oldValue instanceof Integer &&
	                    	lookupKNPair.getKey() == (Integer)oldValue)
	                    {
	                    	found = true;
	                	}
	                }
	                else if (obj instanceof ValueNamePair)
	                {
	                    ValueNamePair lookupKNPair = (ValueNamePair) obj;
	                    getComponent().getCombobox().appendItem(lookupKNPair.getName(), lookupKNPair.getValue());
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
		    				getComponent().getCombobox().appendItem(pair.getName(), key);
		    			} else if (pair instanceof ValueNamePair) {
		    				ValueNamePair valueNamePair = (ValueNamePair) pair;
		                    getComponent().getCombobox().appendItem(valueNamePair.getName(), valueNamePair.getValue());
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
    					getComponent().getCombobox().appendItem(pair.getName(), key);
    				} else if (pair instanceof ValueNamePair) {
    					ValueNamePair valueNamePair = (ValueNamePair) pair;
                    	getComponent().getCombobox().appendItem(valueNamePair.getName(), valueNamePair.getValue());
    				}
	        	}
    		}
    	}
    	getComponent().getCombobox().setValue(oldValue);
    }

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_SELECT.equalsIgnoreCase(event.getName()))
    	{
	        Object newValue = getValue();
	        if (isValueChange(newValue)) {
		        ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
		        super.fireValueChange(changeEvent);
		        oldValue = newValue;
	        }
	        if (newValue != null)
	        	focusNext();
    	}
    	else if (Events.ON_BLUR.equalsIgnoreCase(event.getName()))
    	{
    		Comboitem item = getComponent().getCombobox().getSelectedItem();
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
    	else if (Events.ON_CLICK.equalsIgnoreCase(event.getName()))
    	{
    		int windowNo = lookup == null ? 0 : lookup.getWindowNo();
    		Object newValue = getValue();
    		if (newValue != null && getGridField().getGridTab() != null)
    		{
    			final IPaymentForm pf = WPaymentFormFactory.create(windowNo, getGridField().getGridTab(), (String) newValue);
    			if (pf != null)
    			{
    				final WPaymentFormWindow window = (WPaymentFormWindow) pf.getWindow();
    				
    				window.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "paymentForm");
    				if (window.isInitOK())
    				{
	    				window.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
	    				window.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
	    					@Override
	    					public void onEvent(Event event) throws Exception {
	    						if (pf.needSave())
	    						{
	    							Component comp = getComponent();
	    							while(comp != null)
	    							{
	    								comp = comp.getParent();
	    								if (comp instanceof ADTabpanel)
	    								{
	    									Events.sendEvent(comp, new Event(ON_SAVE_PAYMENT, comp));
	    									return;
	    								}
	    							}							
	    						}	
	    					}
	    				});
	    				pf.showWindow();
	    				AEnv.showWindow(window);
    				}
    			}
    		}
    	}
	}
	
	@Override
	public void contentsChanged(javax.swing.event.ListDataEvent e) {
		refreshList();
	}

	@Override
	public void intervalAdded(javax.swing.event.ListDataEvent e) {}

	@Override
	public void intervalRemoved(javax.swing.event.ListDataEvent e) {}
	
	private boolean isValueChange(Object newValue) {
		return (oldValue == null && newValue != null) || (oldValue != null && newValue == null)
				|| ((oldValue != null && newValue != null) && !oldValue.equals(newValue));
	}

	public String[] getEvents() {
		return LISTENER_EVENTS;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setFieldStyle(java.lang.String)
	 */
	@Override
	protected void setFieldStyle(String style) {
		getComponent().getCombobox().setStyle(style);
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

    public void actionRefresh()
    {    	
		if (lookup != null)
        {
			Object curValue = getValue();
			
			if (isReadWrite())
				lookup.refresh();
			else
				refreshList();
            if (curValue != null)
            {
            	setValue(curValue);
            }
        }
    }

}
