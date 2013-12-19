/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
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
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/

/**
 * 2007, Modified by Posterita Ltd.
 */

package org.adempiere.webui.window;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Window;
import org.compiere.model.MLocator;
import org.compiere.model.MLocatorLookup;
import org.compiere.model.MRole;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;

/**
 * Location Dialog : Based on VLocationDialog
 * 
 * @author  Niraj Sohun
 * @date    Jul 24, 2007
 */

public class WLocatorDialog extends Window implements EventListener<Event> 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1013647722305985723L;

	private Grid mainPanel = GridFactory.newGridLayout();
	
	private Listbox lstLocator = new Listbox();
	private Listbox lstWarehouse = new Listbox();
	
	private Checkbox chkCreateNew = new Checkbox();

	private Textbox txtWarehouse = new Textbox();
	private Textbox txtAisleX = new Textbox();
	private Textbox txtBinY = new Textbox();
	private Textbox txtLevelZ = new Textbox();
	private Textbox txtKey = new Textbox();
	
	private Label lblLocator = new Label();
	private Label lblWarehouse = new Label();
	private Label lblWarehouse2 = new Label();
	private Label lblAisleX = new Label();
	private Label lblBinY = new Label();
	private Label lblLevelZ = new Label();
	private Label lblKey = new Label();
	
	private ConfirmPanel confirmPanel;

	private MLocatorLookup m_mLocator;
	
	private int m_WindowNo;
	private int m_M_Locator_ID;
	@SuppressWarnings("unused")
	private int m_AD_Client_ID;
	@SuppressWarnings("unused")
	private int m_AD_Org_ID;
	private int m_only_Warehouse_ID;
	private int m_M_Warehouse_ID;
	
	private boolean m_mandatory;
	
	@SuppressWarnings("unused")
	private String m_M_WarehouseName;
	private String m_M_WarehouseValue;
	private String m_Separator;

	private boolean m_change;

	private String title;

	private static CLogger log = CLogger.getCLogger(WLocatorDialog.class);
	
	/**
	 *	Constructor
	 *  @param title title
	 *  @param mLocator locator
	 *  @param M_Locator_ID locator id
	 * 	@param mandatory mandatory
	 * 	@param only_Warehouse_ID of not 0 restrict warehouse
	 *  @param windowNo
	 */
	
	public WLocatorDialog (	String title, MLocatorLookup mLocator,
							int M_Locator_ID, boolean mandatory, int only_Warehouse_ID, 
							int windowNo)
	{
		super();
		
		m_WindowNo = windowNo;
		this.title = title;
		initComponents();

		m_mLocator = mLocator;
		m_M_Locator_ID = M_Locator_ID;
		m_mandatory = mandatory;
		m_only_Warehouse_ID = only_Warehouse_ID;
		

		initLocator();
	} // WLocatorDialog
	
	private void initComponents()
	{
		lblLocator.setValue(Msg.translate(Env.getCtx(), "M_Locator_ID"));
		lblWarehouse.setValue(Msg.translate(Env.getCtx(), "M_Warehouse_ID"));
		lblWarehouse2.setValue(Msg.translate(Env.getCtx(), "M_Warehouse_ID"));
		lblAisleX.setValue(Msg.getElement(Env.getCtx(), "X"));
		lblBinY.setValue(Msg.getElement(Env.getCtx(), "Y"));
		lblLevelZ.setValue(Msg.getElement(Env.getCtx(), "Z"));
		lblKey.setValue(Msg.translate(Env.getCtx(), "Value"));
		
		lstLocator.setMold("select");
		lstLocator.setRows(0);
		LayoutUtils.addSclass("z-label", lstLocator);
		
		chkCreateNew.setLabel(Msg.getMsg(Env.getCtx(), "CreateNew"));
		
		lstWarehouse.setMold("select");
		lstWarehouse.setRows(0);		
		LayoutUtils.addSclass("z-label", lstWarehouse);
		
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.addActionListener(this);

		Columns columns = new Columns();
		mainPanel.appendChild(columns);
		
		Column column = new Column();
		columns.appendChild(column);
		column.setWidth("30%");
		
		column = new Column();
		columns.appendChild(column);
		column.setWidth("70%");
		
		Rows rows = mainPanel.newRows();
		
		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblLocator);
		row.appendChild(lstLocator);
		lstLocator.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(new Space());
		row.appendChild(chkCreateNew);

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblWarehouse);
		row.appendChild(lstWarehouse);
		lstWarehouse.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblWarehouse2);
		row.appendChild(txtWarehouse);
		txtWarehouse.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblAisleX);
		row.appendChild(txtAisleX);
		txtAisleX.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblBinY);
		row.appendChild(txtBinY);
		txtBinY.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblLevelZ);
		row.appendChild(txtLevelZ);
		txtLevelZ.setHflex("1");
		
		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblKey);
		row.appendChild(txtKey);
		txtKey.setHflex("1");
		
		Borderlayout borderlayout = new Borderlayout();
		this.appendChild(borderlayout);
		borderlayout.setHflex("1");
		borderlayout.setVflex("1");
		
		Center centerPane = new Center();
		centerPane.setSclass("dialog-content");
		centerPane.setAutoscroll(true);
		borderlayout.appendChild(centerPane);
		centerPane.appendChild(mainPanel);
		mainPanel.setVflex("1");
		mainPanel.setHflex("1");

		South southPane = new South();
		southPane.setSclass("dialog-footer");
		borderlayout.appendChild(southPane);
		southPane.appendChild(confirmPanel);
		
		this.setTitle(title);
		this.setSclass("popup-dialog");
		this.setClosable(true);
		this.setBorder("normal");
		this.setWidth("260px");
		this.setHeight("300px"); // required fixed height for ZK to auto adjust the position based on available space
		this.setShadow(true);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		this.setSizable(true); // Elaine 2009/02/02 - window set to resizable
	}
	
	private void initLocator()
	{
		log.fine("");

		//	Load Warehouse
		
		String sql = "SELECT M_Warehouse_ID, Name FROM M_Warehouse";
		
		if (m_only_Warehouse_ID != 0)
			sql += " WHERE M_Warehouse_ID=" + m_only_Warehouse_ID;
		
		String SQL = MRole.getDefault().addAccessSQL(
			sql, "M_Warehouse", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO)
			+ " ORDER BY 2";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			rs = pstmt.executeQuery();			
			while (rs.next())
			{
				KeyNamePair key = new KeyNamePair(rs.getInt(1), rs.getString(2));
				lstWarehouse.appendItem(key.getName(), key);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, SQL, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		if (log.isLoggable(Level.FINE)) log.fine("Warehouses=" + lstWarehouse.getItemCount());

		//	Load existing Locators
		
		m_mLocator.fillComboBox(m_mandatory, true, true, false, false); // IDEMPIERE 90
		
		if (log.isLoggable(Level.FINE)) log.fine(m_mLocator.toString());
		
		if (m_mLocator.getSize()==0)
		{
			throw new AdempiereUserError(Msg.getMsg(Env.getCtx(), "DRP-001", false));
		}
		else if (m_mLocator.getSize()==1)
		{
			MLocator locator = (MLocator) m_mLocator.getElementAt(0);
			if (locator == null || locator.getM_Locator_ID() <= 0)
			{
				throw new AdempiereUserError(Msg.getMsg(Env.getCtx(), "DRP-001", false));
			}
		}
		
		for (int i = 0; i < m_mLocator.getSize(); i++)
		{
			Object obj = m_mLocator.getElementAt(i);
			
			lstLocator.appendItem(obj.toString(), obj);
		}
		
		//lstLocator.setModel(m_mLocator);
		//lstLocator.setValue(m_M_Locator_ID);
		if (lstLocator.getItemCount() > 0)
			lstLocator.setSelectedIndex(0);
		lstLocator.addEventListener(Events.ON_SELECT, this);
		
		displayLocator();

		chkCreateNew.setChecked(false);
		chkCreateNew.addEventListener(Events.ON_CHECK, this);
		
		enableNew();

		lstWarehouse.addEventListener(Events.ON_SELECT, this);
		
		txtAisleX.addEventListener(Events.ON_CHANGE, this);
		txtBinY.addEventListener(Events.ON_CHANGE, this);
		txtLevelZ.addEventListener(Events.ON_CHANGE, this);
		
		//	Update UI
		
		//pack();
		
	} // initLocator

	private void displayLocator()
	{
		MLocator l = null;
		ListItem listitem = lstLocator.getSelectedItem();
		
		if (listitem != null)
			l = (MLocator) listitem.getValue();
		
		if (l == null)
			return;

		m_M_Locator_ID = l.getM_Locator_ID();
		
		txtWarehouse.setText(l.getWarehouseName());
		txtAisleX.setText(l.getX());
		txtBinY.setText(l.getY());
		txtLevelZ.setText(l.getZ());
		txtKey.setText(l.getValue());
		
		getWarehouseInfo(l.getM_Warehouse_ID());
		
		//	Set Warehouse
		
		int size = lstWarehouse.getItemCount();
		
		for (int i = 0; i < size; i++)
		{
			ListItem listItem = lstWarehouse.getItemAtIndex(i);
			KeyNamePair pp = (KeyNamePair)listItem.getValue();
			
			if (pp.getKey() == l.getM_Warehouse_ID())
			{
				lstWarehouse.setSelectedIndex(i);
				continue;
			}
		}
	} // displayLocator
	
	/**
	 *	Enable/disable New data entry
	 */
	
	private void enableNew()
	{
		boolean sel = chkCreateNew.isChecked();
		//lblWarehouse.setVisible(sel);
		lstWarehouse.setVisible(sel);
		lstWarehouse.getParent().setVisible(sel);
		//lWarehouseInfo.setVisible(!sel);
		txtWarehouse.setVisible(!sel);
		txtWarehouse.getParent().setVisible(!sel);
		
		txtWarehouse.setReadonly(true);
		txtAisleX.setReadonly(!sel);
		txtBinY.setReadonly(!sel);
		txtLevelZ.setReadonly(!sel);
		txtKey.setReadonly(!sel);
		
		mainPanel.invalidate();	
	} // enableNew

	/**
	 *	Get Warehouse Info
	 *  @param M_Warehouse_ID warehouse
	 */
	private void getWarehouseInfo (int M_Warehouse_ID)
	{
		if (M_Warehouse_ID == m_M_Warehouse_ID)
			return;

		//	Defaults
		
		m_M_Warehouse_ID = 0;
		m_M_WarehouseName = "";
		m_M_WarehouseValue = "";
		m_Separator = ".";
		m_AD_Client_ID = 0;
		m_AD_Org_ID = 0;

		String SQL = "SELECT M_Warehouse_ID, Value, Name, Separator, AD_Client_ID, AD_Org_ID "
			+ "FROM M_Warehouse WHERE M_Warehouse_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			pstmt.setInt(1, M_Warehouse_ID);
			rs = pstmt.executeQuery();
		
			if (rs.next())
			{
				m_M_Warehouse_ID = rs.getInt(1);
				m_M_WarehouseValue = rs.getString(2);
				m_M_WarehouseName = rs.getString(3);
				m_Separator = rs.getString(4);
				m_AD_Client_ID = rs.getInt(5);
				m_AD_Org_ID = rs.getInt(6);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, SQL, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
	} // getWarehouseInfo

	/**
	 *	Create Locator-Value
	 */
	
	private void createValue()
	{
		// Get Warehouse Info
		
		ListItem listitem = lstWarehouse.getSelectedItem();
		KeyNamePair pp = (KeyNamePair)listitem.getValue();
		
		if (pp == null)
			return;
		
		getWarehouseInfo(pp.getKey());

		StringBuilder buf = new StringBuilder(m_M_WarehouseValue);
		buf.append(m_Separator).append(txtAisleX.getText());
		buf.append(m_Separator).append(txtBinY.getText());
		buf.append(m_Separator).append(txtLevelZ.getText());
		
		txtKey.setText(buf.toString());
	} // createValue

	/**
	 * 	OK - check for changes (save them) & Exit
	 */
	
	private void actionOK()
	{
		if (chkCreateNew.isChecked())
		{
			//	Get Warehouse Info
			
			ListItem listitem = lstWarehouse.getSelectedItem();
			KeyNamePair pp = (KeyNamePair)listitem.getValue();
			
			if (pp != null)
				getWarehouseInfo(pp.getKey());

			//	Check mandatory values
			
			String mandatoryFields = "";
			
			if (m_M_Warehouse_ID == 0)
				mandatoryFields += lblWarehouse.getValue() + " - ";
			
			if (txtKey.getText().length()==0)
				mandatoryFields += lblKey.getValue() + " - ";
			
			if (txtAisleX.getText().length()==0)
				mandatoryFields += lblAisleX.getValue() + " - ";
			
			if (txtBinY.getText().length()==0)
				mandatoryFields += lblBinY.getValue() + " - ";
			
			if (txtLevelZ.getText().length()==0)
				mandatoryFields += lblLevelZ.getValue() + " - ";
			
			if (mandatoryFields.length() != 0)
			{
				FDialog.error(m_WindowNo, this, "FillMandatory", mandatoryFields.substring(0, mandatoryFields.length()-3));
				return;
			}

			MLocator loc = MLocator.get(Env.getCtx(), m_M_Warehouse_ID, txtKey.getText(),
				txtAisleX.getText(), txtBinY.getText(), txtLevelZ.getText());
			
			m_M_Locator_ID = loc.getM_Locator_ID();
			
			listitem = new ListItem();
			listitem.setValue(loc);
			
			lstLocator.appendItem(loc.get_TableName(), loc);
			lstLocator.setSelectedIndex(lstLocator.getItemCount() - 1);
		} // createNew

		if (log.isLoggable(Level.CONFIG)) log.config("M_Locator_ID=" + m_M_Locator_ID);
	} // actionOK

	/**
	 *	Get Selected value
	 *  @return value as Integer
	 */
	
	public Integer getValue()
	{
		ListItem listitem = lstLocator.getSelectedItem();
		MLocator l = (MLocator) listitem.getValue();
		
		if (l != null && l.getM_Locator_ID() != 0)
			return new Integer (l.getM_Locator_ID());
		
		return null;
	} // getValue

	/**
	 *	Get result
	 *  @return true if changed
	 */
	
	public boolean isChanged()
	{
		if (m_change)
		{
			ListItem listitem = lstLocator.getSelectedItem();
			MLocator l = listitem != null ? (MLocator)listitem.getValue() : null;
			
			if (l != null)
				return l.getM_Locator_ID() == m_M_Locator_ID;
		}
		return m_change;
	} // getChange

	
	public void onEvent(Event event) throws Exception 
	{
		if (event == null)
			return;
		
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL))
		{
			m_change = false;
			this.detach();
		}
		else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK))
		{
			actionOK();
			m_change = true;
			this.detach();
		}
		else if (event.getTarget() == lstLocator)
			displayLocator();
		else if (event.getTarget() == chkCreateNew)
			enableNew();
		//	Entered/Changed data for Value
		else if (chkCreateNew.isChecked() && event.getTarget() == lstWarehouse)
			createValue();
	}
}
