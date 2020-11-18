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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.adempiere.webui.window.WLocatorDialog;
import org.compiere.model.GridField;
import org.compiere.model.MLocator;
import org.compiere.model.MLocatorLookup;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MWarehouse;
import static org.compiere.model.SystemIDs.*;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 * Locator Editor : Based on VLocator
 * 
 * @author  Niraj Sohun
 * @date    Jul 23, 2007
 */

public class WLocatorEditor extends WEditor implements EventListener<Event>, PropertyChangeListener, ContextMenuListener, IZoomableEditor
{
	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
    
	private MLocatorLookup m_mLocator;
	private Object m_value;
	private int m_WindowNo;
	
	private static final CLogger log = CLogger.getCLogger(WLocatorEditor.class);
	/**
	 *  IDE Constructor
	 */
	
	public WLocatorEditor()
	{
		this("M_Locator_ID", false, false, true, null, 0);
	}
	
	/**
	 *	Constructor
	 *
	 * 	@param columnName ColumnName
	 *	@param mandatory mandatory
	 *	@param isReadOnly read only
	 *	@param isUpdateable updateable
	 *	@param mLocator locator (lookup) model
	 * 	@param WindowNo window no
	 */
	
	public WLocatorEditor(	String columnName, boolean mandatory, boolean isReadOnly, 
							boolean isUpdateable, MLocatorLookup mLocator, int windowNo)
	{
		super(new EditorBox(), "Locator", "", mandatory, isReadOnly, isUpdateable);
		
		setColumnName(columnName);
		m_mLocator = mLocator;
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-Locator");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/Locator16.png"));
		getComponent().getTextbox().setReadonly(true);

		m_WindowNo = windowNo;	//Yvonne: move it b4 setDefault_Locator_ID()
		setDefault_Locator_ID(); // set default locator, teo_sarca [ 1661546 ]
	}
	
	/**
	 * 
	 * @param gridField
	 */
	public WLocatorEditor(GridField gridField) {
		this(gridField, false, null);
	}
	
	/**
	 * 
	 * @param gridField
	 * @param tableEditor
	 * @param editorConfiguration
	 */
	public WLocatorEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new EditorBox(), gridField, tableEditor, editorConfiguration);
		m_mLocator = (MLocatorLookup)gridField.getLookup();
		
		if (ThemeManager.isUseFontIconForImage())
			getComponent().getButton().setIconSclass("z-icon-Locator");
		else
			getComponent().setButtonImage(ThemeManager.getThemeResource("images/Locator16.png"));
		getComponent().getTextbox().setReadonly(true);
		
		setDefault_Locator_ID(); // set default locator, teo_sarca [ 1661546 ]
		
		m_WindowNo = gridField.getWindowNo();
		
		if (gridField != null) 
        {
        	popupMenu = new WEditorPopupMenu(true, true, isShowPreference());
        	addChangeLogMenu(popupMenu);
        	getComponent().getTextbox().setPlaceholder(gridField.getPlaceholder());
        }					
	}

	public void setValue(Object value)
	{
		setValue (value, false);
	}

	/**
	 * 	Set Value
	 *	@param value value
	 *	@param fire data binding
	 */
	
	private void setValue (Object value, boolean fire)
	{
		if(m_mLocator==null)
		{
			return;
		}
			
		if (value != null)
		{
			m_mLocator.setOnly_Warehouse_ID (getOnly_Warehouse_ID ());
			m_mLocator.setOnly_Product_ID(getOnly_Product_ID());
			
			if (!m_mLocator.isValid(value))
				value = null;
		}

		m_value = value;
		getComponent().setText(m_mLocator.getDisplay(value));	//	loads value
		
		//	Data Binding
		if (fire) {
			ValueChangeEvent val = new ValueChangeEvent(this, getColumnName(), null, value); 
			fireValueChange(val);
		}

	}	
	
	/**
	 *	Return Editor value
	 *  @return value
	 */
	
	public Object getValue()
	{
		if (getM_Locator_ID() == 0)
			return null;
		
		return m_value;
	} // getValue
	
	@Override
	public EditorBox getComponent() {
		return (EditorBox) component;
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();		
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
		getComponent().getTextbox().setReadonly(true);
	}

	/**
	 * 	Get M_Locator_ID
	 *	@return id
	 */
	
	public int getM_Locator_ID()
	{
		if (m_value != null 
				&& m_value instanceof Integer)
				return ((Integer)m_value).intValue();
		
		return 0;
	} // getM_Locator_ID

	/**
	 *  Return Display Value
	 *  @return display value
	 */
	
	public String getDisplay()
	{
		return getComponent().getText();
	} // getDisplay

	public void onEvent(Event event) throws Exception
	{
		if (Events.ON_CLICK.equalsIgnoreCase(event.getName()))
		{
			//	Warehouse/Product		
			int only_Warehouse_ID = getOnly_Warehouse_ID();
			int only_Product_ID = getOnly_Product_ID();
			
			if (log.isLoggable(Level.CONFIG)) log.config("Only Warehouse_ID=" + only_Warehouse_ID	+ ", Product_ID=" + only_Product_ID);
	
			//	Text Entry ok
			
			if (event.getTarget() == getComponent() && actionText(only_Warehouse_ID, only_Product_ID))
				return;
	
			//	 Button - Start Dialog
			
			int M_Locator_ID = 0;
			
			if (m_value instanceof Integer)
				M_Locator_ID = ((Integer)m_value).intValue();
	
			m_mLocator.setOnly_Warehouse_ID(only_Warehouse_ID);
			m_mLocator.setOnly_Product_ID(getOnly_Product_ID());
			
			final WLocatorDialog ld = new WLocatorDialog(Msg.translate(Env.getCtx(), getColumnName()),
				m_mLocator, M_Locator_ID, isMandatory(), only_Warehouse_ID, this.m_WindowNo);
			
			ld.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					m_mLocator.setOnly_Warehouse_ID(0);
					// redisplay
					
					if (!ld.isChanged())
						return;
					setValue (ld.getValue(), true);
				}
			});
			//	display
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
	
	public void actionRefresh()
    {    	
		if (m_mLocator != null)
        {
			Object curValue = getValue();
			
			if (isReadWrite())
				m_mLocator.refresh();
            if (curValue != null)
            {
            	setValue(curValue);
            }
        }
    }
	
	public void actionZoom()
	{
		int AD_Window_ID = MTable.get(Env.getCtx(), MLocator.Table_ID).getAD_Window_ID();
		if (AD_Window_ID <= 0)
			AD_Window_ID = WINDOW_WAREHOUSE_LOCATOR;	//	hardcoded window Warehouse & Locators
		log.info("");
		//
		
		MQuery zoomQuery = new MQuery();
		zoomQuery.addRestriction(MLocator.COLUMNNAME_M_Locator_ID, MQuery.EQUAL, getValue());
		zoomQuery.setRecordCount(1);	//	guess
		
    	AEnv.zoom(AD_Window_ID, zoomQuery);
	}
	
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
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		} 
		else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
		}
	}
	
	/**
	 * 	Hit Enter in Text Field
	 * 	@param only_Warehouse_ID if not 0 restrict warehouse
	 * 	@param only_Product_ID of not 0 restricted product
	 * 	@return true if found
	 */
	
	private boolean actionText(int only_Warehouse_ID, int only_Product_ID)
	{
		String text = getComponent().getText();
		log.fine(text);
		
		//	Null
		
		if (text == null || text.length() == 0)
		{
			if (isMandatory())
				return false;
			else
			{
				setValue (null, true);
				return true;
			}
		}
		
		if (text.endsWith("%"))
			text = text.toUpperCase();
		else
			text = text.toUpperCase() + "%";
		
		//	Look up - see MLocatorLookup.run
		
		StringBuffer sql = new StringBuffer("SELECT M_Locator_ID FROM M_Locator ")
			.append(" WHERE IsActive='Y' AND UPPER(Value) LIKE ")
			.append(DB.TO_STRING(text));
		
		if (getOnly_Warehouse_ID() != 0)
			sql.append(" AND M_Warehouse_ID=?");
		
		if (getOnly_Product_ID() != 0)
			sql.append(" AND (IsDefault='Y' ")						//	Default Locator
				.append("OR EXISTS (SELECT * FROM M_Product p ")	//	Product Locator
				.append("WHERE p.M_Locator_ID=M_Locator.M_Locator_ID AND p.M_Product_ID=?)")
				.append("OR EXISTS (SELECT * FROM M_StorageOnHand s ")	//	Storage Locator
				.append("WHERE s.M_Locator_ID=M_Locator.M_Locator_ID AND s.M_Product_ID=?))");
		
		String finalSql = MRole.getDefault(Env.getCtx(), false).addAccessSQL(
			sql.toString(), "M_Locator", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);

		int M_Locator_ID = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(finalSql, null);
			int index = 1;
		
			if (only_Warehouse_ID != 0)
				pstmt.setInt(index++, only_Warehouse_ID);
			
			if (only_Product_ID != 0)
			{
				pstmt.setInt(index++, only_Product_ID);
				pstmt.setInt(index++, only_Product_ID);
			}
			
			rs = pstmt.executeQuery();
			
			if (rs.next())
			{
				M_Locator_ID = rs.getInt(1);
			
				if (rs.next())
					M_Locator_ID = 0;	//	more than one
			}
		}
		catch (SQLException ex)
		{
			log.log(Level.SEVERE, finalSql, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		if (M_Locator_ID > 0)
		{
			m_mLocator.refreshIfNeeded();
			boolean valid = m_mLocator.containsKey(M_Locator_ID);
			if (!valid)
				M_Locator_ID = 0;
		}
		
		if (M_Locator_ID == 0)
			return false;

		setValue (Integer.valueOf(M_Locator_ID), true);
		return true;
	} // actionText
	
	/**
	 *  Set Field/WindowNo for ValuePreference (NOP)
	 *  @param mField Model Field
	 */
	
	public void setField (org.compiere.model.GridField mField)
	{
	} // setField
	
	/**
	 * 	Get Warehouse restriction if any.
	 *	@return	M_Warehouse_ID or 0
	 */
	
	private int getOnly_Warehouse_ID()
	{
		String only_Warehouse = null;
		if (gridField != null && gridField.getVO().TabNo > 0)
			only_Warehouse = Env.getContext(Env.getCtx(), m_WindowNo, gridField.getVO().TabNo, "M_Warehouse_ID", false, true);
		else
			only_Warehouse = Env.getContext(Env.getCtx(), m_WindowNo, "M_Warehouse_ID", true);
		int only_Warehouse_ID = 0;
	
		try
		{
			if (only_Warehouse != null && only_Warehouse.length () > 0)
				only_Warehouse_ID = Integer.parseInt (only_Warehouse);
		}
		catch (Exception ex)
		{
		}
		
		return only_Warehouse_ID;
	} // getOnly_Warehouse_ID
	
	/**
	 * 	Get Product restriction if any.
	 *	@return	M_Product_ID or 0
	 */
	
	private int getOnly_Product_ID()
	{
		if (!Env.isSOTrx(Env.getCtx(), m_WindowNo))
			return 0; // No product restrictions for PO

		String only_Product = null;
		if (gridField != null && gridField.getVO().TabNo > 0)
			only_Product = Env.getContext(Env.getCtx(), m_WindowNo, gridField.getVO().TabNo, "M_Product_ID", false, true);
		else
			only_Product = Env.getContext(Env.getCtx(), m_WindowNo, "M_Product_ID", true);
		int only_Product_ID = 0;
		
		try
		{
			if (only_Product != null && only_Product.length () > 0)
				only_Product_ID = Integer.parseInt (only_Product);
		}
		catch (Exception ex)
		{
		}
		return only_Product_ID;
	} // getOnly_Product_ID
	
	/**
	 * Set the default locator if this field is mandatory 
	 * and we have a warehouse restriction.
	 * 
	 * @since 3.1.4
	 */
	
	private void setDefault_Locator_ID()
	{
		// teo_sarca, FR [ 1661546 ] Mandatory locator fields should use defaults
		
		if (!isMandatory() || m_mLocator == null) 
		{
			return;
		}
		
		int M_Warehouse_ID = getOnly_Warehouse_ID();
		
		if (M_Warehouse_ID <= 0) 
		{
			return;
		}
		
		MWarehouse wh = MWarehouse.get(Env.getCtx(), M_Warehouse_ID);
		
		if (wh == null || wh.get_ID() <= 0) 
		{
			return;
		}
		
		MLocator loc = wh.getDefaultLocator();
		
		if (loc == null || loc.get_ID() <= 0) 
		{
			return;
		}
		
		setValue(Integer.valueOf(loc.get_ID()));
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

    /**
     * return listener events to be associated with editor component
     */
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}
    
	@Override
	public void dynamicDisplay(Properties ctx) {
		super.dynamicDisplay(ctx);
		m_mLocator.dynamicDisplay(ctx);
	}
}
