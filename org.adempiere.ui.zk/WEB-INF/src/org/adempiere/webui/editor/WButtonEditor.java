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

import static org.compiere.model.SystemIDs.REFERENCE_DOCUMENTACTION;
import static org.compiere.model.SystemIDs.REFERENCE_PAYMENTRULE;
import static org.compiere.model.SystemIDs.REFERENCE_POSTED;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;

import org.adempiere.webui.adwindow.IADTabpanel;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.model.GridField;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;

/**
 * This class is based on org.compiere.grid.ed.VButton written by Jorg Janke.
 * @author Jorg Janke
 * 
 * Modifications - UI Compatibility
 * @author ashley
 */
public class WButtonEditor extends WEditor implements IProcessButton
{
    public static final String EDITOR_ATTRIBUTE = "editor";

	private static final String[] LISTENER_EVENTS = {Events.ON_CLICK};
    
    private static final CLogger logger;
    
    static
    {
        logger = CLogger.getCLogger(WButtonEditor.class);
    }
    
    private String          m_text;
    private boolean         m_mandatory;
    private Object          m_value;
    /** List of Key/Name        */
    private HashMap<String,String>  m_values = null;
   
    /** Description as ToolTip  */
  
    private MLookup         m_lookup;
  
    private int AD_Process_ID;
    private GridField gridfield = null;
    
    private ArrayList<ActionListener> actionListeners = new ArrayList<ActionListener>();

	private IADTabpanel adTabpanel;
    
	/**
	 * 
	 * @param gridField
	 */
    public WButtonEditor(GridField gridField)
    {
        this(gridField, -1);
    }

    /**
     * 
     * @param gridField
     * @param rowIndex
     */
    public WButtonEditor(GridField gridField, int rowIndex) {
    	this(gridField, rowIndex, false, null);
    }
    
    /**
     * 
     * @param gridField
     * @param tableEditor
     * @param editorConfiguration
     */
    public WButtonEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
    	this(gridField, -1, tableEditor, editorConfiguration);
    }
    
    /**
     * 
     * @param gridField
     * @param rowIndex
     * @param tableEditor
     * @param editorConfiguration
     */
    public WButtonEditor(GridField gridField, int rowIndex, boolean tableEditor, IEditorConfiguration editorConfiguration) {
        super(new Button(), gridField, rowIndex, tableEditor, editorConfiguration);
        m_text = gridField.getHeader();
        AD_Process_ID = gridField.getAD_Process_ID();
        gridfield = gridField;
        getComponent().setAttribute(EDITOR_ATTRIBUTE, this);
        init();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getProcess_ID()
	 */
	@Override
	public int getProcess_ID()
	{
		return AD_Process_ID;
	}	//	getProcess_ID
	
	public GridField getGridField()
	{
		return gridfield;
	}

    private void init()
    {
        label.setValue(" ");
        getComponent().setLabel(gridField.getHeader());
        getComponent().setTooltiptext(gridField.getDescription());
        
        String columnName = super.getColumnName();
        if (columnName.equals("PaymentRule"))
        {
            readReference(REFERENCE_PAYMENTRULE);
            if (ThemeManager.isUseFontIconForImage())
            	getComponent().setIconSclass("z-icon-Payment");
            else
            	getComponent().setImage(ThemeManager.getThemeResource("images/Payment16.png"));    //  29*14
        }
        else if (columnName.equals("DocAction"))
        {
            readReference(REFERENCE_DOCUMENTACTION);
            if (ThemeManager.isUseFontIconForImage())
            	getComponent().setIconSclass("z-icon-Process");
            else
            	getComponent().setImage(ThemeManager.getThemeResource("images/Process16.png"));    //  16*16
        }
        else if (columnName.equals("CreateFrom"))
        {
        	if (ThemeManager.isUseFontIconForImage())
        		getComponent().setIconSclass("z-icon-CreateFrom");
        	else
        		getComponent().setImage(ThemeManager.getThemeResource("images/Copy16.png"));       //  16*16
        }
        else if (columnName.equals("Record_ID"))
        {
        	if (ThemeManager.isUseFontIconForImage())
        		getComponent().setIconSclass("z-icon-Zoom");
        	else
        		getComponent().setImage(ThemeManager.getThemeResource("images/Zoom16.png"));       //  16*16
            getComponent().setLabel(Msg.getMsg(Env.getCtx(), "ZoomDocument"));
        }
        else if (columnName.equals("Posted"))
        {
            readReference(REFERENCE_POSTED);
            if (ThemeManager.isUseFontIconForImage())
            	getComponent().setIconSclass("z-icon-InfoAccount");
            else
            	getComponent().setImage(ThemeManager.getThemeResource("images/InfoAccount16.png"));    //  16*16
        }
        
        if (gridField.getColumnName().endsWith("_ID") && !gridField.getColumnName().equals("Record_ID"))
        {
            m_lookup = MLookupFactory.get(Env.getCtx(), gridField.getWindowNo(), 0,
                    gridField.getAD_Column_ID(), DisplayType.Search);
        }
        else if (gridField.getAD_Reference_Value_ID() != 0)
        {
            //  Assuming List
            m_lookup = MLookupFactory.get(Env.getCtx(), gridField.getWindowNo(), 0,
                    gridField.getAD_Column_ID(), DisplayType.List);
        }
    }

    @Override
    public String getDisplay()
    {
    	if (m_value != null)
    		return m_value.toString();
    	return null;
    }

    @Override
    public Object getValue()
    {
        return m_values;
    }

    @Override
    public boolean isMandatory()
    {
        return m_mandatory;
    }
   
    
    @Override
    public void setMandatory(boolean mandatory)
    {
        m_mandatory = mandatory;
    }

    @Override
    public void setValue(Object value)
    {
        m_value = value;
        String text = m_text;

        //  Nothing to show or Record_ID
        if (value == null || super.getColumnName().equals("Record_ID"))
        {
            ;
        }
        else if (super.getColumnName().equals("DocAction")
        		&& !MSysConfig.getBooleanValue(MSysConfig.DOCACTIONBUTTON_SHOWACTIONNAME, false, Env.getAD_Client_ID(Env.getCtx())))
        {
            text = Msg.getElement(Env.getCtx(), "DocAction");
        }
        else if (m_values != null)
        {
            text = (String)m_values.get(value);
        }
        else if (m_lookup != null)
        {
            NamePair pp = m_lookup.get(value);
            if (pp != null)
                text = pp.getName();
        }
        getComponent().setLabel(text != null ? text : "");
    }
    
    @Override
	public Button getComponent() {
		return (Button) component;
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	public HashMap<String, String> getValues()
    {
    	return m_values;
    }	//	getValues
    
    /**
     *  Fill m_Values with Ref_List values
     *  @param AD_Reference_ID reference
     */
    private void readReference(int AD_Reference_ID)
    {
        m_values = new HashMap<String,String>();
        
        String SQL;
        if (Env.isBaseLanguage(Env.getCtx(), "AD_Ref_List"))
            SQL = "SELECT Value, Name FROM AD_Ref_List WHERE AD_Reference_ID=?";
        else
            SQL = "SELECT l.Value, t.Name FROM AD_Ref_List l, AD_Ref_List_Trl t "
                + "WHERE l.AD_Ref_List_ID=t.AD_Ref_List_ID"
                + " AND t.AD_Language='" + Env.getAD_Language(Env.getCtx()) + "'"
                + " AND l.AD_Reference_ID=?";

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try
        {
            pstmt = DB.prepareStatement(SQL, null);
            pstmt.setInt(1, AD_Reference_ID);
            rs = pstmt.executeQuery();
           
            while (rs.next())
            {
                String value = rs.getString(1);
                String name = rs.getString(2);
                m_values.put(value,name);
            }
           
            
        }
        catch (SQLException e)
        {
            logger.log(Level.SEVERE, SQL, e);
        }
        finally
        {
        	DB.close(rs, pstmt);
        }
       
    }   //  readReference
    
    public void addActionListener(ActionListener actionListener)
    {
    	if (!actionListeners.contains(actionListener))
    		actionListeners.add(actionListener);
    }

    public boolean removeActionListener(ActionListener actionListener)
    {
    	return actionListeners.remove(actionListener);
    }
    
    @Override
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

	public void onEvent(Event event) throws Exception 
	{
		if (Events.ON_CLICK.equals(event.getName()))
		{
			ActionEvent actionEvent = new ActionEvent(this, getColumnName(), Events.ON_CLICK);
			ActionListener[] listeners = new ActionListener[0];
			listeners = actionListeners.toArray(listeners);
			for (ActionListener evtListener : listeners)
			{
				evtListener.actionPerformed(actionEvent);
			}
		}
	}
	
	public void setADTabpanel(IADTabpanel adTabpanel) {
		this.adTabpanel = adTabpanel;
	}
	
	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.IProcessButton#getADTabpanel()
	 */
	@Override
	public IADTabpanel getADTabpanel() {
		return adTabpanel;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#isSearchable()
	 */
	@Override
	public boolean isSearchable() {
		return false;
	}
}
