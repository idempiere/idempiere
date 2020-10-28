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
import java.beans.PropertyChangeListener;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.component.Locationbox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WLocationDialog;
import org.compiere.model.GridField;
import org.compiere.model.MLocation;
import org.compiere.model.MLocationLookup;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;

/**
 * @author Sendy Yagambrum
 * @date July 16, 2007
 * 
 * This class is based on VLocation written by Jorg Janke
 **/
public class WLocationEditor extends WEditor implements EventListener<Event>, PropertyChangeListener, ContextMenuListener
{
    private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
    
    private static final CLogger log = CLogger.getCLogger(WLocationEditor.class);
    private MLocationLookup     m_Location;
    private MLocation           m_value;

    /**
     * Constructor without GridField
     * @param columnName    column name
     * @param mandatory     mandatory
     * @param isReadOnly    read only
     * @param isUpdateable  updateable
     * @param mLocation     location model
    **/
    public WLocationEditor(String columnName, boolean mandatory, boolean isReadOnly, boolean isUpdateable,
            MLocationLookup mLocation)
    {
        super(new Locationbox(), "Address","",mandatory,isReadOnly,isUpdateable);
       
        setColumnName(columnName);
        m_Location = mLocation;
        init();
    }

    /**
     * 
     * @param gridField
     */
    public WLocationEditor(GridField gridField) {
    	this(gridField, false, null);
    }
    
    /**
     * 
     * @param gridField
     * @param tableEditor
     * @param editorConfiguration
     */
    public WLocationEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new Locationbox(), gridField, tableEditor, editorConfiguration);
		m_Location = (MLocationLookup)gridField.getLookup();
        init();
	}

    private void init()
    {
    	if (ThemeManager.isUseFontIconForImage())
    		getComponent().getButton().setIconSclass("z-icon-Location");
    	else
    		getComponent().setButtonImage(ThemeManager.getThemeResource("images/Location16.png"));
    	
    	popupMenu = new WEditorPopupMenu(false, false, isShowPreference());
    	popupMenu.addMenuListener(this);
    	addChangeLogMenu(popupMenu);
		if (gridField != null)
    		getComponent().getTextbox().setPlaceholder(gridField.getPlaceholder());
    }
    
	@Override
    public String getDisplay()
    {
        return getComponent().getText();
    }

    @Override
    public Object getValue()
    {
        if (m_value == null)
            return null;
        return Integer.valueOf(m_value.getC_Location_ID());
    }

    @Override
    public void setValue(Object value)
    {
        if (value == null)
        {
            m_value = null;
            getComponent().setText(null);
        }
        else
        {
        	String trxName = null; // could be null if called from a form
        	if (this.gridField != null)
        		trxName = this.gridField.getGridTab().getTableModel().get_TrxName();

            m_value = m_Location.getLocation(value, trxName);
            if (m_value == null)
                getComponent().setText("<" + value + ">");
            else
                getComponent().setText(m_value.toString());
        }
    }
    
    @Override
	public Locationbox getComponent() {
		return (Locationbox) component;
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
     *  Return Editor value
     *  @return value
     */
    public int getC_Location_ID()
    {
        if (m_value == null)
            return 0;
        return m_value.getC_Location_ID();
    }   
    
    /**
     *  Property Change Listener
     *  @param evt PropertyChangeEvent
     */
    public void propertyChange (PropertyChangeEvent evt)
    {
        if (evt.getPropertyName().equals(org.compiere.model.GridField.PROPERTY))
            setValue(evt.getNewValue());
    }
    
    public void onEvent(Event event) throws Exception
    {    
        //
        if ("onClick".equals(event.getName()))
        {
            if (log.isLoggable(Level.CONFIG)) log.config( "actionPerformed - " + m_value);
            final WLocationDialog ld = new WLocationDialog(Msg.getMsg(Env.getCtx(), "Location"), m_value, gridField);
            final int oldValue = m_value == null ? 0 : m_value.getC_Location_ID();
            ld.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

				@Override
				public void onEvent(Event event) throws Exception {
					getComponent().getTextbox().focus();
					m_value = ld.getValue();
		            //
					if (!ld.isChanged())
		                return;
		    
		            //  Data Binding
		            int C_Location_ID = 0;
		            if (m_value != null)
		                C_Location_ID = m_value.getC_Location_ID();
		            Integer ii = Integer.valueOf(C_Location_ID);

		            if (C_Location_ID != 0 && oldValue == 0)
		            {
		                ValueChangeEvent vc = new ValueChangeEvent(WLocationEditor.this,getColumnName(),null,ii);
		                fireValueChange(vc);
		            }
		            setValue(ii);					
				}
			});
            ld.addEventListener(Events.ON_OPEN, new EventListener<OpenEvent>() {
				@Override
				public void onEvent(OpenEvent event) throws Exception {
					if (!event.isOpen() && !ld.isOnSaveError()) {
						ld.detach();
					}
				}
			});
            ld.setTitle(null);
            LayoutUtils.openPopupWindow(getComponent(), ld);
            if (ClientInfo.isMobile())
    		{
            	ld.setAttribute("mobile.orientation", ClientInfo.get().orientation);
    			ClientInfo.onClientInfo(ld, () -> {
    				if (ld.getPage() != null) {
    					String orientation = (String) ld.getAttribute("mobile.orientation");
    					String newOrientation = ClientInfo.get().orientation;
    					if (!newOrientation.equals(orientation)) {
    						ld.setAttribute("mobile.orientation", newOrientation);
    						
    						ZKUpdateUtil.setCSSHeight(ld);
    						ZKUpdateUtil.setCSSWidth(ld);    						
    						ld.invalidate();
    						LayoutUtils.openPopupWindow(getComponent(), ld, 100);
    						
    					}	    				
    				}
    			});
    		}
        }
    }
    
    /**
     * return listener events to be associated with editor component
     */
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

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}
    
    
}
