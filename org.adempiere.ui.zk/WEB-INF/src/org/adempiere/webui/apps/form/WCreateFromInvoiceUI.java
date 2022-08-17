/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * Copyright (C) 2009 Idalica Corporation                                     *
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
package org.adempiere.webui.apps.form;

import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.grid.CreateFromInvoice;
import org.compiere.model.GridTab;
import org.compiere.model.MDocType;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;

import static org.compiere.model.SystemIDs.*;

import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Space;

/**
 * 
 * @author hengsin
 *
 */
public class WCreateFromInvoiceUI extends CreateFromInvoice implements EventListener<Event>, ValueChangeListener
{
	private WCreateFromWindow window;
	
	/**
	 * 
	 * @param tab
	 */
	public WCreateFromInvoiceUI(GridTab tab) 
	{
		super(tab);
		log.info(getGridTab().toString());
		
		window = new WCreateFromWindow(this, getGridTab().getWindowNo());
		
		p_WindowNo = getGridTab().getWindowNo();

		try
		{
			if (!dynInit())
				return;
			zkInit();
			setInitOK(true);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
			setInitOK(false);
		}
		AEnv.showWindow(window);
	}
	
	/** Window No               */
	private int p_WindowNo;

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WCreateFromInvoiceUI.class);
		
	protected Label bPartnerLabel = new Label();
	protected WEditor bPartnerField;
	
	protected Label orderLabel = new Label();
	protected Listbox orderField = ListboxFactory.newDropdownListbox();
	
	protected Label shipmentLabel = new Label();
	protected Listbox shipmentField = ListboxFactory.newDropdownListbox();
    
    /** Label for the rma selection */
    protected Label rmaLabel = new Label();
    /** Combo box for selecting RMA document */
    protected Listbox rmaField = ListboxFactory.newDropdownListbox();

	private Grid parameterStdLayout;
	
	private boolean isCreditMemo = false;
	
	@Override
	public boolean dynInit() throws Exception
	{
		if (log.isLoggable(Level.CONFIG)) log.config("");
		
		super.dynInit();
		
		window.setTitle(getTitle());

		// RMA Selection option should only be available for AP Credit Memo
		Integer docTypeId = (Integer)getGridTab().getValue("C_DocTypeTarget_ID");
		MDocType docType = MDocType.get(Env.getCtx(), docTypeId);
		if (!MDocType.DOCBASETYPE_APCreditMemo.equals(docType.getDocBaseType()))
		{
			rmaLabel.setVisible(false);
		    rmaField.setVisible(false);
		}
		
		isCreditMemo = MDocType.DOCBASETYPE_APCreditMemo.equals(docType.getDocBaseType()) 
				|| MDocType.DOCBASETYPE_ARCreditMemo.equals(docType.getDocBaseType());		
		
		initBPartner(true);
		bPartnerField.addValueChangeListener(this);
		
		return true;
	}   //  dynInit
	
	protected void zkInit() throws Exception
	{
		bPartnerLabel.setText(Msg.getElement(Env.getCtx(), "C_BPartner_ID"));
		orderLabel.setText(Msg.getElement(Env.getCtx(), "C_Order_ID", isSOTrx));
		shipmentLabel.setText(Msg.getElement(Env.getCtx(), "M_InOut_ID", isSOTrx));
        rmaLabel.setText(Msg.translate(Env.getCtx(), "M_RMA_ID"));
        
    	Panel parameterPanel = window.getParameterPanel();
		
		parameterStdLayout = GridFactory.newGridLayout();
    	Panel parameterStdPanel = new Panel();
		parameterStdPanel.appendChild(parameterStdLayout);
		
		setupColumns(parameterStdLayout);

		parameterPanel.appendChild(parameterStdPanel);
		ZKUpdateUtil.setVflex(parameterStdLayout, "min");
		
		Rows rows = (Rows) parameterStdLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(bPartnerLabel.rightAlign());
		if (bPartnerField != null)
			row.appendChild(bPartnerField.getComponent());
		row.appendChild(orderLabel.rightAlign());
		ZKUpdateUtil.setHflex(orderField, "1");
		row.appendChild(orderField);
		
		row = rows.newRow();
		row.appendChild(new Space());
		row.appendChild(new Space());
		row.appendChild(shipmentLabel.rightAlign());
		ZKUpdateUtil.setHflex(shipmentField, "1");
		row.appendChild(shipmentField);				
        
        // Add RMA document selection to panel
		row = rows.newRow();
		row.appendChild(new Space());
		row.appendChild(new Space());
        row.appendChild(rmaLabel.rightAlign());
        ZKUpdateUtil.setHflex(rmaField, "1");
        row.appendChild(rmaField);
        
        if (ClientInfo.isMobile()) {    		
    		if (noOfParameterColumn == 2)
				LayoutUtils.compactTo(parameterStdLayout, 2);		
			ClientInfo.onClientInfo(window, this::onClientInfo);
		}
        
        hideEmptyRow(rows);
	}

	private void hideEmptyRow(org.zkoss.zul.Rows rows) {
		for(Component a : rows.getChildren()) {
			Row row = (Row) a;
			boolean visible = false;
			for(Component b : row.getChildren()) {
				if (b instanceof Space)
					continue;
				else if (!b.isVisible()) {
					continue;
				} else {
					if (!b.getChildren().isEmpty()) {
						for (Component c : b.getChildren()) {
							if (c.isVisible()) {
								visible = true;
								break;
							}
						}
					} else {
						visible = true;
						break;
					}
				}
			}
			row.setVisible(visible);
		}
	}

	private boolean 	m_actionActive = false;

	private int noOfParameterColumn;
	
	@Override
	public void onEvent(Event e) throws Exception
	{
		if (m_actionActive)
			return;
		m_actionActive = true;
		
		//  Order
		if (e.getTarget().equals(orderField))
		{
			ListItem li = orderField.getSelectedItem();
			int C_Order_ID = 0;
			if (li != null && li.getValue() != null)
				C_Order_ID = ((Integer) li.getValue()).intValue();
			//  set Invoice, RMA and Shipment to Null
			rmaField.setSelectedIndex(-1);
			shipmentField.setSelectedIndex(-1);
			loadOrder(C_Order_ID, true);
		}
		//  Shipment
		else if (e.getTarget().equals(shipmentField))
		{
			ListItem li = shipmentField.getSelectedItem();
			int M_InOut_ID = 0;
			if (li != null && li.getValue() != null)
				M_InOut_ID = ((Integer) li.getValue()).intValue();
			//  set Order, RMA and Invoice to Null
			orderField.setSelectedIndex(-1);
			rmaField.setSelectedIndex(-1);
			loadShipment(M_InOut_ID);
		}
		//  RMA
		else if (e.getTarget().equals(rmaField))
		{
			ListItem li = rmaField.getSelectedItem();
		    int M_RMA_ID = 0;
		    if (li != null && li.getValue() != null)
		        M_RMA_ID = ((Integer) li.getValue()).intValue();
		    //  set Order and Invoice to Null
		    orderField.setSelectedIndex(-1);
		    shipmentField.setSelectedIndex(-1);
		    loadRMA(M_RMA_ID);
		}
		m_actionActive = false;
	}
	
	@Override
	public void valueChange (ValueChangeEvent e)
	{
		if (log.isLoggable(Level.CONFIG)) log.config(e.getPropertyName() + "=" + e.getNewValue());

		//  BPartner - load Order/Invoice/Shipment
		if (e.getPropertyName().equals("C_BPartner_ID"))
		{
			Integer newBpValue = (Integer)e.getNewValue();
			int C_BPartner_ID = newBpValue == null?0:newBpValue.intValue();
			initBPOrderDetails (C_BPartner_ID, true);
		}
		window.tableChanged(null);
	}   //  vetoableChange
	
	/**************************************************************************
	 *  Load BPartner Field
	 *  @param forInvoice true if Invoices are to be created, false receipts
	 *  @throws Exception if Lookups cannot be initialized
	 */
	protected void initBPartner (boolean forInvoice) throws Exception
	{
		//  load BPartner
		int AD_Column_ID = COLUMN_C_INVOICE_C_BPARTNER_ID;        //  C_Invoice.C_BPartner_ID
		MLookup lookup = MLookupFactory.get (Env.getCtx(), p_WindowNo, 0, AD_Column_ID, DisplayType.Search);
		bPartnerField = new WSearchEditor ("C_BPartner_ID", true, false, true, lookup);
		//
		int C_BPartner_ID = Env.getContextAsInt(Env.getCtx(), p_WindowNo, "C_BPartner_ID");
		bPartnerField.setValue(Integer.valueOf(C_BPartner_ID));

		//  initial loading
		initBPOrderDetails(C_BPartner_ID, forInvoice);
	}   //  initBPartner

	/**
	 *  Load BPartner dependent Order/Shipment/RMA Field.
	 *  @param C_BPartner_ID BPartner
	 *  @param forInvoice for invoice
	 */
	protected void initBPOrderDetails (int C_BPartner_ID, boolean forInvoice)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_BPartner_ID=" + C_BPartner_ID);
		KeyNamePair pp = new KeyNamePair(0,"");
		//  load PO Orders - Closed, Completed
		orderField.removeActionListener(this);
		orderField.removeAllItems();
		orderField.addItem(pp);
		
		ArrayList<KeyNamePair> list = loadOrderData(C_BPartner_ID, forInvoice, false, isCreditMemo);
		for(KeyNamePair knp : list)
			orderField.addItem(knp);
		
		orderField.setSelectedIndex(0);
		orderField.addActionListener(this);

		initBPDetails(C_BPartner_ID);
	}   //  initBPartnerOIS
	
	private void initBPDetails(int C_BPartner_ID) 
	{
		initBPShipmentDetails(C_BPartner_ID);
		initBPRMADetails(C_BPartner_ID);
	}

	/**
	 * Load PBartner dependent Shipment Field.
	 * @param C_BPartner_ID
	 */
	private void initBPShipmentDetails(int C_BPartner_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_BPartner_ID" + C_BPartner_ID);

		//  load Shipments (Receipts) - Completed, Closed
		shipmentField.removeActionListener(this);
		shipmentField.removeAllItems();
		//	None
		KeyNamePair pp = new KeyNamePair(0,"");
		shipmentField.addItem(pp);
		
		ArrayList<KeyNamePair> list = loadShipmentData(C_BPartner_ID);
		for(KeyNamePair knp : list)
			shipmentField.addItem(knp);
		
		shipmentField.setSelectedIndex(0);
		shipmentField.addActionListener(this);
	}
	
	/**
	 * Load RMA that are candidates for billing
	 * @param C_BPartner_ID BPartner
	 */
	private void initBPRMADetails(int C_BPartner_ID)
	{
	    rmaField.removeActionListener(this);
	    rmaField.removeAllItems();
	    //  None
	    KeyNamePair pp = new KeyNamePair(0,"");
	    rmaField.addItem(pp);
	    
	    ArrayList<KeyNamePair> list = loadRMAData(C_BPartner_ID);
		for(KeyNamePair knp : list)
			rmaField.addItem(knp);
		
	    rmaField.setSelectedIndex(0);
	    rmaField.addActionListener(this);
	}

	/**
	 *  Load Order Line records
	 *  @param C_Order_ID Order
	 *  @param forInvoice true if for invoice vs. delivery qty
	 */
	protected void loadOrder (int C_Order_ID, boolean forInvoice)
	{
		loadTableOIS(getOrderData(C_Order_ID, forInvoice, isCreditMemo));
	}   //  LoadOrder
	
	/**
	 * load RMA Line records
	 * @param M_RMA_ID
	 */
	protected void loadRMA (int M_RMA_ID)
	{
		loadTableOIS(getRMAData(M_RMA_ID));
	}
	
	/**
	 * load shipment line records
	 * @param M_InOut_ID
	 */
	protected void loadShipment (int M_InOut_ID)
	{
		loadTableOIS(getShipmentData(M_InOut_ID));
	}
	
	/**
	 *  Load datas into list box
	 *  @param data data
	 */
	protected void loadTableOIS (Vector<?> data)
	{
		window.getWListbox().clear();
		
		//  Remove previous listeners
		window.getWListbox().getModel().removeTableModelListener(window);
		//  Set Model
		ListModelTable model = new ListModelTable(data);
		model.addTableModelListener(window);
		window.getWListbox().setData(model, getOISColumnNames());
		//
		
		configureMiniTable(window.getWListbox());
	}   //  loadOrder
	
	@Override
	public void showWindow()
	{
		window.setVisible(true);
	}
	
	@Override
	public void closeWindow()
	{
		window.dispose();
	}

	@Override
	public Object getWindow() {
		return window;
	}
	
	/**
	 * configure layout of parameter grid
	 * @param parameterGrid
	 */
	protected void setupColumns(Grid parameterGrid) {
		noOfParameterColumn = ClientInfo.maxWidth((ClientInfo.EXTRA_SMALL_WIDTH+ClientInfo.SMALL_WIDTH)/2) ? 2 : 4;
		Columns columns = new Columns();
		parameterGrid.appendChild(columns);
		if (ClientInfo.maxWidth((ClientInfo.EXTRA_SMALL_WIDTH+ClientInfo.SMALL_WIDTH)/2))
		{
			Column column = new Column();
			ZKUpdateUtil.setWidth(column, "35%");
			columns.appendChild(column);
			column = new Column();
			ZKUpdateUtil.setWidth(column, "65%");
			columns.appendChild(column);
		}
		else
		{
			Column column = new Column();
			columns.appendChild(column);		
			column = new Column();
			ZKUpdateUtil.setWidth(column, "15%");
			columns.appendChild(column);
			ZKUpdateUtil.setWidth(column, "35%");
			column = new Column();
			ZKUpdateUtil.setWidth(column, "15%");
			columns.appendChild(column);
			column = new Column();
			ZKUpdateUtil.setWidth(column, "35%");
			columns.appendChild(column);
		}
	}
	
	/**
	 * handle onClientInfo event
	 */
	protected void onClientInfo()
	{
		if (ClientInfo.isMobile() && parameterStdLayout != null && parameterStdLayout.getRows() != null)
		{
			int nc = ClientInfo.maxWidth((ClientInfo.EXTRA_SMALL_WIDTH+ClientInfo.SMALL_WIDTH)/2) ? 2 : 4;
			int cc = noOfParameterColumn;
			if (nc == cc)
				return;
			
			parameterStdLayout.getColumns().detach();
			setupColumns(parameterStdLayout);
			if (cc > nc)
			{
				LayoutUtils.compactTo(parameterStdLayout, nc);
			}
			else
			{
				LayoutUtils.expandTo(parameterStdLayout, nc, false);
			}
			hideEmptyRow(parameterStdLayout.getRows());
			
			ZKUpdateUtil.setCSSHeight(window);
			ZKUpdateUtil.setCSSWidth(window);
			window.invalidate();			
		}
	}
}
