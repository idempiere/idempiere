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

package org.adempiere.webui.apps.form;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MProductBOM;
import org.compiere.model.MProject;
import org.compiere.model.MProjectLine;
import org.compiere.model.MRole;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Decimalbox;
import org.zkoss.zul.Div;
import org.zkoss.zul.Groupbox;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Layout;
import org.zkoss.zul.Radio;
import org.zkoss.zul.Radiogroup;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;



public class WBOMDrop extends ADForm implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8864346687201400591L;

	/**	Product to create BOMs from	*/
	private MProduct m_product;
	
	/** BOM Qty						*/
	private BigDecimal m_qty = Env.ONE;
	
	/**	Line Counter				*/
	@SuppressWarnings("unused")
	private int m_bomLine = 0;
	
	/**	Logger			*/
	private static final CLogger log = CLogger.getCLogger(WBOMDrop.class);
	
	/**	List of all selectors		*/
	private ArrayList<org.zkoss.zul.Checkbox> m_selectionList = new ArrayList<org.zkoss.zul.Checkbox>();
	
	/**	List of all quantities		*/
	private ArrayList<Decimalbox> m_qtyList = new ArrayList<Decimalbox>();
	
	/**	List of all products		*/
	private ArrayList<Integer> m_productList = new ArrayList<Integer>();
	
	/** list child panel of each checkbox */
	private ArrayList<Layout> m_childPanelList = new ArrayList<Layout>();

	/** list panel container checkbox and child panel*/
	private ArrayList<Layout> m_containPanel = new ArrayList<Layout>();
	
	/** Alternative Group Lists		*/
	private HashMap<String, Radiogroup> m_buttonGroups = new HashMap<String,Radiogroup>();

	//private static final int WINDOW_WIDTH = 600;	//	width of the window
	
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	private Grid selectionPanel = GridFactory.newGridLayout();
	private Listbox productField = new Listbox();
	private Decimalbox productQty = new Decimalbox();
	private Listbox orderField = new Listbox();
	private Listbox invoiceField = new Listbox();
	private Listbox projectField = new Listbox();
	
	private Groupbox grpSelectionPanel = new Groupbox();
	
	private Groupbox grpSelectProd = new Groupbox();
	private int indend = 20;
	public WBOMDrop()
	{}
	
	/**
	 *	Initialize Panel
	 *  @param WindowNo window
	 *  @param frame parent frame
	 */
	protected void initForm()
	{
		log.info("");

		try
		{
			confirmPanel = new ConfirmPanel(true);
			 
			//	Top Selection Panel
			createSelectionPanel(true, true, true);

			//	Center
			createMainPanel();

			confirmPanel.addActionListener(Events.ON_CLICK, this);
			
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		//sizeIt();
	}	//	init

	/**
	 * 	Dispose
	 */
	public void dispose()
	{
		if (selectionPanel != null)
			selectionPanel.getChildren().clear();
		
		selectionPanel = null;
		
		if (m_selectionList != null)
			m_selectionList.clear();
		
		m_selectionList = null;
		
		if (m_productList != null)
			m_productList.clear();
		
		m_productList = null;
		
		if (m_qtyList != null)
			m_qtyList.clear();
		
		m_qtyList = null;
		
		if (m_childPanelList  != null) {
			m_childPanelList.clear();
		}

		m_childPanelList = null;

		if (m_containPanel  != null) {
			m_containPanel.clear();
		}

		m_containPanel = null;

		if (m_buttonGroups != null)
			m_buttonGroups.clear();
		m_buttonGroups = null;
	}	//	dispose
	
	/**************************************************************************
	 * 	Create Selection Panel
	 *	@param order
	 *	@param invoice
	 *	@param project
	 */
	
	private void createSelectionPanel (boolean order, boolean invoice, boolean project)
	{
		Caption caption = new Caption(Msg.translate(Env.getCtx(), "Selection"));

//		grpSelectionPanel.setWidth("100%");
		grpSelectionPanel.appendChild(caption);
		grpSelectionPanel.appendChild(selectionPanel);
		
		productField.setRows(1);
		productField.setMold("select");
		
		KeyNamePair[] keyNamePair = getProducts();
		
		for (int i = 0; i < keyNamePair.length; i++)
		{
			productField.addItem(keyNamePair[i]);
		}
		
		Rows rows = selectionPanel.newRows();
		Row boxProductQty = rows.newRow();
		
		Label lblProduct = new Label(Msg.translate(Env.getCtx(), "M_Product_ID"));
		Label lblQty = new Label(Msg.translate(Env.getCtx(), "Qty"));
		productQty.setValue(Env.ONE);
		productField.addEventListener(Events.ON_SELECT, this);
		productQty.addEventListener(Events.ON_CHANGE, this);
		
		ZKUpdateUtil.setWidth(productField, "99%");
		boxProductQty.appendChild(lblProduct.rightAlign());
		boxProductQty.appendChild(productField);
		boxProductQty.appendChild(lblQty.rightAlign());
		boxProductQty.appendChild(productQty);
		
		if (order)
		{
			keyNamePair = getOrders();
			
			orderField.setRows(1);
			orderField.setMold("select");
			ZKUpdateUtil.setWidth(orderField, "99%");
			
			for (int i = 0; i < keyNamePair.length; i++)
			{
				orderField.addItem(keyNamePair[i]);
			}

			Label lblOrder = new Label(Msg.translate(Env.getCtx(), "C_Order_ID"));

			Row boxOrder = rows.newRow();
			
			orderField.addEventListener(Events.ON_CLICK, this);
			
			boxOrder.appendChild(lblOrder.rightAlign());
			boxOrder.appendChild(orderField);
			boxOrder.appendChild(new Space());
			boxOrder.appendChild(new Space());
		}

		if (invoice)
		{
			invoiceField.setRows(1);
			invoiceField.setMold("select");
			ZKUpdateUtil.setWidth(invoiceField, "99%");
			
			keyNamePair = getInvoices();
			
			for (int i = 0; i < keyNamePair.length; i++)
			{
				invoiceField.addItem(keyNamePair[i]);
			}
			
			Label lblInvoice = new Label(Msg.translate(Env.getCtx(), "C_Invoice_ID"));
			
			Row boxInvoices = rows.newRow();
			
			invoiceField.addEventListener(Events.ON_SELECT, this);
			
			boxInvoices.appendChild(lblInvoice.rightAlign());
			boxInvoices.appendChild(invoiceField);
			boxInvoices.appendChild(new Space());
			boxInvoices.appendChild(new Space());
		}
		
		if (project)
		{
			projectField.setRows(1);
			projectField.setMold("select");
			ZKUpdateUtil.setWidth(projectField, "99%");
			
			keyNamePair = getProjects();
			
			for (int i = 0; i < keyNamePair.length; i++)
			{
				projectField.addItem(keyNamePair[i]);
			}
			
			Label lblProject = new Label(Msg.translate(Env.getCtx(), "C_Project_ID"));
			
			Row boxProject = rows.newRow();
			
			projectField.addEventListener(Events.ON_SELECT, this);
			
			boxProject.appendChild(lblProject.rightAlign());
			boxProject.appendChild(projectField);
			boxProject.appendChild(new Space());
			boxProject.appendChild(new Space());			
		}
		
		//	Enabled in ActionPerformed
		confirmPanel.setEnabled("Ok", false);
	}	//	createSelectionPanel

	/**
	 * 	Get Array of BOM Products
	 *	@return products
	 */
	
	private KeyNamePair[] getProducts()
	{
		String sql = "SELECT M_Product_ID, Name "
			+ "FROM M_Product "
			+ "WHERE IsBOM='Y' AND IsVerified='Y' AND IsActive='Y' "
			+ "ORDER BY Name";
	
		return DB.getKeyNamePairs(MRole.getDefault().addAccessSQL(
			sql, "M_Product", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO), true);
	}	//	getProducts
	
	/**
	 * 	Get Array of open Orders
	 *	@return orders
	 */
	
	private KeyNamePair[] getOrders()
	{
		String sql = "SELECT C_Order_ID, DocumentNo || '_' || GrandTotal "
			+ "FROM C_Order "
			+ "WHERE Processed='N' AND DocStatus='DR' "
			+ "ORDER BY DocumentNo";
	
		return DB.getKeyNamePairs(MRole.getDefault().addAccessSQL(
			sql, "C_Order", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO), true);
	}	//	getOrders

	/**
	 * 	Get Array of open non service Projects
	 *	@return orders
	 */
	
	private KeyNamePair[] getProjects()
	{
		String sql = "SELECT C_Project_ID, Name "
			+ "FROM C_Project "
			+ "WHERE Processed='N' AND IsSummary='N' AND IsActive='Y'"
			+ " AND ProjectCategory<>'S' "
			+ "ORDER BY Name";
	
		return DB.getKeyNamePairs(MRole.getDefault().addAccessSQL(
			sql, "C_Project", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO), true);
	}	//	getProjects
	
	/**
	 * 	Get Array of open Invoices
	 *	@return invoices
	 */
	
	private KeyNamePair[] getInvoices()
	{
		String sql = "SELECT C_Invoice_ID, DocumentNo || '_' || GrandTotal "
			+ "FROM C_Invoice "
			+ "WHERE Processed='N' AND DocStatus='DR' "
			+ "ORDER BY DocumentNo";
	
		return DB.getKeyNamePairs(MRole.getDefault().addAccessSQL(
			sql, "C_Invoice", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO), true);
	}	//	getInvoices

	/**************************************************************************
	 * 	Create Main Panel.
	 * 	Called when changing Product
	 */
	
	private void createMainPanel ()
	{
		if (log.isLoggable(Level.CONFIG)) log.config(": " + m_product);
		this.getChildren().clear();
		//this.invalidate();
		//this.setBorder(null);
		
		m_selectionList.clear();
		m_productList.clear();
		m_qtyList.clear();
		m_buttonGroups.clear();
		m_childPanelList.clear();
		m_containPanel.clear();
		
		this.appendChild(new Separator());
		this.appendChild(grpSelectionPanel);
		this.appendChild(new Separator());
		this.appendChild(grpSelectProd);
		this.appendChild(new Separator());
		this.appendChild(confirmPanel);
		this.appendChild(new Separator());
		this.setBorder("normal");
		this.setContentStyle("overflow: auto");
		
		Caption title = new Caption(Msg.getMsg(Env.getCtx(), "SelectProduct"));

		grpSelectProd.getChildren().clear();
		grpSelectProd.appendChild(title);
		
		if (m_product != null && m_product.get_ID() > 0)
		{
			title.setLabel(m_product.getName());
			
			if (m_product.getDescription() != null && m_product.getDescription().length() > 0)
				;//this.setsetToolTipText(m_product.getDescription());
			
			m_bomLine = 0;
			maxBomDeep = getDeepBom (m_product, 0);
			addBOMLines(m_product, m_qty, grpSelectProd, 0);
			updateBomList();
		}
	}	//	createMainPanel

	private int maxBomDeep = 0;
	
	private int getDeepBom (MProduct product, int curentBomDeep) {
		int bomDeep = curentBomDeep;
		if (product.isBOM()) {
			MProductBOM[] bomLines = MProductBOM.getBOMLines(product);
			for (MProductBOM bomLine : bomLines) {
				int testBomDeep = getDeepBom(bomLine.getProduct(), curentBomDeep + 1);
				if (testBomDeep > bomDeep) {
					bomDeep = testBomDeep;
				}
			}
		}
		return bomDeep;
	}

	/**
	 * 	Add BOM Lines to this.
	 * 	Called recursively
	 * 	@param product product
	 * 	@param qty quantity
	 */
	
	private void addBOMLines (MProduct product, BigDecimal qty, Component parentPanel, int bomLevel)
	{
		MProductBOM[] bomLines = MProductBOM.getBOMLines(product);
		//sort, gourp alter product with together
		Arrays.sort(bomLines, new Comparator<MProductBOM>() {
			@Override
			public int compare(MProductBOM arg0, MProductBOM arg1) {
				return arg0.getBOMType().compareTo(arg1.getBOMType());
			}
		});

	        // 2nd sort by Line Number in order to correspond with BOM Structure, patch 2015-03-31
	        Arrays.sort(bomLines, new Comparator<MProductBOM>() {
	                @Override
	                public int compare(MProductBOM arg0, MProductBOM arg1) {
	                        String t1 = String.valueOf(arg0.getLine()+100000);
	                        String t2 = String.valueOf(arg1.getLine()+100000);
	                        return t1.compareTo(t2);
	                		}
			});
			
		
		for (int i = 0; i < bomLines.length; i++)
		{
			addBOMLine (bomLines[i], qty, parentPanel, bomLevel);
		}
		
		if (log.isLoggable(Level.FINE)) log.fine("#" + bomLines.length);
	}	//	addBOMLines

	/**
	 * 	Add BOM Line to this.
	 * 	Calls addBOMLines if added product is a BOM
	 * 	@param line BOM Line
	 * 	@param qty quantity
	 */
	
	private void addBOMLine (MProductBOM line, BigDecimal qty, Component parentPanel, int bomLevel)
	{
		if (log.isLoggable(Level.FINE)) log.fine(line.toString());
		String bomType = line.getBOMType();
		
		if (bomType == null)
			bomType = MProductBOM.BOMTYPE_StandardPart;
		//
		BigDecimal lineQty = line.getBOMQty().multiply(qty);
		MProduct product = line.getProduct();
		
		if (product == null)
			return;
		
		Layout producPanel = addDisplay (line.getM_Product_ID(),
					product.getM_Product_ID(), bomType, product.getName(), lineQty, parentPanel, bomLevel);
		m_containPanel.add(producPanel);
		
		if (product.isBOM() && product.isVerified()) {
			Vlayout childPanel = createVlayoutPanel("100%");
			m_childPanelList.add(childPanel);
			producPanel.appendChild(childPanel); 
			addBOMLines (product, lineQty, childPanel, bomLevel + 1);		//	recursive

		} else {
			m_childPanelList.add(null);
		}
			
	}	//	addBOMLine

	/**
	 * 	Add Line to Display
	 *	@param parentM_Product_ID parent product
	 *	@param M_Product_ID product
	 *	@param bomType bom type
	 *	@param name name
	 *	@param lineQty qty
	 */
	
	private Layout addDisplay (int parentM_Product_ID,
		int M_Product_ID, String bomType, String name, BigDecimal lineQty, Component parentPanel, int bomLevel)
	{
		if (log.isLoggable(Level.FINE)) log.fine("M_Product_ID=" + M_Product_ID + ",Type=" + bomType + ",Name=" + name + ",Qty=" + lineQty);
		
		boolean selected = false;

		//Container info of product (checkBox or radio box,product name, qty input)
		Layout productPanel = null;
		productPanel = createHlayoutPanel("100%");
		
		//Container productPanel because, this container will contain child of this product by vertical
		Layout outerProductPanel = new Vlayout();
		outerProductPanel.appendChild(productPanel);

		// checkbox or radio button for select product
		Div selectPanel = createDivPanel(25);
		org.zkoss.zul.Checkbox rd = null;
		boolean isStandard = MProductBOM.BOMTYPE_StandardPart.equals(bomType);
		
		if (MProductBOM.BOMTYPE_StandardPart.equals(bomType) || MProductBOM.BOMTYPE_OptionalPart.equals(bomType))
		{
			rd = new Checkbox();
			rd.setChecked(isStandard);
			rd.setDisabled(isStandard);
			selected = isStandard;
		} else {	//	Alternative
			rd = new Radio();
		}
		selectPanel.appendChild(rd);
		m_selectionList.add(rd);
		productPanel.appendChild(selectPanel);
		if (!isStandard)
			rd.addEventListener(Events.ON_CHECK, this);

		Div rightInden = createDivPanel((maxBomDeep - bomLevel) * indend);
		productPanel.appendChild(rightInden);

		//	Add to List
		m_productList.add (Integer.valueOf(M_Product_ID));

		// add product name
		selectPanel = createDivPanel(200);
		Label label = new Label(name);
		HtmlBasedComponent c = (HtmlBasedComponent) label.rightAlign();
		c.setStyle(c.getStyle() + ";margin-right: 5px");
		selectPanel.appendChild(c);
		productPanel.appendChild(selectPanel);

		// qty input control
		selectPanel = createDivPanel(200);
		Decimalbox qty = new Decimalbox();
		qty.setValue(lineQty);
		selectPanel.appendChild(qty);
		productPanel.appendChild(selectPanel);
		m_qtyList.add(qty);

		// outer container for indent contain index box and product panel
		Layout outerContainer = createHlayoutPanel("100%");
		parentPanel.appendChild(outerContainer);

		if (!parentPanel.equals(grpSelectProd)) {
			// indent 
			Div cellInden = createDivPanel(indend);
			outerContainer.appendChild(cellInden);
		}

		// add product panel to parent, with radio, add to radio group
		if (MProductBOM.BOMTYPE_StandardPart.equals(bomType) || MProductBOM.BOMTYPE_OptionalPart.equals(bomType)) {
			outerContainer.appendChild(outerProductPanel);
		} else {
			// String groupName = String.valueOf(parentM_Product_ID) + "_" + bomType;
			String groupName = String.valueOf(parentM_Product_ID) + "_" + bomType + "_" +  parentPanel.toString();	
			Radiogroup group = m_buttonGroups.get(groupName);
			
			if (group == null) {
				if (log.isLoggable(Level.FINE)) log.fine("ButtonGroup=" + groupName);
				group = new Radiogroup();
				m_buttonGroups.put(groupName, group);
				rd.setChecked(true);
				selected = true;

				outerContainer.appendChild(group);
			}
			group.appendChild(outerProductPanel);
		}
		
		qty.setReadonly(!selected);
		return outerProductPanel;
	}	//	addDisplay

	private Div createDivPanel (int with) {
		Div divPanel = new Div ();
		ZKUpdateUtil.setWidth(divPanel, String.format("%1$spx", with));
		divPanel.setStyle("padding-right:0;padding-left:0");
		return divPanel; 
	}

	private Hlayout createHlayoutPanel (String width) {
		Hlayout layout = new Hlayout();
		layout.setSpacing("0");
		ZKUpdateUtil.setWidth(layout, width);
		return layout;
	}

	private Vlayout createVlayoutPanel (String width) {
		Vlayout layout = new Vlayout();
		layout.setSpacing("0");
		ZKUpdateUtil.setWidth(layout, width);
		return layout;
	}

	/**************************************************************************
	 *	Action Listener
	 *  @param e event
	 */
	public void onEvent (Event e) throws Exception
	{
		if (log.isLoggable(Level.CONFIG)) log.config(e.getName());
		
		Object source = e.getTarget();

		//	Toggle Qty Enabled
		if (source instanceof org.zkoss.zul.Checkbox)
		{
			org.zkoss.zul.Checkbox chbSource = (org.zkoss.zul.Checkbox)source;
			// set enable or disable qty input of this source
			int index = m_selectionList.indexOf(chbSource);
			m_qtyList.get(index).setReadonly(!chbSource.isChecked());

			// disable qty of other radio in group
			if (chbSource instanceof Radio) {
				// find Button Group
				Radiogroup group = ((Radio)chbSource).getRadiogroup();
				List<Radio> lsRadio = group.getItems();
				
				for (Radio testRadio : lsRadio) {
					if (!chbSource.equals(testRadio)) {						
						// fix unknow error. at fisrt event, prev radio checkbox also is checked
						testRadio.setChecked(false);
						// set qty input of uncheck radio button
						index = m_selectionList.indexOf(testRadio);
						m_qtyList.get(index).setReadonly(true);
					}
				}
			}
			
			updateBomList();
		}	//	JCheckBox or JRadioButton
		//	Product / Qty
		else if (source == productField || source == productQty)
		{
			m_qty = productQty.getValue();
			
			ListItem listitem = productField.getSelectedItem();
			
			KeyNamePair pp = null;
			
			if (listitem != null)
				pp = listitem.toKeyNamePair();
			
			m_product = pp!= null ? MProduct.get (Env.getCtx(), pp.getKey()) : null;
			createMainPanel();
			//sizeIt();
		}
		
		//	Order
		else if (source == orderField)
		{
			ListItem listitem = orderField.getSelectedItem();
			
			KeyNamePair pp = null;
			
			if (listitem != null)
				pp = listitem.toKeyNamePair();
			
			boolean valid = (pp != null && pp.getKey() > 0);
			
			if (invoiceField != null)
				invoiceField.setEnabled(!valid);
			if (projectField != null)
				projectField.setEnabled(!valid);
		}
		//	Invoice
		else if (source == invoiceField)
		{
			ListItem listitem = invoiceField.getSelectedItem();
			
			KeyNamePair pp = null;
						
			if (listitem != null)
				pp = listitem.toKeyNamePair();
			
			boolean valid = (pp != null && pp.getKey() > 0);
			
			if (orderField != null)
				orderField.setEnabled(!valid);
			if (projectField != null)
				projectField.setEnabled(!valid);
		}
		//	Project
		else if (source == projectField)
		{
			ListItem listitem = projectField.getSelectedItem();
			
			KeyNamePair pp = null;
			
			if (listitem != null)
				pp = listitem.toKeyNamePair();
			
			boolean valid = (pp != null && pp.getKey() > 0);
			//
			if (orderField != null)
				orderField.setEnabled(!valid);
			if (invoiceField != null)
				invoiceField.setEnabled(!valid);
		}
		//	OK
		else if (confirmPanel.getButton("Ok").equals(e.getTarget()))
		{
			if (onSave()){
				SessionManager.getAppDesktop().closeActiveWindow();
			}	
		}
		else if (confirmPanel.getButton("Cancel").equals(e.getTarget())){
			SessionManager.getAppDesktop().closeActiveWindow();
		}else
		{
			super.onEvent(e);
		}
			
		//	Enable OK
		boolean OK = m_product != null;
		
		if (OK)
		{
			KeyNamePair pp = null;
			
			if (orderField != null)
			{
				ListItem listitem = orderField.getSelectedItem();
				
				if (listitem != null)
					pp = listitem.toKeyNamePair();
			}
			
			if ((pp == null || pp.getKey() <= 0) && invoiceField != null)
			{
				ListItem listitem = invoiceField.getSelectedItem();
				
				if (listitem != null)
					pp = listitem.toKeyNamePair();
			}
			
			if ((pp == null || pp.getKey() <= 0) && projectField != null)
			{
				ListItem listitem = projectField.getSelectedItem();
				
				if (listitem != null)
					pp = listitem.toKeyNamePair();
			}
			OK = (pp != null && pp.getKey() > 0);
		}
		
		confirmPanel.setEnabled("Ok", OK);
	}	//	actionPerformed

	/**
	 * update display of bom tree
	 * for item is not selected, hidden child of it.
	 */
	protected void updateBomList() {
		int index = 0;
		for(org.zkoss.zul.Checkbox chbSource : m_selectionList) {
			index = m_selectionList.indexOf(chbSource);
			Layout childPanel = m_childPanelList.get(index);
			Layout containPanel = m_containPanel.get(index);

			if (childPanel != null && chbSource.isChecked() && !containPanel.getChildren().contains(childPanel)) {
				containPanel.appendChild(childPanel);
			} else if (childPanel != null && !chbSource.isChecked() && containPanel.getChildren().contains(childPanel)) {
				childPanel.detach();
			}
		}
		// add or remove child panel of selected radio		
	}
	
	private List <org.zkoss.zul.Checkbox> displayList = new ArrayList <org.zkoss.zul.Checkbox>();
	/**
	 * return list of checkbox is display
	 * @return
	 */
	private List <org.zkoss.zul.Checkbox> getDisplayList () {
		displayList.clear();
		for(org.zkoss.zul.Checkbox chbSource : m_selectionList) {
			if (chbSource.getPage() != null) {
				displayList.add(chbSource);
			}
		}
		return displayList;
	}

	/**
	 * 	Enable/disable qty based on selection
	 *	@param source JCheckBox or JRadioButton
	 */
		

	private boolean onSave()
	{
		String trxName = Trx.createTrxName("BDP");	
		Trx localTrx = Trx.get(trxName, true);	//trx needs to be committed too
		localTrx.setDisplayName(getClass().getName()+"_onSave");
		try
		{
			if (cmd_save(localTrx)) 
			{
				localTrx.commit();
				return true;
			}
			else
			{
				localTrx.rollback();
				return false;
			}
			
		}
		finally 
		{
			localTrx.close();
		}
	}
	
	/**************************************************************************
	 * 	Save Selection
	 *  @param trx
	 * 	@return true if saved
	 */
	
	private boolean cmd_save(Trx trx)
	{
		ListItem listitem = orderField.getSelectedItem();
		
		KeyNamePair pp = null;
		
		if (listitem != null)
			pp = listitem.toKeyNamePair();
		
		if (pp != null && pp.getKey() > 0)
			return cmd_saveOrder (pp.getKey(), trx);
		
		listitem = invoiceField.getSelectedItem();
		
		pp = null;
		
		if (listitem != null)
			pp = listitem.toKeyNamePair();
		
		if (pp != null && pp.getKey() > 0)
			return cmd_saveInvoice (pp.getKey(), trx);
		
		listitem = projectField.getSelectedItem();
		
		pp = null;
		
		if (listitem != null)
			pp = listitem.toKeyNamePair();
		
		if (pp != null && pp.getKey() > 0)
			return cmd_saveProject (pp.getKey(), trx);
		
		log.log(Level.SEVERE, "Nothing selected");
		return false;
	}	//	cmd_save

	/**
	 * 	Save to Order
	 *	@param C_Order_ID id
	 *  @param trx 
	 *	@return true if saved
	 */
	
	private boolean cmd_saveOrder (int C_Order_ID, Trx trx)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_Order_ID=" + C_Order_ID);
		MOrder order = new MOrder (Env.getCtx(), C_Order_ID, trx != null ? trx.getTrxName() : null);
		
		if (order.get_ID() == 0)
		{
			log.log(Level.SEVERE, "Not found - C_Order_ID=" + C_Order_ID);
			return false;
		}
		
		int lineCount = 0;
		try 
		{
			//for all display bom lines
			List<org.zkoss.zul.Checkbox> displayList = getDisplayList ();
			for (org.zkoss.zul.Checkbox displayChb : displayList) 
			{
				int i = m_selectionList.indexOf(displayChb);
				if (m_selectionList.get(i).isChecked()) 
				{
					BigDecimal qty = m_qtyList.get(i).getValue();
					int M_Product_ID = m_productList.get(i).intValue();
					// Create Line
					MOrderLine ol = new MOrderLine(order);
					ol.setM_Product_ID(M_Product_ID, true);
					ol.setQty(qty);
					ol.setPrice();
					ol.setTax();
					ol.saveEx();
					lineCount++;

				} // line selected
			} // for all bom lines
		} catch (Exception e) 
		{
			log.log(Level.SEVERE, "Line not saved");
			if (trx != null) 
			{
				trx.rollback();
			}
			throw new AdempiereException(e.getMessage());
		}				
		
		FDialog.info(-1, this, Msg.translate(Env.getCtx(), "C_Order_ID")+ " : " + order.getDocumentInfo() + " , " + Msg.translate(Env.getCtx(), "NoOfLines") + " " + Msg.translate(Env.getCtx(), "Inserted") + " = " + lineCount);
		if (log.isLoggable(Level.CONFIG)) log.config("#" + lineCount);
		return true;
	}	//	cmd_saveOrder

	/**
	 * 	Save to Invoice
	 *	@param C_Invoice_ID id
	 *  @param trx 
	 *	@return true if saved
	 */
	
	private boolean cmd_saveInvoice (int C_Invoice_ID, Trx trx)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_Invoice_ID=" + C_Invoice_ID);
		MInvoice invoice = new MInvoice (Env.getCtx(), C_Invoice_ID, trx != null ? trx.getTrxName() : null);
		if (invoice.get_ID() == 0)
		{
			log.log(Level.SEVERE, "Not found - C_Invoice_ID=" + C_Invoice_ID);
			return false;
		}
		int lineCount = 0;
		
		//	for all bom lines
		try 
		{
			List<org.zkoss.zul.Checkbox> displayList = getDisplayList ();
			for (org.zkoss.zul.Checkbox displayChb : displayList) 
			{
				int i = m_selectionList.indexOf(displayChb);
				if (m_selectionList.get(i).isChecked())
				{
					BigDecimal qty = m_qtyList.get(i).getValue();
					int M_Product_ID = m_productList.get(i).intValue();
					//	Create Line
					MInvoiceLine il = new MInvoiceLine (invoice);
					il.setM_Product_ID(M_Product_ID, true);
					il.setQty(qty);
					il.setPrice();
					il.setTax();
					il.saveEx();
					lineCount++;
				}	//	line selected
			}	//	for all bom lines
		} catch (Exception e) 
		{
			log.log(Level.SEVERE, "Line not saved");
			if (trx != null) 
			{
				trx.rollback();
			}
			throw new AdempiereException(e.getMessage());
		}		
		
		FDialog.info(-1, this, Msg.translate(Env.getCtx(), "C_Invoice_ID")+ " : " + invoice.getDocumentInfo() +  " , " + Msg.translate(Env.getCtx(), "NoOfLines") + " " + Msg.translate(Env.getCtx(), "Inserted") + " = " + lineCount);
		if (log.isLoggable(Level.CONFIG)) log.config("#" + lineCount);
		return true;
	}	//	cmd_saveInvoice

	/**
	 * 	Save to Project
	 *	@param C_Project_ID id
	 *  @param trx
	 *	@return true if saved
	 */
	private boolean cmd_saveProject (int C_Project_ID, Trx trx)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_Project_ID=" + C_Project_ID);
		MProject project = new MProject (Env.getCtx(), C_Project_ID, trx != null ? trx.getTrxName() : null);
		if (project.get_ID() == 0)
		{
			log.log(Level.SEVERE, "Not found - C_Project_ID=" + C_Project_ID);
			return false;
		}
		int lineCount = 0;
		
		//	for all bom lines
		try 
		{
			List<org.zkoss.zul.Checkbox> displayList = getDisplayList ();
			for (org.zkoss.zul.Checkbox displayChb : displayList)
			{
				int i = m_selectionList.indexOf(displayChb);
				if (m_selectionList.get(i).isChecked())
				{
					BigDecimal qty = m_qtyList.get(i).getValue();
					int M_Product_ID = m_productList.get(i).intValue();
					//	Create Line
					MProjectLine pl = new MProjectLine (project);
					pl.setM_Product_ID(M_Product_ID);
					pl.setPlannedQty(qty);
					pl.saveEx();
					lineCount++;
				}	//	line selected
			}	//	for all bom lines
		} catch (Exception e) 
		{
			log.log(Level.SEVERE, "Line not saved");
			if (trx != null) 
			{
				trx.rollback();
			}
			throw new AdempiereException(e.getMessage());
		}		
		
		FDialog.info(-1, this, Msg.translate(Env.getCtx(), "C_Project_ID")+ " : " + project.getName() + " , " + Msg.translate(Env.getCtx(), "NoOfLines") + " " + Msg.translate(Env.getCtx(), "Inserted") + " = " + lineCount);
		if (log.isLoggable(Level.CONFIG)) log.config("#" + lineCount);
		return true;
	}	//	cmd_saveProject
}
