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
import java.util.logging.Level;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.panel.IFormController;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.apps.form.InOutGen;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MOrder;
import org.compiere.model.MRMA;
import org.compiere.process.DocAction;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.North;

/**
 * Generate Shipment (manual) view class
 *
 */
public class WInOutGen extends InOutGen implements IFormController, EventListener<Event>, ValueChangeListener
{
	private WGenForm form;

	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WInOutGen.class);
	//
	private Label lWarehouse = new Label();
	private WTableDirEditor fWarehouse;
	private Label lBPartner = new Label();
	private WSearchEditor fBPartner;
	private Label     lDocType = new Label();
	private Listbox  cmbDocType = ListboxFactory.newDropdownListbox();
	private Label   lDocAction = new Label();
	private WTableDirEditor docAction;

	private int noOfColumn;

	public WInOutGen()
	{
		log.info("");

		form = new WGenForm(this);
		Env.setContext(Env.getCtx(), form.getWindowNo(), "IsSOTrx", "Y");

		try
		{
			super.dynInit();
			dynInit();
			zkInit();

			form.postQueryEvent();
		}
		catch(Exception ex)
		{
			log.log(Level.SEVERE, "init", ex);
		}
		
		ClientInfo.onClientInfo(form, this::onClientInfo);
	}	//	init

	/**
	 *	Static Init.
	 *  <pre>
	 *  selPanel (tabbed)
	 *      fOrg, fBPartner
	 *      scrollPane & miniTable
	 *  genPanel
	 *      info
	 *  </pre>
	 *  @throws Exception
	 */
	void zkInit() throws Exception
	{
		setupColumns();
			
		lBPartner.setText(Msg.translate(Env.getCtx(), "C_BPartner_ID"));

		Row row = form.getParameterPanel().newRows().newRow();
		row.appendCellChild(lWarehouse.rightAlign());
		ZKUpdateUtil.setHflex(fWarehouse.getComponent(), "true");
		row.appendCellChild(fWarehouse.getComponent());
		row.appendCellChild(lBPartner.rightAlign());
		ZKUpdateUtil.setHflex(fBPartner.getComponent(), "true");
		row.appendCellChild(fBPartner.getComponent());		

		row = new Row();
		form.getParameterPanel().getRows().appendChild(row);
		row.appendCellChild(lDocType.rightAlign());
		ZKUpdateUtil.setHflex(cmbDocType, "true");
		row.appendCellChild(cmbDocType);
		row.appendCellChild(lDocAction.rightAlign());
		ZKUpdateUtil.setHflex(docAction.getComponent(), "true");		
		row.appendCellChild(docAction.getComponent());
		if (noOfColumn < 6)
			LayoutUtils.compactTo(form.getParameterPanel(), noOfColumn);
		else
			LayoutUtils.expandTo(form.getParameterPanel(), noOfColumn, true);
	}	//	jbInit

	protected void setupColumns() {
		noOfColumn = 6;
		if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
		{
			if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
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
			form.getParameterPanel().appendChild(columns);
		}
	}

	/**
	 *	Fill Picks.
	 *		Column_ID from C_Order
	 *  @throws Exception if Lookups cannot be initialized
	 */
	public void dynInit() throws Exception
	{
		//	C_OrderLine.M_Warehouse_ID
		MLookup orgL = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, 11474 /* M_Requisition.M_Warehouse_ID */, DisplayType.TableDir);
		fWarehouse = new WTableDirEditor ("M_Warehouse_ID", true, false, true, orgL);
		lWarehouse.setText(Msg.translate(Env.getCtx(), "M_Warehouse_ID"));
		fWarehouse.addValueChangeListener(this);
		fWarehouse.setValue(Env.getContextAsInt(Env.getCtx(), Env.M_WAREHOUSE_ID));
		setM_Warehouse_ID(fWarehouse.getValue());
		//      Document Action Prepared/ Completed
		lDocAction.setText(Msg.translate(Env.getCtx(), "DocAction"));
		MLookup docActionL = MLookupFactory.get(Env.getCtx(), form.getWindowNo(), 4324 /* M_InOut.DocAction */,
				DisplayType.List, Env.getLanguage(Env.getCtx()), "DocAction", 135 /* _Document Action */,
				false, "AD_Ref_List.Value IN ('CO','PR','--')");
		docAction = new WTableDirEditor("DocAction", true, false, true,docActionL);
		docAction.setValue(DocAction.ACTION_Complete);
		// docAction.addValueChangeListener(this); // IDEMPIERE-768
		//	C_Order.C_BPartner_ID
		MLookup bpL = MLookupFactory.get (Env.getCtx(), form.getWindowNo(), 0, 2762, DisplayType.Search);
		fBPartner = new WSearchEditor("C_BPartner_ID", false, false, true, bpL);
		lBPartner.setText(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		fBPartner.addValueChangeListener(this);
		//Document Type Sales Order/Vendor RMA
		lDocType.setText(Msg.translate(Env.getCtx(), "C_DocType_ID"));
		cmbDocType.addItem(new KeyNamePair(MOrder.Table_ID, Msg.translate(Env.getCtx(), "Order")));
		cmbDocType.addItem(new KeyNamePair(MRMA.Table_ID, Msg.translate(Env.getCtx(), "VendorRMA")));
		cmbDocType.addActionListener(this);
		cmbDocType.setSelectedIndex(0);

		form.getStatusBar().setStatusLine(Msg.getMsg(Env.getCtx(), "InOutGenerateSel"));//@@
	}	//	fillPicks

	/**
	 *  Query Info
	 */
	public void executeQuery()
	{
		KeyNamePair docTypeKNPair = cmbDocType.getSelectedItem().toKeyNamePair();
		executeQuery(docTypeKNPair, form.getMiniTable());
		if (ClientInfo.maxHeight(ClientInfo.SMALL_HEIGHT-1))
		{
			Component comp = form.getParameterPanel().getParent();
			if (comp instanceof North)
				((North)comp).setOpen(false);
		}
		form.getMiniTable().repaint();
		form.invalidate();
	}   //  executeQuery

	protected void onClientInfo()
	{
		if (ClientInfo.isMobile() && form.getPage() != null) 
		{
			if (noOfColumn > 0 && form.getParameterPanel().getRows() != null)
			{
				int t = 6;
				if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
				{
					if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
						t = 2;
					else
						t = 4;
				}
				if (t != noOfColumn)
				{
					form.getParameterPanel().getRows().detach();
					if (form.getParameterPanel().getColumns() != null)
						form.getParameterPanel().getColumns().detach();
					try {
						zkInit();
						form.invalidate();
					} catch (Exception e1) {}
				}
			}
		}
	}
	
	/**
	 *	Action Listener
	 *  @param e event
	 */
	public void onEvent(Event e)
	{
		if (log.isLoggable(Level.INFO)) log.info("Cmd=" + e.getTarget().getId());
		//
		if(cmbDocType.equals(e.getTarget()))
		{
		    form.postQueryEvent();
		    return;
		}

		//
		validate();
	}	//	actionPerformed

	public void validate()
	{
		if (isSelectionActive() && getM_Warehouse_ID() <= 0)
		{
			throw new WrongValueException(fWarehouse.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));
		}
		String docActionSelected = (String)docAction.getValue();
		if ( docActionSelected==null || docActionSelected.isEmpty() )
			throw new WrongValueException(docAction.getComponent(), Msg.translate(Env.getCtx(), "FillMandatory"));

		form.saveSelection();

		ArrayList<Integer> selection = getSelection();
		if (selection != null
			&& selection.size() > 0
			&& isSelectionActive() )	//	on selection tab
		{
			form.generate();
		}
		else
		{
			form.dispose();
		}
	}

	/**
	 *	Value Change Listener - requery
	 *  @param e event
	 */
	public void valueChange(ValueChangeEvent e)
	{
		if (log.isLoggable(Level.INFO)) log.info(e.getPropertyName() + "=" + e.getNewValue());
		if (e.getPropertyName().equals("M_Warehouse_ID"))
			setM_Warehouse_ID(e.getNewValue());
		if (e.getPropertyName().equals("C_BPartner_ID"))
		{
			m_C_BPartner_ID = e.getNewValue();
			fBPartner.setValue(m_C_BPartner_ID);	//	display value
		}
		form.postQueryEvent();
	}	//	vetoableChange

	/**************************************************************************
	 *	Generate Shipments
	 */
	public String generate()
	{
		KeyNamePair docTypeKNPair = (KeyNamePair)cmbDocType.getSelectedItem().toKeyNamePair();
		String docActionSelected = (String)docAction.getValue();
		return generate(form.getStatusBar(), docTypeKNPair, docActionSelected);
	}	//	generateShipments

	public ADForm getForm()
	{
		return form;
	}
}