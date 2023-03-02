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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ProcessInfoDialog;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MColumn;
import org.compiere.model.MInvoice;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MOrder;
import org.compiere.model.MProduct;
import org.compiere.model.MProject;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.apps.form.BOMDrop;
import org.idempiere.apps.form.BOMDrop.BOMLine;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Center;
import org.zkoss.zul.Decimalbox;
import org.zkoss.zul.Div;
import org.zkoss.zul.Groupbox;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Layout;
import org.zkoss.zul.Radio;
import org.zkoss.zul.Radiogroup;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vlayout;

/**
 * Form to create order, invoice or project lines from BOM. 
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VBOMDrop")
public class WBOMDrop extends ADForm implements EventListener<Event>, ValueChangeListener
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -525234460800183807L;

	/** Groupbox attribute to store BOMLevel|Feature string */
	private static final String FEATURE_GROUP_KEY_ATTR = "FeatureGroupKey";

	/** Checkbox/Radio attribute to store ParentProductID_ChildProductID string */
	private static final String OPTION_PRODUCT_KEY_ATTR = "OptionProductKey";

	/**	BOM parent product	*/
	private MProduct m_product;
	
	/** BOM Qty */
	private BigDecimal m_qty = Env.ONE;
	
	/**	Logger */
	private static final CLogger log = CLogger.getCLogger(WBOMDrop.class);
	
	/**	List of selector/checkbox for each BOM line */
	private ArrayList<org.zkoss.zul.Checkbox> m_selectorList = new ArrayList<org.zkoss.zul.Checkbox>();
	
	/**	List of quantity for each BOM line */
	private ArrayList<Decimalbox> m_qtyList = new ArrayList<Decimalbox>();
	
	/**	List of product for each BOM line */
	private ArrayList<Integer> m_productList = new ArrayList<Integer>();
	
	/** list of child panel for each BOM line */
	private ArrayList<Layout> m_childPanelList = new ArrayList<Layout>();

	/** list of panel for each BOM line */
	private ArrayList<Layout> m_productPanelList = new ArrayList<Layout>();
	
	/** GroupKey:RadioGroup. Alternative Group Map */
	private HashMap<String, Radiogroup> m_alternativeGroups = new HashMap<String,Radiogroup>();

	/** Main layout */
	private Borderlayout borderLayout;
	
	/** Selection/parameters group box, north of {@link #borderLayout} */
	private Groupbox selectionGroupbox = new Groupbox();
	/** Grid layout of {@link #selectionGroupbox} */
	private Grid selectionPanel = GridFactory.newGridLayout();
	/** BOM parent product field of {@link #selectionPanel} */
	private WSearchEditor fieldProduct;
	/** Quantity field of {@link #selectionPanel} */
	private Decimalbox productQty = new Decimalbox();
	/** Order field of {@link #selectionPanel} */
	private Listbox orderField = new Listbox();
	/** Invoice field of {@link #selectionPanel} */
	private Listbox invoiceField = new Listbox();
	/** Project field of {@link #selectionPanel} */
	private Listbox projectField = new Listbox();
	
	/** BOM group box, center of {@link #borderLayout} */
	private Groupbox centerGroupbox = new Groupbox();
	private int indend = 20;

	/** Panel of action buttons. South of {@link #borderLayout} */
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	
	/** Form controller */
	private BOMDrop bomDrop = new BOMDrop();

	/** ParentProductID_ParentBOMLineLevel:Child Panel (in {@link #m_childPanelList}) */
	private HashMap<String, Component> m_parentContainerMap = new HashMap<>();
	
	/** BOMLevel|Feature:Groupbox */
	private Map<String, Groupbox> m_featureGroup = new HashMap<>();

	/** selected variant or option with key of ParentProductId_ProductId */ 
	private List<String> m_selectedOtions = new ArrayList<>();
	/** unselected variant or option with key of ParentProductId_ProductId */
	private List<String> m_unselectedOtions = new ArrayList<>();

	/**
	 * Default constructor
	 */
	public WBOMDrop()
	{}
	
	/**
	 *	Layout form
	 */
	protected void initForm()
	{
		try
		{
			Env.setContext(Env.getCtx(), getWindowNo(), "IsSOTrx", "");
			
			borderLayout = new Borderlayout();
			this.appendChild(borderLayout);
			borderLayout.setHeight("100%");
			borderLayout.setWidth("100%");
						
			confirmPanel = new ConfirmPanel(true);
			
			borderLayout.appendSouth(confirmPanel);
			borderLayout.getSouth().setStyle("padding-top: 3px;");
			 
			//	Top Selection Panel
			createSelectionPanel(true, true, true);

			//	Center
			Center center = new Center();
			center.setVflex("1");
			center.setAutoscroll(true);
			borderLayout.appendChild(center);
			center.appendChild(centerGroupbox);
			centerGroupbox.setWidth("100%");
			centerGroupbox.setHeight("auto");
			createMainPanel();

			confirmPanel.addActionListener(Events.ON_CLICK, this);
			
			setBorder(false);			
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
		}
	}

	/**
	 * 	Dispose
	 */
	public void dispose()
	{
		if (selectionPanel != null)
			selectionPanel.getChildren().clear();
		
		selectionPanel = null;
		
		if (m_selectorList != null)
			m_selectorList.clear();
		
		m_selectorList = null;
		
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

		if (m_productPanelList  != null) {
			m_productPanelList.clear();
		}

		m_productPanelList = null;

		if (m_alternativeGroups != null)
			m_alternativeGroups.clear();
		m_alternativeGroups = null;
	}	//	dispose
	
	/**
	 * Create Selection/Parameters Panel.
	 * @param order
	 * @param invoice
	 * @param project
	 * @throws Exception 
	 */	
	private void createSelectionPanel (boolean order, boolean invoice, boolean project) throws Exception
	{
		Caption caption = new Caption(Msg.translate(Env.getCtx(), "Selection"));

		selectionGroupbox.appendChild(caption);
		selectionGroupbox.appendChild(selectionPanel);
		borderLayout.appendNorth(selectionGroupbox);
		
		MLookup productLookup = MLookupFactory.get(Env.getCtx(), m_WindowNo,
				MColumn.getColumn_ID(MProduct.Table_Name, "M_Product_ID"),
				DisplayType.Search, Env.getLanguage(Env.getCtx()), MProduct.COLUMNNAME_M_Product_ID, 0, false,
				"M_Product.IsBOM='Y' AND M_Product.IsVerified='Y' AND M_Product.IsActive='Y' ");
		
		fieldProduct = new WSearchEditor("M_Product_ID", true, false, true, productLookup);
		fieldProduct.addValueChangeListener(this);
				
		Rows rows = selectionPanel.newRows();
		Row boxProductQty = rows.newRow();
		
		Label lblProduct = new Label(Msg.translate(Env.getCtx(), "M_Product_ID"));
		Label lblQty = new Label(Msg.translate(Env.getCtx(), "Qty"));
		productQty.setValue(Env.ONE);
		productQty.addEventListener(Events.ON_CHANGE, this);
		
		fieldProduct.fillHorizontal();
		boxProductQty.appendChild(lblProduct.rightAlign());
		boxProductQty.appendChild(fieldProduct.getComponent());
		boxProductQty.appendChild(lblQty.rightAlign());
		boxProductQty.appendChild(productQty);
		
		KeyNamePair[] keyNamePair = null;
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
			
			orderField.addEventListener(Events.ON_SELECT, this);
			
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
		
		//	Enable in valueChange or onEvent
		confirmPanel.setEnabled("Ok", false);
	}	//	createSelectionPanel

	/**
	 * 	Get Array of draft Orders
	 *	@return array of draft orders
	 */	
	private KeyNamePair[] getOrders()
	{
		return bomDrop.getDraftOrders(null);
	}	//	getOrders

	/**
	 * 	Get Array of open non service Projects
	 *	@return array of projects
	 */	
	private KeyNamePair[] getProjects()
	{
		return bomDrop.getNonServiceProjects(null);
	}	//	getProjects
	
	/**
	 * 	Get Array of open Invoices
	 *	@return array of invoices
	 */	
	private KeyNamePair[] getInvoices()
	{
		return bomDrop.getDraftInvoices(null);
	}	//	getInvoices

	/**
	 * Create Main Panel.
	 * Called after change of selected product.
	 */	
	private void createMainPanel ()
	{
		if (log.isLoggable(Level.CONFIG)) log.config(": " + m_product);
		
		m_selectorList.clear();
		m_productList.clear();
		m_qtyList.clear();
		m_alternativeGroups.clear();
		m_childPanelList.clear();
		m_productPanelList.clear();
		m_parentContainerMap.clear();
		m_featureGroup.clear();
		
		Caption title = new Caption(Msg.getMsg(Env.getCtx(), "SelectProduct"));

		centerGroupbox.getChildren().clear();
		centerGroupbox.appendChild(title);
		
		if (m_product != null && m_product.get_ID() > 0)
		{
			title.setLabel(m_product.getName());
			
			if (m_product.getDescription() != null && m_product.getDescription().length() > 0)
				title.setTooltiptext(m_product.getDescription());
			
			maxBomDeep = bomDrop.getMaxBOMDeep(m_product);
			
			bomDrop.addBOMLines(m_product, m_qty, b -> addBOMLine(b));
			
			updateBOMChildVisibility();
			
			m_parentContainerMap.clear();
		}
	}	//	createMainPanel

	private int maxBomDeep = 0;
	
	/**
	 * 	Add BOM line to {@link #m_productPanelList}.
	 * 	@param bomLine BOM Line
	 */	
	private void addBOMLine (BOMLine bomLine)
	{
		MProduct product = bomLine.getProductBOMLine().getProduct();
		MProduct parentProduct = bomLine.getParentProduct();
		Component parentPanel = null;
		if (bomLine.getBOMLevel() == 0)
		{
			parentPanel = centerGroupbox;
		}
		else
		{
			String key = parentProduct.get_ID() + "_" + (bomLine.getBOMLevel()-1);
			parentPanel = m_parentContainerMap.get(key);
		}
		
		Layout productPanel = addDisplay (parentProduct.getM_Product_ID(), product.getM_Product_ID(), 
				bomLine.getBOMType(), product.getName(), bomLine.getLineQty(), parentPanel, bomLine.getBOMLevel(), bomLine.getFeature());
		m_productPanelList.add(productPanel);
		
		if (product.isBOM() && product.isVerified()) {
			Vlayout childPanel = createVlayoutPanel("100%");
			m_childPanelList.add(childPanel);
			String key = product.get_ID() + "_" + bomLine.getBOMLevel();
			m_parentContainerMap.put(key, childPanel);
		} else {
			m_childPanelList.add(null);
		}
			
	}	//	addBOMLine

	/**
	 * 	Render single BOM line.
	 *	@param parentM_Product_ID parent product
	 *	@param M_Product_ID product
	 *	@param bomType bom type
	 *	@param name name
	 *	@param lineQty qty
	 *  @param parentPanel child panel of parent product
	 *  @param bomLevel
	 *  @param feature
	 *  @return {@link Layout}
	 */	
	private Layout addDisplay (int parentM_Product_ID,
		int M_Product_ID, String bomType, String name, BigDecimal lineQty, Component parentPanel, int bomLevel, String feature)
	{
		if (log.isLoggable(Level.FINE)) log.fine("M_Product_ID=" + M_Product_ID + ",Type=" + bomType + ",Name=" + name + ",Qty=" + lineQty);
		
		boolean selected = false;

		//Container info of product (checkBox or radio box,product name, qty input)
		Layout productPanel = createHlayoutPanel("100%");
		
		//Container productPanel because, this container will contain child of this product by vertical
		Layout outerProductPanel = new Vlayout();
		outerProductPanel.appendChild(productPanel);

		// checkbox or radio button for selection of product
		Div selectPanel = createDivPanel(25);
		org.zkoss.zul.Checkbox checkbox = null;
		boolean isMandatory = MPPProductBOMLine.COMPONENTTYPE_Component.equals(bomType) || MPPProductBOMLine.COMPONENTTYPE_Phantom.equals(bomType)
			|| MPPProductBOMLine.COMPONENTTYPE_Packing.equals(bomType) || MPPProductBOMLine.COMPONENTTYPE_Tools.equals(bomType);
		selected = isMandatory;
		
		String optionKey = parentM_Product_ID + "_" + M_Product_ID;
		if (!(MPPProductBOMLine.COMPONENTTYPE_Variant.equals(bomType)))
		{
			checkbox = new Checkbox();			
			checkbox.setChecked(selected);
			checkbox.setDisabled(isMandatory);			
			if (!isMandatory)
			{
				if (m_selectedOtions.contains(optionKey))
					checkbox.setChecked(true);
				else if (m_unselectedOtions.contains(optionKey))
					checkbox.setChecked(false);
				selected = checkbox.isChecked();
			}
		} else {	//	Variant
			checkbox = new Radio();
		}	
		checkbox.setAttribute(OPTION_PRODUCT_KEY_ATTR, optionKey);
		
		selectPanel.appendChild(checkbox);
		m_selectorList.add(checkbox);
		productPanel.appendChild(selectPanel);
		if (!checkbox.isDisabled())
			checkbox.addEventListener(Events.ON_CHECK, this);

		Div rightInden = createDivPanel((maxBomDeep - bomLevel) * indend);
		productPanel.appendChild(rightInden);

		//	Add to List
		m_productList.add (Integer.valueOf(M_Product_ID));

		// add product name
		Div namePanel = createDivPanel(200);
		Label label = new Label(name);
		HtmlBasedComponent c = (HtmlBasedComponent) label.rightAlign();
		c.setStyle(c.getStyle() + ";margin-right: 5px");
		namePanel.appendChild(c);
		productPanel.appendChild(namePanel);

		// qty input control
		Div qtyPanel = createDivPanel(200);
		Decimalbox qty = new Decimalbox();
		qty.setValue(lineQty);
		qtyPanel.appendChild(qty);
		productPanel.appendChild(qtyPanel);
		m_qtyList.add(qty);

		// outer container for indent contain index box and product panel
		Layout outerContainer = createHlayoutPanel("100%");
		outerContainer.setStyle("margin-top:3px;");
		((Hlayout)outerContainer).setValign("middle");
		parentPanel.appendChild(outerContainer);

		if (!parentPanel.equals(centerGroupbox)) {
			// indent 
			Div cellInden = createDivPanel(indend);
			outerContainer.appendChild(cellInden);
		}

		Groupbox featureGroup = null;
		if (!Util.isEmpty(feature, true)) {
			String key = bomLevel + "|" + feature;
			featureGroup = m_featureGroup.get(key);
			if (featureGroup == null) {
				featureGroup = new Groupbox();
				featureGroup.setAttribute(FEATURE_GROUP_KEY_ATTR, key);
				featureGroup.appendChild(new Caption(feature));
				m_featureGroup.put(key, featureGroup);
			}
		}
		
		// add product panel to parent, with radio, add to radio group
		if (!(MPPProductBOMLine.COMPONENTTYPE_Variant.equals(bomType))) {
			if (featureGroup != null) {
				if (featureGroup.getParent() == null)
					outerContainer.appendChild(featureGroup);
				featureGroup.appendChild(outerProductPanel);
			} else {
				outerContainer.appendChild(outerProductPanel);
			}
		} else {
			String groupName = String.valueOf(parentM_Product_ID) + "_" + bomType + "_" +  parentPanel.toString();	
			if (featureGroup != null) {
				groupName = groupName + "_" + featureGroup.getAttribute(FEATURE_GROUP_KEY_ATTR);
			}			
			Radiogroup radioGroup = m_alternativeGroups.get(groupName);
			
			boolean first = false;
			if (radioGroup == null) {
				if (log.isLoggable(Level.FINE)) log.fine("RadioGroup=" + groupName);
				radioGroup = new Radiogroup();
				m_alternativeGroups.put(groupName, radioGroup);
				first = true;
				if (featureGroup != null) {
					if (featureGroup.getParent() == null)
						outerContainer.appendChild(featureGroup);
					featureGroup.appendChild(radioGroup);
				} else {
					outerContainer.appendChild(radioGroup);
				}
			} else {
				outerProductPanel.setStyle("margin-top:3px;");
			}
			radioGroup.appendChild(outerProductPanel);
			if (m_selectedOtions.contains(optionKey))
			{
				selected = true;
				checkbox.setChecked(true);
			}
			else if (m_unselectedOtions.contains(optionKey))
			{
				selected = false;
				checkbox.setChecked(false);
			}
			else if (first)
			{
				selected = true;
				checkbox.setChecked(true);
				m_selectedOtions.add(optionKey);
			}
			else
			{
				selected = false;
				checkbox.setChecked(false);
				m_unselectedOtions.add(optionKey);
			}
		}
		
		qty.setReadonly(!selected);
		return outerProductPanel;
	}	//	addDisplay

	/**
	 * @param width
	 * @return {@link Div}
	 */
	private Div createDivPanel (int width) {
		Div divPanel = new Div ();
		ZKUpdateUtil.setWidth(divPanel, String.format("%1$spx", width));
		divPanel.setStyle("padding-right:0;padding-left:0");
		return divPanel; 
	}

	/**
	 * @param width
	 * @return {@link Hlayout}
	 */
	private Hlayout createHlayoutPanel (String width) {
		Hlayout layout = new Hlayout();
		layout.setSpacing("0");
		ZKUpdateUtil.setWidth(layout, width);
		return layout;
	}

	/**
	 * @param width
	 * @return {@link Vlayout}
	 */
	private Vlayout createVlayoutPanel (String width) {
		Vlayout layout = new Vlayout();
		layout.setSpacing("0");
		ZKUpdateUtil.setWidth(layout, width);
		return layout;
	}

	/**
	 * Event Listener
	 * @param e event
	 */
	@Override
	public void onEvent (Event e) throws Exception
	{
		if (log.isLoggable(Level.CONFIG)) log.config(e.getName());
		
		Object source = e.getTarget();

		//	Toggle Qty Enabled
		if (source instanceof org.zkoss.zul.Checkbox)
		{
			org.zkoss.zul.Checkbox checkbox = (org.zkoss.zul.Checkbox)source;
			// set enable or disable qty input of this source
			int index = m_selectorList.indexOf(checkbox);
			m_qtyList.get(index).setReadonly(!checkbox.isChecked());

			// disable qty of other radio in group
			if (checkbox instanceof Radio) {
				// find Radio Group
				Radiogroup group = ((Radio)checkbox).getRadiogroup();
				List<Radio> lsRadio = group.getItems();
				
				for (Radio radio : lsRadio) {
					if (!checkbox.equals(radio)) {						
						// fix unknow error. at fisrt event, prev radio checkbox also is checked
						radio.setChecked(false);
						// set qty input of uncheck radio button
						index = m_selectorList.indexOf(radio);
						m_qtyList.get(index).setReadonly(true);
						m_selectedOtions.remove(radio.getAttribute(OPTION_PRODUCT_KEY_ATTR));
						m_unselectedOtions.add((String) radio.getAttribute(OPTION_PRODUCT_KEY_ATTR));
					}
				}
			}
			
			updateBOMChildVisibility();
			if (checkbox.isChecked()) {
				m_selectedOtions.add((String) checkbox.getAttribute(OPTION_PRODUCT_KEY_ATTR));
				m_unselectedOtions.remove(checkbox.getAttribute(OPTION_PRODUCT_KEY_ATTR));
			} else {
				m_unselectedOtions.add((String) checkbox.getAttribute(OPTION_PRODUCT_KEY_ATTR));
				m_selectedOtions.remove(checkbox.getAttribute(OPTION_PRODUCT_KEY_ATTR));
			}
		}
		//	Product / Qty
		else if (source == productQty)
		{
			m_qty = productQty.getValue();
			if (m_product != null && m_product.get_ID() > 0)
				createMainPanel();
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
				return;
			}	
		}
		else if (confirmPanel.getButton("Cancel").equals(e.getTarget()))
		{
			SessionManager.getAppDesktop().closeActiveWindow();
			return;
		}
			
		enableSave();
	}

	/**
	 * Update state of Ok button in {@link #confirmPanel}.
	 */
	private void enableSave() {
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
	}

	/**
	 * Handle changes to {@link #fieldProduct}
	 * @param productFieldValue
	 */
	private void onProductChanged(Object productFieldValue) {		
		int id = (productFieldValue != null && productFieldValue instanceof Integer) ? (Integer)productFieldValue : 0;
		if (m_product == null || m_product.get_ID() != id)
			m_product = id > 0 ? MProduct.get (Env.getCtx(), id) : null;
		createMainPanel();
		enableSave();
	}

	/**
	 * Update display of bom tree.
	 * For item not selected, hide corresponding panel (in {@link #m_childPanelList}).
	 */
	protected void updateBOMChildVisibility() {
		int index = 0;
		for(org.zkoss.zul.Checkbox checkbox : m_selectorList) {
			index = m_selectorList.indexOf(checkbox);
			Layout childPanel = m_childPanelList.get(index);
			Layout productPanel = m_productPanelList.get(index);

			if (childPanel != null && checkbox.isChecked() && !productPanel.getChildren().contains(childPanel)) {
				productPanel.appendChild(childPanel);
			} else if (childPanel != null && !checkbox.isChecked() && productPanel.getChildren().contains(childPanel)) {
				childPanel.detach();
			}
		}
	}
	
	/**
	 * Save changes. Delegate to {@link #cmd_save(Trx)}.
	 * @return true if save successfully, false otherwise.
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
	
	/**
	 * 	Save changes to DB.
	 *  @param trx
	 * 	@return true if saved, false otherwise.
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
	 * 	Create and save order lines from BOM.
	 *	@param C_Order_ID id
	 *  @param trx 
	 *	@return true if saved, false otherwise.
	 */	
	private boolean cmd_saveOrder (int C_Order_ID, Trx trx)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_Order_ID=" + C_Order_ID);
		List<BOMDrop.SelectedItem> selectedItems = new ArrayList<>();
		try 
		{
			//for all selected bom lines
			for (int i = 0; i < m_selectorList.size(); i++) 
			{
				if (m_selectorList.get(i).getPage() != null && m_selectorList.get(i).isChecked()) 
				{
					BigDecimal qty = m_qtyList.get(i).getValue();
					int M_Product_ID = m_productList.get(i).intValue();
					MProduct product = MProduct.get(M_Product_ID);
					if (!(product.isBOM() && product.isVerified()))
						selectedItems.add(new BOMDrop.SelectedItem(M_Product_ID, qty));
				} // line selected
			}
			
			MOrder order = bomDrop.saveOrderLines(C_Order_ID, selectedItems, trx.getTrxName());
			String summary = Msg.translate(Env.getCtx(), "C_Order_ID")+ " : " + order.getDocumentInfo() + " , " + Msg.translate(Env.getCtx(), "NoOfLines") + " " 
					+ Msg.translate(Env.getCtx(), "Inserted") + " = " + selectedItems.size();
			ProcessInfo pi = new ProcessInfo(getFormName(), 0);
			pi.addLog(0, 0, null, null, summary, MOrder.Table_ID, order.getC_Order_ID());
			ProcessInfoDialog dialog = new ProcessInfoDialog(pi, false);			
			dialog.setAutoCloseAfterZoom(true);
			dialog.setPage(this.getPage());
			dialog.doHighlighted();
		} catch (Exception e) 
		{
			log.log(Level.SEVERE, e.getMessage(), e);
			if (trx != null) 
				trx.rollback();
			throw (e instanceof RuntimeException) ? (RuntimeException)e : new AdempiereException(e.getMessage());
		}				
		
		if (log.isLoggable(Level.CONFIG)) log.config("#" + selectedItems.size());
		return true;
	}	//	cmd_saveOrder

	/**
	 * 	Create and save invoice lines from BOM.
	 *	@param C_Invoice_ID id
	 *  @param trx 
	 *	@return true if saved, false otherwise.
	 */	
	private boolean cmd_saveInvoice (int C_Invoice_ID, Trx trx)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_Invoice_ID=" + C_Invoice_ID);
		List<BOMDrop.SelectedItem> selectedItems = new ArrayList<>();
		try 
		{
			//for all selected bom lines
			for (int i = 0; i < m_selectorList.size(); i++) 
			{
				if (m_selectorList.get(i).getPage() != null && m_selectorList.get(i).isChecked())
				{
					BigDecimal qty = m_qtyList.get(i).getValue();
					int M_Product_ID = m_productList.get(i).intValue();
					MProduct product = MProduct.get(M_Product_ID);
					if (!(product.isBOM() && product.isVerified()))
						selectedItems.add(new BOMDrop.SelectedItem(M_Product_ID, qty));
				}
			}
			MInvoice invoice = bomDrop.saveInvoiceLines(C_Invoice_ID, selectedItems, trx.getTrxName());
			String summary = Msg.translate(Env.getCtx(), "C_Invoice_ID")+ " : " + invoice.getDocumentInfo() +  " , " + Msg.translate(Env.getCtx(), "NoOfLines") + " " 
					+ Msg.translate(Env.getCtx(), "Inserted") + " = " + selectedItems.size();
			ProcessInfo pi = new ProcessInfo(getFormName(), 0);
			pi.addLog(0, 0, null, null, summary, MInvoice.Table_ID, invoice.getC_Invoice_ID());
			ProcessInfoDialog dialog = new ProcessInfoDialog(pi, false);
			dialog.setAutoCloseAfterZoom(true);
			dialog.setPage(this.getPage());
			dialog.doHighlighted();
		} catch (Exception e) 
		{
			log.log(Level.SEVERE, "Line not saved");
			if (trx != null) 
				trx.rollback();
			throw (e instanceof RuntimeException) ? (RuntimeException)e : new AdempiereException(e.getMessage());
		}		
				
		if (log.isLoggable(Level.CONFIG)) log.config("#" + selectedItems.size());
		return true;
	}	//	cmd_saveInvoice

	/**
	 * 	Create and save project lines from BOM.
	 *	@param C_Project_ID id
	 *  @param trx
	 *	@return true if saved, false otherwise
	 */
	private boolean cmd_saveProject (int C_Project_ID, Trx trx)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("C_Project_ID=" + C_Project_ID);		
		List<BOMDrop.SelectedItem> selectedItems = new ArrayList<>();
		try 
		{
			//for all selected bom lines
			for (int i = 0; i < m_selectorList.size(); i++)
			{
				if (m_selectorList.get(i).getPage() != null && m_selectorList.get(i).isChecked())
				{
					BigDecimal qty = m_qtyList.get(i).getValue();
					int M_Product_ID = m_productList.get(i).intValue();
					MProduct product = MProduct.get(M_Product_ID);
					if (!(product.isBOM() && product.isVerified()))
						selectedItems.add(new BOMDrop.SelectedItem(M_Product_ID, qty));
				}
			}
			MProject project = bomDrop.saveProjectLines(C_Project_ID, selectedItems, trx.getTrxName());
			String summary = Msg.translate(Env.getCtx(), "C_Project_ID")+ " : " + project.getName() + " , " + Msg.translate(Env.getCtx(), "NoOfLines") + " " 
					+ Msg.translate(Env.getCtx(), "Inserted") + " = " + selectedItems.size();
			ProcessInfo pi = new ProcessInfo(getFormName(), 0);
			pi.addLog(0, 0, null, null, summary, MProject.Table_ID, project.getC_Project_ID());
			ProcessInfoDialog dialog = new ProcessInfoDialog(pi, false);
			dialog.setAutoCloseAfterZoom(true);
			dialog.setPage(this.getPage());
			dialog.doHighlighted();
		} catch (Exception e) 
		{
			log.log(Level.SEVERE, "Line not saved");
			if (trx != null) 
				trx.rollback();
			throw (e instanceof RuntimeException) ? (RuntimeException)e : new AdempiereException(e.getMessage());
		}		
				
		if (log.isLoggable(Level.CONFIG)) log.config("#" + selectedItems.size());
		return true;
	}	//	cmd_saveProject

	@Override
	public void valueChange(ValueChangeEvent evt) {
		m_selectedOtions.clear();
		m_unselectedOtions.clear();
		onProductChanged(evt.getNewValue());
	}
}
