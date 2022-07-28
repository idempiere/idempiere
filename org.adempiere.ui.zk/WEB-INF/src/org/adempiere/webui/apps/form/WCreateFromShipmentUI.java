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

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WLocatorEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WStringEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.grid.CreateFromShipment;
import org.compiere.model.GridTab;
import org.compiere.model.MLocatorLookup;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MProduct;

import static org.compiere.model.SystemIDs.*;

import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;

/**
 * 
 * @author hengsin
 *
 */
public class WCreateFromShipmentUI extends CreateFromShipment implements EventListener<Event>, ValueChangeListener
{

	private WCreateFromWindow window;
	
	/**
	 * 
	 * @param tab
	 */
	public WCreateFromShipmentUI(GridTab tab) 
	{
		super(tab);
		if (log.isLoggable(Level.INFO)) log.info(getGridTab().toString());
		
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
			throw new AdempiereException(e.getMessage());
		}
		AEnv.showWindow(window);
	}
	
	/** Window No               */
	private int p_WindowNo;

	/**	Logger			*/
	private final static CLogger log = CLogger.getCLogger(WCreateFromShipmentUI.class);
		
	protected Label bPartnerLabel = new Label();
	protected WEditor bPartnerField;
	
	protected Label orderLabel = new Label();
	protected Listbox orderField = ListboxFactory.newDropdownListbox();

    /** Label for the rma selection */
    protected Label rmaLabel = new Label();
    /** Combo box for selecting RMA document */
    protected Listbox rmaField = ListboxFactory.newDropdownListbox();
	
    protected Label invoiceLabel = new Label();
    protected Listbox invoiceField = ListboxFactory.newDropdownListbox();
	protected Checkbox sameWarehouseCb = new Checkbox();
	protected Label locatorLabel = new Label();
	protected WLocatorEditor locatorField = new WLocatorEditor();
	protected Label upcLabel = new Label();
	protected WStringEditor upcField = new WStringEditor();

	private Grid parameterStdLayout;

	private int noOfParameterColumn;
    
	@Override
	protected boolean dynInit() throws Exception
	{
		if (log.isLoggable(Level.CONFIG)) log.config("");
		
		super.dynInit();
		
		window.setTitle(getTitle());

		sameWarehouseCb.setSelected(true);
		sameWarehouseCb.addActionListener(this);
		//  load Locator
		MLocatorLookup locator = new MLocatorLookup(Env.getCtx(), p_WindowNo, (String)null);
		locatorField = new WLocatorEditor ("M_Locator_ID", true, false, true, locator, p_WindowNo);

		initBPartner(false);
		bPartnerField.addValueChangeListener(this);
		locatorLabel.setMandatory(true);

		upcField = new WStringEditor ("UPC", false, false, true, 10, 30, null, null);
		upcField.getComponent().addEventListener(Events.ON_CHANGE, this);

		return true;
	}   //  dynInit
	
	protected void zkInit() throws Exception
	{
    	boolean isRMAWindow = ((getGridTab().getAD_Window_ID() == WINDOW_RETURNTOVENDOR) || (getGridTab().getAD_Window_ID() == WINDOW_CUSTOMERRETURN)); 

    	bPartnerLabel.setText(Msg.getElement(Env.getCtx(), "C_BPartner_ID"));
		orderLabel.setText(Msg.getElement(Env.getCtx(), "C_Order_ID", false));
		invoiceLabel.setText(Msg.getElement(Env.getCtx(), "C_Invoice_ID", false));
        rmaLabel.setText(Msg.translate(Env.getCtx(), "M_RMA_ID"));
		locatorLabel.setText(Msg.translate(Env.getCtx(), "M_Locator_ID"));
        sameWarehouseCb.setText(Msg.getMsg(Env.getCtx(), "FromSameWarehouseOnly", true));
        sameWarehouseCb.setTooltiptext(Msg.getMsg(Env.getCtx(), "FromSameWarehouseOnly", false));
        upcLabel.setText(Msg.getElement(Env.getCtx(), "UPC", false));

		Vlayout vlayout = new Vlayout();
		ZKUpdateUtil.setVflex(vlayout, "min");
		ZKUpdateUtil.setWidth(vlayout, "100%");
    	Panel parameterPanel = window.getParameterPanel();
		parameterPanel.appendChild(vlayout);
		
		parameterStdLayout = GridFactory.newGridLayout();
    	vlayout.appendChild(parameterStdLayout);
    	ZKUpdateUtil.setVflex(vlayout, "parameterStdLayout");
    	
    	setupColumns(parameterStdLayout);
		
		Rows rows = (Rows) parameterStdLayout.newRows();
		Row row = rows.newRow();
		row.appendChild(bPartnerLabel.rightAlign());
		if (bPartnerField != null) {
			row.appendChild(bPartnerField.getComponent());
			bPartnerField.fillHorizontal();
		}
    	if (! isRMAWindow) {
    		row.appendChild(orderLabel.rightAlign());
    		row.appendChild(orderField);
    		ZKUpdateUtil.setHflex(orderField, "1");
    	}
		
		row = rows.newRow();
		row.appendChild(locatorLabel.rightAlign());
		row.appendChild(locatorField.getComponent());
    	if (! isRMAWindow) {
    		row.appendChild(invoiceLabel.rightAlign());
    		row.appendChild(invoiceField);
    		ZKUpdateUtil.setHflex(invoiceField, "1");
    	}
        
		row = rows.newRow();
		row.appendChild(new Space());
		row.appendChild(sameWarehouseCb);
		
		row = rows.newRow();
		row.appendChild(upcLabel.rightAlign());
		row.appendChild(upcField.getComponent());
		ZKUpdateUtil.setHflex(upcField.getComponent(), "1");
    	if (isRMAWindow) {
            // Add RMA document selection to panel
            row.appendChild(rmaLabel.rightAlign());
            row.appendChild(rmaField);
            ZKUpdateUtil.setHflex(rmaField, "1");
    	}
    	
    	if (ClientInfo.isMobile()) {    		
    		if (noOfParameterColumn == 2)
				LayoutUtils.compactTo(parameterStdLayout, 2);		
			ClientInfo.onClientInfo(window, this::onClientInfo);
		}
	}

	private boolean 	m_actionActive = false;
	
	@Override
	public void onEvent(Event e) throws Exception
	{
		if (m_actionActive)
			return;
		m_actionActive = true;

		//  Order
		if (e.getTarget().equals(orderField))
		{
			KeyNamePair pp = orderField.getSelectedItem().toKeyNamePair();
			if (pp != null && pp.getKey() > 0)
			{
				int C_Order_ID = pp.getKey();
				//  set Invoice and Shipment to Null
				invoiceField.setSelectedIndex(-1);
                rmaField.setSelectedIndex(-1);
				loadOrder(C_Order_ID, false, locatorField.getValue()!=null?((Integer)locatorField.getValue()).intValue():0);
			}
		}
		//  Invoice
		else if (e.getTarget().equals(invoiceField))
		{
			KeyNamePair pp = invoiceField.getSelectedItem().toKeyNamePair();
			if (pp != null && pp.getKey() > 0)
			{
				int C_Invoice_ID = pp.getKey();
				//  set Order and Shipment to Null
				orderField.setSelectedIndex(-1);
                rmaField.setSelectedIndex(-1);
				loadInvoice(C_Invoice_ID, locatorField.getValue()!=null?((Integer)locatorField.getValue()).intValue():0);
			}
		}
		// RMA
        else if (e.getTarget().equals(rmaField))
        {
            KeyNamePair pp = rmaField.getSelectedItem().toKeyNamePair();
			if (pp != null && pp.getKey() > 0)
            {
                int M_RMA_ID = pp.getKey();
                //  set Order and Shipment to Null
                orderField.setSelectedIndex(-1);
                invoiceField.setSelectedIndex(-1);
                loadRMA(M_RMA_ID, locatorField.getValue()!=null?((Integer)locatorField.getValue()).intValue():0);
            }
        }
		//sameWarehouseCb
        else if (e.getTarget().equals(sameWarehouseCb))
        {
        	int bpId = bPartnerField.getValue() == null?0:((Integer)bPartnerField.getValue()).intValue();
        	initBPOrderDetails(bpId, false);
        }	
		else if (e.getTarget().equals(upcField.getComponent()))
		{
			checkProductUsingUPC();
		}
		
		m_actionActive = false;
	}
	
	/**
	 * Checks the UPC value and checks if the UPC matches any of the products in the
	 * list.
	 */
	private void checkProductUsingUPC()
	{
		String upc = upcField.getDisplay();
		//DefaultTableModel model = (DefaultTableModel) dialog.getMiniTable().getModel();
		ListModelTable model = (ListModelTable) window.getWListbox().getModel();
		
		// Lookup UPC
		List<MProduct> products = MProduct.getByUPC(Env.getCtx(), upc, null);
		for (MProduct product : products)
		{
			int row = findProductRow(product.get_ID());
			if (row >= 0)
			{
				BigDecimal qty = (BigDecimal)model.getValueAt(row, 1);
				model.setValueAt(qty, row, 1);
				model.setValueAt(Boolean.TRUE, row, 0);
				model.updateComponent(row, row);
			}
		}
		upcField.setValue("");
	}

	/**
	 * Finds the row where a given product is. If the product is not found
	 * in the table -1 is returned.
	 * @param M_Product_ID
	 * @return  Row of the product or -1 if non existing.
	 * 
	 */
	private int findProductRow(int M_Product_ID)
	{
		//DefaultTableModel model = (DefaultTableModel)dialog.getMiniTable().getModel();
		ListModelTable model = (ListModelTable) window.getWListbox().getModel();
		KeyNamePair kp;
		for (int i=0; i<model.getRowCount(); i++) {
			kp = (KeyNamePair)model.getValueAt(i, 4);
			if (kp.getKey()==M_Product_ID) {
				return(i);
			}
		}
		return(-1);
	}
		
	@Override
	public void valueChange (ValueChangeEvent e)
	{
		if (log.isLoggable(Level.CONFIG)) log.config(e.getPropertyName() + "=" + e.getNewValue());

		//  BPartner - load Order/Invoice/Shipment
		if (e.getPropertyName().equals("C_BPartner_ID"))
		{
			int C_BPartner_ID = 0; 
			if (e.getNewValue() != null){
				C_BPartner_ID = ((Integer)e.getNewValue()).intValue();
			}
			
			initBPOrderDetails (C_BPartner_ID, false);
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
		int AD_Column_ID = 3499;        //  C_Invoice.C_BPartner_ID
		MLookup lookup = MLookupFactory.get (Env.getCtx(), p_WindowNo, 0, AD_Column_ID, DisplayType.Search);
		bPartnerField = new WSearchEditor ("C_BPartner_ID", true, false, true, lookup);
		//
		int C_BPartner_ID = Env.getContextAsInt(Env.getCtx(), p_WindowNo, "C_BPartner_ID");
		bPartnerField.setValue(Integer.valueOf(C_BPartner_ID));

		//  initial loading
		initBPOrderDetails(C_BPartner_ID, forInvoice);
	}   //  initBPartner

	/**
	 * Init Details - load invoices not shipped
	 * @param C_BPartner_ID BPartner
	 */
	private void initBPInvoiceDetails(int C_BPartner_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_BPartner_ID" + C_BPartner_ID);

		//  load Shipments (Receipts) - Completed, Closed
		invoiceField.removeActionListener(this);
		invoiceField.removeAllItems();
		//	None
		KeyNamePair pp = new KeyNamePair(0,"");
		invoiceField.addItem(pp);
		
		ArrayList<KeyNamePair> list = loadInvoiceData(C_BPartner_ID);
		for(KeyNamePair knp : list)
			invoiceField.addItem(knp);
		
		invoiceField.setSelectedIndex(0);
		invoiceField.addActionListener(this);
		upcField.addValueChangeListener(this);
	}
	
	/**
	 *  Load BPartner dependent Order Field.
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
		
		ArrayList<KeyNamePair> list = loadOrderData(C_BPartner_ID, forInvoice, sameWarehouseCb.isSelected());
		for(KeyNamePair knp : list)
			orderField.addItem(knp);
		
		int C_Order_ID = Env.getContextAsInt(Env.getCtx(), p_WindowNo, "C_Order_ID");
		if (C_Order_ID > 0) {
			orderField.setValue(Integer.valueOf(C_Order_ID));
			if (orderField.getSelectedItem() != null) { // in case the order is not in the list, f.e. the BP was changed
				KeyNamePair knpo = orderField.getSelectedItem().toKeyNamePair();
				if (knpo != null && knpo.getKey() > 0)
					loadOrder(knpo.getKey(), false, locatorField.getValue()!=null?((Integer)locatorField.getValue()).intValue():0);
			}
		} else {
			orderField.setSelectedIndex(0);
		}
		orderField.addActionListener(this);

		initBPDetails(C_BPartner_ID);
	}   //  initBPOrderDetails
	
	/**
	 * load bpartner related details
	 * @param C_BPartner_ID
	 */
	protected void initBPDetails(int C_BPartner_ID) 
	{
		initBPInvoiceDetails(C_BPartner_ID);
		initBPRMADetails(C_BPartner_ID);
	}

	
	/**
	 * Load RMA that are candidates for shipment
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
	 *  Load Order lines
	 *  @param C_Order_ID Order
	 *  @param forInvoice true if for invoice vs. delivery qty
	 *  @param M_Locator_ID
	 */
	protected void loadOrder (int C_Order_ID, boolean forInvoice, int M_Locator_ID)
	{
		loadTableOIS(getOrderData(C_Order_ID, forInvoice, M_Locator_ID));
	}   //  LoadOrder
	
	/**
	 *  Load RMA lines
	 *  @param M_RMA_ID RMA
	 *  @param M_Locator_ID
	 */
	protected void loadRMA (int M_RMA_ID, int M_Locator_ID)
	{
		loadTableOIS(getRMAData(M_RMA_ID, M_Locator_ID));
	}
		
	/**
	 *  Load Invoice Lines
	 *  @param C_Invoice_ID Invoice
	 *  @param M_Locator_ID
	 */
	protected void loadInvoice (int C_Invoice_ID, int M_Locator_ID)
	{
		loadTableOIS(getInvoiceData(C_Invoice_ID, M_Locator_ID));
	}
		
	/**
	 *  Load data into list box
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
	 * Configure layout of parameter grid
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
			
			ZKUpdateUtil.setCSSHeight(window);
			ZKUpdateUtil.setCSSWidth(window);
			window.invalidate();			
		}
	}
}
