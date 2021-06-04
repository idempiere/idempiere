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
package org.adempiere.webui.apps.form;

import static org.compiere.model.SystemIDs.COLUMN_C_INVOICE_C_BPARTNER_ID;
import static org.compiere.model.SystemIDs.COLUMN_C_INVOICE_C_CURRENCY_ID;
import static org.compiere.model.SystemIDs.COLUMN_C_PERIOD_AD_ORG_ID;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.DocumentLink;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.editor.WDateEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.CustomForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.apps.form.Allocation;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.TrxRunnable;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

import static org.adempiere.webui.ClientInfo.*;

/**
 * Allocation Form
 *
 * @author  Jorg Janke
 * @version $Id: VAllocation.java,v 1.2 2006/07/30 00:51:28 jjanke Exp $
 * 
 * Contributor : Fabian Aguilar - OFBConsulting - Multiallocation
 */
public class WAllocation extends Allocation
	implements IFormController, EventListener<Event>, WTableModelListener, ValueChangeListener
{

	private CustomForm form = new CustomForm();
	
	/**
	 *	Initialize Panel
	 *  @param WindowNo window
	 *  @param frame frame
	 */
	public WAllocation()
	{
		try
		{
			super.dynInit();
			dynInit();
			zkInit();
			calculate();			
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		
		if (ClientInfo.isMobile()) 
		{
			ClientInfo.onClientInfo(form, this::onClientInfo);
		}
	}	//	init
	
	//
	private Borderlayout mainLayout = new Borderlayout();
	private Panel parameterPanel = new Panel();
	private Panel allocationPanel = new Panel(); //footer
	private Grid parameterLayout = GridFactory.newGridLayout();
	private Label bpartnerLabel = new Label();
	private WSearchEditor bpartnerSearch = null;
	private WListbox invoiceTable = ListboxFactory.newDataTable();
	private WListbox paymentTable = ListboxFactory.newDataTable();
	private Borderlayout infoPanel = new Borderlayout();
	private Panel paymentPanel = new Panel();
	private Panel invoicePanel = new Panel();
	private Label paymentLabel = new Label();
	private Label invoiceLabel = new Label();
	private Borderlayout paymentLayout = new Borderlayout();
	private Borderlayout invoiceLayout = new Borderlayout();
	private Label paymentInfo = new Label();
	private Label invoiceInfo = new Label();
	private Grid allocationLayout = GridFactory.newGridLayout();
	private Label differenceLabel = new Label();
	private Textbox differenceField = new Textbox();
	private Button allocateButton = new Button();
	private Button refreshButton = new Button();
	private Label currencyLabel = new Label();
	private WTableDirEditor currencyPick = null;
	private Checkbox multiCurrency = new Checkbox();
	private Label chargeLabel = new Label();
	private WTableDirEditor chargePick = null;
	private Label DocTypeLabel = new Label();
	private WTableDirEditor DocTypePick = null;
	private Label allocCurrencyLabel = new Label();
	private Hlayout statusBar = new Hlayout();
	private Label dateLabel = new Label();
	private WDateEditor dateField = new WDateEditor();
	private Checkbox autoWriteOff = new Checkbox();
	private Label organizationLabel = new Label();
	private WTableDirEditor organizationPick;
	private int noOfColumn;
	
	/**
	 *  Static Init
	 *  @throws Exception
	 */
	private void zkInit() throws Exception
	{
		//
		Div div = new Div();
		div.setStyle("height: 100%; width: 100%; overflow: auto;");
		div.appendChild(mainLayout);
		form.appendChild(div);
		ZKUpdateUtil.setWidth(mainLayout, "100%");
		
		/////
		mainLayout.setStyle("min-height: 600px");
		/////
		
		dateLabel.setText(Msg.getMsg(Env.getCtx(), "Date"));
		autoWriteOff.setSelected(false);
		autoWriteOff.setText(Msg.getMsg(Env.getCtx(), "AutoWriteOff", true));
		autoWriteOff.setTooltiptext(Msg.getMsg(Env.getCtx(), "AutoWriteOff", false));
		//
		parameterPanel.appendChild(parameterLayout);
		allocationPanel.appendChild(allocationLayout);
		bpartnerLabel.setText(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		paymentLabel.setText(" " + Msg.translate(Env.getCtx(), "C_Payment_ID"));
		invoiceLabel.setText(" " + Msg.translate(Env.getCtx(), "C_Invoice_ID"));
		paymentPanel.appendChild(paymentLayout);
		invoicePanel.appendChild(invoiceLayout);
		invoiceInfo.setText(".");
		paymentInfo.setText(".");
		chargeLabel.setText(" " + Msg.translate(Env.getCtx(), "C_Charge_ID"));
		DocTypeLabel.setText(" " + Msg.translate(Env.getCtx(), "C_DocType_ID"));	
		differenceLabel.setText(Msg.getMsg(Env.getCtx(), "Difference"));
		differenceField.setText("0");
		differenceField.setReadonly(true);
		differenceField.setStyle("text-align: right");
		allocateButton.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Process")));
		allocateButton.addActionListener(this);
		refreshButton.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
		refreshButton.addActionListener(this);
		refreshButton.setAutodisable("self");
		currencyLabel.setText(Msg.translate(Env.getCtx(), "C_Currency_ID"));
		multiCurrency.setText(Msg.getMsg(Env.getCtx(), "MultiCurrency"));
		multiCurrency.addActionListener(this);
		allocCurrencyLabel.setText(".");
		
		organizationLabel.setText(Msg.translate(Env.getCtx(), "AD_Org_ID"));
		
		// parameters layout
		North north = new North();
		north.setBorder("none");
		north.setSplittable(true);
		north.setCollapsible(true);
		mainLayout.appendChild(north);
		north.appendChild(parameterPanel);
		
		layoutParameterAndSummary();
		
		// payment layout
		paymentPanel.appendChild(paymentLayout);
		ZKUpdateUtil.setWidth(paymentPanel, "100%");
		ZKUpdateUtil.setWidth(paymentLayout, "100%");
		ZKUpdateUtil.setVflex(paymentPanel, "1");
		ZKUpdateUtil.setVflex(paymentLayout, "1");
		
		// invoice layout
		invoicePanel.appendChild(invoiceLayout);
		ZKUpdateUtil.setWidth(invoicePanel, "100%");
		ZKUpdateUtil.setWidth(invoiceLayout, "100%");
		ZKUpdateUtil.setVflex(invoicePanel, "1");
		ZKUpdateUtil.setVflex(invoiceLayout, "1");
		
		// payment layout north - label
		north = new North();
		north.setBorder("none");
		paymentLayout.appendChild(north);
		north.appendChild(paymentLabel);
		ZKUpdateUtil.setVflex(paymentLabel, "min");
		// payment layout south - sum
		South south = new South();
		south.setBorder("none");
		paymentLayout.appendChild(south);
		south.appendChild(paymentInfo.rightAlign());
		ZKUpdateUtil.setVflex(paymentInfo, "min");
		//payment layout center - payment list
		Center center = new Center();
		paymentLayout.appendChild(center);
		center.appendChild(paymentTable);
		ZKUpdateUtil.setWidth(paymentTable, "100%");
		ZKUpdateUtil.setVflex(paymentTable, "1");
		center.setBorder("none");
		
		// invoice layout north - label
		north = new North();
		north.setBorder("none");
		invoiceLayout.appendChild(north);
		north.appendChild(invoiceLabel);
		ZKUpdateUtil.setVflex(invoiceLabel, "min");
		// invoice layout south - sum
		south = new South();
		south.setBorder("none");
		invoiceLayout.appendChild(south);
		south.appendChild(invoiceInfo.rightAlign());
		ZKUpdateUtil.setVflex(invoiceInfo, "min");
		// invoice layout center - invoice list
		center = new Center();
		invoiceLayout.appendChild(center);
		center.appendChild(invoiceTable);
		ZKUpdateUtil.setWidth(invoiceTable, "100%");
		ZKUpdateUtil.setVflex(invoiceTable, "1");
		center.setStyle("border: none");
		
		// mainlayout center - payment + invoice 
		center = new Center();
		mainLayout.appendChild(center);
		center.appendChild(infoPanel);
		ZKUpdateUtil.setHflex(infoPanel, "1");
		ZKUpdateUtil.setVflex(infoPanel, "1");
		
		infoPanel.setStyle("border: none");
		ZKUpdateUtil.setWidth(infoPanel, "100%");
		
		// north of mainlayout center - payment
		north = new North();
		north.setBorder("none");
		infoPanel.appendChild(north);
		north.appendChild(paymentPanel);
		north.setAutoscroll(true);
		north.setSplittable(true);
		north.setSize("50%");
		north.setCollapsible(true);

		// center of mainlayout center - invoice
		center = new Center();
		center.setBorder("none");
		infoPanel.appendChild(center);
		center.appendChild(invoicePanel);
		center.setAutoscroll(true);
		infoPanel.setStyle("min-height: 300px;");
	}   //  jbInit

	protected void layoutParameterAndSummary() {
		Rows rows = null;
		Row row = null;
		
		setupParameterColumns();
		
		rows = parameterLayout.newRows();
		row = rows.newRow();
		row.appendCellChild(bpartnerLabel.rightAlign());
		ZKUpdateUtil.setHflex(bpartnerSearch.getComponent(), "true");
		row.appendCellChild(bpartnerSearch.getComponent(),1);
		bpartnerSearch.showMenu();
		row.appendChild(dateLabel.rightAlign());
		row.appendChild(dateField.getComponent());
		
		row.appendCellChild(organizationLabel.rightAlign());
		ZKUpdateUtil.setHflex(organizationPick.getComponent(), "true");
		row.appendCellChild(organizationPick.getComponent(),1);
		organizationPick.showMenu();		
		
		row = rows.newRow();
		row.appendCellChild(currencyLabel.rightAlign(),1);
		ZKUpdateUtil.setHflex(currencyPick.getComponent(), "true");
		row.appendCellChild(currencyPick.getComponent(),1);		
		currencyPick.showMenu();
		
		Hbox cbox = new Hbox();
		cbox.setWidth("100%");
		if (noOfColumn == 6)
			cbox.setPack("center");
		else
			cbox.setPack("end");
		cbox.appendChild(multiCurrency);
		cbox.appendChild(autoWriteOff);
		row.appendCellChild(cbox, 2);		
		if (noOfColumn < 6)		
			LayoutUtils.compactTo(parameterLayout, noOfColumn);
		else
			LayoutUtils.expandTo(parameterLayout, noOfColumn, true);
		
		// footer/allocations layout
		South south = new South();
		south.setBorder("none");
		mainLayout.appendChild(south);
		south.appendChild(allocationPanel);
		allocationPanel.appendChild(allocationLayout);
		allocationPanel.appendChild(statusBar);
		ZKUpdateUtil.setWidth(allocationLayout, "100%");
		ZKUpdateUtil.setHflex(allocationPanel, "1");
		ZKUpdateUtil.setVflex(allocationPanel, "min");
		ZKUpdateUtil.setVflex(allocationLayout, "min");
		ZKUpdateUtil.setVflex(statusBar, "min");
		ZKUpdateUtil.setVflex(south, "min");
		rows = allocationLayout.newRows();
		row = rows.newRow();
		if (maxWidth(SMALL_WIDTH-1))
		{
			Hbox box = new Hbox();
			box.setWidth("100%");
			box.setPack("end");
			box.appendChild(differenceLabel.rightAlign());
			box.appendChild(allocCurrencyLabel.rightAlign());
			row.appendCellChild(box);
		}
		else
		{
			Hlayout box = new Hlayout();
			box.setStyle("float: right");
			box.appendChild(differenceLabel.rightAlign());
			box.appendChild(allocCurrencyLabel.rightAlign());
			row.appendCellChild(box);
		}
		ZKUpdateUtil.setHflex(differenceField, "true");
		row.appendCellChild(differenceField);
		if (maxWidth(SMALL_WIDTH-1))
			row = rows.newRow();
		row.appendCellChild(chargeLabel.rightAlign());
		ZKUpdateUtil.setHflex(chargePick.getComponent(), "true");
		row.appendCellChild(chargePick.getComponent());
		if (maxWidth(SMALL_WIDTH-1))
			row = rows.newRow();
		row.appendCellChild(DocTypeLabel.rightAlign());
		chargePick.showMenu();
		ZKUpdateUtil.setHflex(DocTypePick.getComponent(), "true");
		row.appendCellChild(DocTypePick.getComponent());
		DocTypePick.showMenu();
		if (maxWidth(SMALL_WIDTH-1))
		{
			row = rows.newRow();
			Hbox box = new Hbox();
			box.setWidth("100%");
			box.setPack("end");
			box.appendChild(allocateButton);
			box.appendChild(refreshButton);
			row.appendCellChild(box, 2);
		}
		else
		{
			Hbox box = new Hbox();
			box.setPack("end");
			box.appendChild(allocateButton);
			box.appendChild(refreshButton);
			ZKUpdateUtil.setHflex(box, "1");
			row.appendCellChild(box, 2);
		}
	}

	protected void setupParameterColumns() {
		noOfColumn = 6;
		if (maxWidth(MEDIUM_WIDTH-1))
		{
			if (maxWidth(SMALL_WIDTH-1))
				noOfColumn = 2;
			else
				noOfColumn = 4;
		}
		if (noOfColumn == 2)
		{
			Columns columns = new Columns();
			Column column = new Column();
			column.setWidth("35%");
			columns.appendChild(column);
			column = new Column();
			column.setWidth("65%");
			columns.appendChild(column);
			parameterLayout.appendChild(columns);
		}
	}

	/**
	 *  Dynamic Init (prepare dynamic fields)
	 *  @throws Exception if Lookups cannot be initialized
	 */
	public void dynInit() throws Exception
	{
		//  Currency
		int AD_Column_ID = COLUMN_C_INVOICE_C_CURRENCY_ID;    //  C_Invoice.C_Currency_ID
		MLookup lookupCur = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.TableDir);
		currencyPick = new WTableDirEditor("C_Currency_ID", true, false, true, lookupCur);
		currencyPick.setValue(Integer.valueOf(m_C_Currency_ID));
		currencyPick.addValueChangeListener(this);

		// Organization filter selection
		AD_Column_ID = COLUMN_C_PERIOD_AD_ORG_ID; //C_Period.AD_Org_ID (needed to allow org 0)
		MLookup lookupOrg = MLookupFactory.get(Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.TableDir);
		organizationPick = new WTableDirEditor("AD_Org_ID", true, false, true, lookupOrg);
		organizationPick.setValue(Env.getAD_Org_ID(Env.getCtx()));
		organizationPick.addValueChangeListener(this);
		
		//  BPartner
		AD_Column_ID = COLUMN_C_INVOICE_C_BPARTNER_ID;        //  C_Invoice.C_BPartner_ID
		MLookup lookupBP = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.Search);
		bpartnerSearch = new WSearchEditor("C_BPartner_ID", true, false, true, lookupBP);
		bpartnerSearch.addValueChangeListener(this);

		//  Translation
		statusBar.appendChild(new Label(Msg.getMsg(Env.getCtx(), "AllocateStatus")));
		ZKUpdateUtil.setVflex(statusBar, "min");
		
		//  Date set to Login Date
		Calendar cal = Calendar.getInstance();
		cal.setTime(Env.getContextAsDate(Env.getCtx(), "#Date"));
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		dateField.setValue(new Timestamp(cal.getTimeInMillis()));
		dateField.addValueChangeListener(this);

		
		//  Charge
		AD_Column_ID = 61804;    //  C_AllocationLine.C_Charge_ID
		MLookup lookupCharge = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.TableDir);
		chargePick = new WTableDirEditor("C_Charge_ID", false, false, true, lookupCharge);
		chargePick.setValue(Integer.valueOf(m_C_Charge_ID));
		chargePick.addValueChangeListener(this);
		
	//  Charge
			AD_Column_ID = 212213;    //  C_AllocationLine.C_Charge_ID
			MLookup lookupDocType = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, AD_Column_ID, DisplayType.TableDir);
			DocTypePick = new WTableDirEditor("C_DocType_ID", false, false, true, lookupDocType);
			DocTypePick.setValue(Integer.valueOf(m_C_DocType_ID));
			DocTypePick.addValueChangeListener(this);
			
	}   //  dynInit
	
	protected void onClientInfo()
	{
		if (ClientInfo.isMobile() && form.getPage() != null) 
		{
			if (noOfColumn > 0 && parameterLayout.getRows() != null)
			{
				int t = 6;
				if (maxWidth(MEDIUM_WIDTH-1))
				{
					if (maxWidth(SMALL_WIDTH-1))
						t = 2;
					else
						t = 4;
				}
				if (t != noOfColumn)
				{
					parameterLayout.getRows().detach();
					if (parameterLayout.getColumns() != null)
						parameterLayout.getColumns().detach();
					if (mainLayout.getSouth() != null)
						mainLayout.getSouth().detach();
					if (allocationLayout.getRows() != null)
						allocationLayout.getRows().detach();
					layoutParameterAndSummary();
					form.invalidate();
				}
			}
		}
	}
	
	/**************************************************************************
	 *  Action Listener.
	 *  - MultiCurrency
	 *  - Allocate
	 *  @param e event
	 */
	public void onEvent(Event e)
	{
		log.config("");
		if (e.getTarget().equals(multiCurrency))
			loadBPartner();
		//	Allocate
		else if (e.getTarget().equals(allocateButton))
		{
			allocateButton.setEnabled(false);
			MAllocationHdr allocation = saveData();
			loadBPartner();
			allocateButton.setEnabled(true);
			if (allocation != null) 
			{
				DocumentLink link = new DocumentLink(Msg.getElement(Env.getCtx(), MAllocationHdr.COLUMNNAME_C_AllocationHdr_ID) + ": " + allocation.getDocumentNo(), allocation.get_Table_ID(), allocation.get_ID());				
				statusBar.appendChild(link);
			}					
		}
		else if (e.getTarget().equals(refreshButton))
		{
			loadBPartner();
		}
	}   //  actionPerformed

	/**
	 *  Table Model Listener.
	 *  - Recalculate Totals
	 *  @param e event
	 */
	public void tableChanged(WTableModelEvent e)
	{
		boolean isUpdate = (e.getType() == WTableModelEvent.CONTENTS_CHANGED);
		//  Not a table update
		if (!isUpdate)
		{
			calculate();
			return;
		}
		
		int row = e.getFirstRow();
		int col = e.getColumn();
	
		if (row < 0)
			return;
		
		boolean isInvoice = (e.getModel().equals(invoiceTable.getModel()));
		boolean isAutoWriteOff = autoWriteOff.isSelected();
		
		String msg = writeOff(row, col, isInvoice, paymentTable, invoiceTable, isAutoWriteOff);
		
		//render row
		ListModelTable model = isInvoice ? invoiceTable.getModel() : paymentTable.getModel(); 
		model.updateComponent(row);
	    
		if(msg != null && msg.length() > 0)
			FDialog.warn(form.getWindowNo(), "AllocationWriteOffWarn");
		
		calculate();
	}   //  tableChanged
	
	/**
	 *  Vetoable Change Listener.
	 *  - Business Partner
	 *  - Currency
	 * 	- Date
	 *  @param e event
	 */
	public void valueChange (ValueChangeEvent e)
	{
		String name = e.getPropertyName();
		Object value = e.getNewValue();
		if (log.isLoggable(Level.CONFIG)) log.config(name + "=" + value);
		if (value == null && (!name.equals("C_Charge_ID")||!name.equals("C_DocType_ID") ))
			return;
		
		// Organization
		if (name.equals("AD_Org_ID"))
		{
			m_AD_Org_ID = ((Integer) value).intValue();
			
			loadBPartner();
		}
		//		Charge
		else if (name.equals("C_Charge_ID") )
		{
			m_C_Charge_ID = value!=null? ((Integer) value).intValue() : 0;
			
			setAllocateButton();
		}

		else if (name.equals("C_DocType_ID") )
		{
			m_C_DocType_ID = value!=null? ((Integer) value).intValue() : 0;
			
		}

		//  BPartner
		if (name.equals("C_BPartner_ID"))
		{
			bpartnerSearch.setValue(value);
			m_C_BPartner_ID = ((Integer)value).intValue();
			loadBPartner();
		}
		//	Currency
		else if (name.equals("C_Currency_ID"))
		{
			m_C_Currency_ID = ((Integer)value).intValue();
			loadBPartner();
		}
		//	Date for Multi-Currency
		else if (name.equals("Date") && multiCurrency.isSelected())
			loadBPartner();
	}   //  vetoableChange
	
	private void setAllocateButton() {
			if (totalDiff.signum() == 0 ^ m_C_Charge_ID > 0 )
			{
				allocateButton.setEnabled(true);
			// chargePick.setValue(m_C_Charge_ID);
			}
			else
			{
				allocateButton.setEnabled(false);
			}

			if ( totalDiff.signum() == 0 )
			{
					chargePick.setValue(null);
					m_C_Charge_ID = 0;
	   		}
	}
	/**
	 *  Load Business Partner Info
	 *  - Payments
	 *  - Invoices
	 */
	private void loadBPartner ()
	{
		checkBPartner();
		
		Vector<Vector<Object>> data = getPaymentData(multiCurrency.isSelected(), dateField.getValue(), paymentTable);
		Vector<String> columnNames = getPaymentColumnNames(multiCurrency.isSelected());
		
		paymentTable.clear();
		
		//  Remove previous listeners
		paymentTable.getModel().removeTableModelListener(this);
		
		//  Set Model
		ListModelTable modelP = new ListModelTable(data);
		modelP.addTableModelListener(this);
		paymentTable.setData(modelP, columnNames);
		setPaymentColumnClass(paymentTable, multiCurrency.isSelected());
		//

		data = getInvoiceData(multiCurrency.isSelected(), dateField.getValue(), invoiceTable);
		columnNames = getInvoiceColumnNames(multiCurrency.isSelected());
		
		invoiceTable.clear();
		
		//  Remove previous listeners
		invoiceTable.getModel().removeTableModelListener(this);
		
		//  Set Model
		ListModelTable modelI = new ListModelTable(data);
		modelI.addTableModelListener(this);
		invoiceTable.setData(modelI, columnNames);
		setInvoiceColumnClass(invoiceTable, multiCurrency.isSelected());
		//
		
		calculate(multiCurrency.isSelected());
		
		//  Calculate Totals
		calculate();
		
		statusBar.getChildren().clear();
	}   //  loadBPartner
	
	public void calculate()
	{
		allocDate = null;
		
		paymentInfo.setText(calculatePayment(paymentTable, multiCurrency.isSelected()));
		invoiceInfo.setText(calculateInvoice(invoiceTable, multiCurrency.isSelected()));

		//	Set AllocationDate
		if (allocDate != null) {
			if (! allocDate.equals(dateField.getValue())) {
                Clients.showNotification(Msg.getMsg(Env.getCtx(), "AllocationDateUpdated"), Clients.NOTIFICATION_TYPE_INFO, dateField.getComponent(), "start_before", -1, false);       
                dateField.setValue(allocDate);
			}
		}

		//  Set Allocation Currency
		allocCurrencyLabel.setText(currencyPick.getDisplay());
		//  Difference
		totalDiff = totalPay.subtract(totalInv);
		differenceField.setText(format.format(totalDiff));		

		setAllocateButton();
	}
	
	/**************************************************************************
	 *  Save Data
	 */
	private MAllocationHdr saveData()
	{
		if (m_AD_Org_ID > 0)
			Env.setContext(Env.getCtx(), form.getWindowNo(), "AD_Org_ID", m_AD_Org_ID);
		else
			Env.setContext(Env.getCtx(), form.getWindowNo(), "AD_Org_ID", "");
		try
		{
			final MAllocationHdr[] allocation = new MAllocationHdr[1];
			Trx.run(new TrxRunnable() 
			{
				public void run(String trxName)
				{
					statusBar.getChildren().clear();
					allocation[0] = saveData(form.getWindowNo(), dateField.getValue(), paymentTable, invoiceTable, trxName);
					
				}
			});
			
			return allocation[0];
		}
		catch (Exception e)
		{
			FDialog.error(form.getWindowNo(), form, "Error", e.getLocalizedMessage());
			return null;
		}
	}   //  saveData
	
	/**
	 * Called by org.adempiere.webui.panel.ADForm.openForm(int)
	 * @return
	 */
	public ADForm getForm()
	{
		return form;
	}
}   //  VAllocation
