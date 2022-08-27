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

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.apps.form.AttributeGrid;
import org.compiere.model.MAttribute;
import org.compiere.model.MAttributeValue;
import org.compiere.model.MDocType;
import org.compiere.model.MOrder;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MStorageReservation;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Center;
import org.zkoss.zul.Decimalbox;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tree;
import org.zkoss.zul.Treecell;
import org.zkoss.zul.Treechildren;
import org.zkoss.zul.Treecol;
import org.zkoss.zul.Treecols;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.Treerow;

/**
 *	Product Attribute Table.
 *	Select one or two attributes for view/etc.
 *	
 *  @author hengsin
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VAttributeGrid")
public class WAttributeGrid extends ADForm implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 687630618195901592L;	
	
	/**
	 * 	Init
	 */
	@Override
	protected void initForm()
    {
		m_attributes = MAttribute.getOfClient(Env.getCtx(), true, true);
		KeyNamePair[] keyNamePairs = new KeyNamePair[m_attributes.length+1];
		keyNamePairs[0] = new KeyNamePair(0, "");
		for (int i = 0; i < m_attributes.length; i++)
			keyNamePairs[i+1] = m_attributes[i].getKeyNamePair();
		
		attributeCombo1 = new Listbox(keyNamePairs);
		attributeCombo1.setMold("select");
		attributeCombo1.setSelectedIndex(0);
		
		attributeCombo2 = new Listbox(keyNamePairs);
		attributeCombo2.setMold("select");
		attributeCombo2.setSelectedIndex(0);
		
		filterAttributeCombo = new Listbox(keyNamePairs);
		filterAttributeCombo.setMold("select");
		filterAttributeCombo.setSelectedIndex(0);

		groupAttributeCombo = new Listbox(keyNamePairs);
		groupAttributeCombo.setMold("select");
		groupAttributeCombo.setSelectedIndex(0);

		fillPriceListAndWarehouse(pickPriceList, pickWarehouse);
		
		ZKUpdateUtil.setWidth(tabbox, "100%");
		ZKUpdateUtil.setVflex(tabbox, "1");
		tabbox.appendChild(tabs);
		tabbox.appendChild(tabpanels);
		tabbox.addEventListener(Events.ON_SELECT, this);
		
		gridSelection = new Grid();
		ZKUpdateUtil.setWindowWidthX(gridSelection, 500);
		gridSelection.setStyle("margin:0; padding:0;");
		gridSelection.makeNoStrip();
		gridSelection.setOddRowSclass("even");
		
		ZKUpdateUtil.setWidth(gridView, "100%");
		ZKUpdateUtil.setHeight(gridView, "100%");
        
		Rows rows = new Rows();
		gridSelection.appendChild(rows);
		
		Row row = new Row();
		rows.appendChild(row);
		Div div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(attributeLabel1);
		row.appendCellChild(div, 1);
		row.appendCellChild(attributeCombo1, 2);
		ZKUpdateUtil.setWidth(attributeCombo1, "100%");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(attributeLabel2);
		row.appendCellChild(div, 1);
		row.appendCellChild(attributeCombo2, 2);
		ZKUpdateUtil.setWidth(attributeCombo2, "100%");
		
		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(labelFilter.rightAlign());
		filterAttributeCombo.setWidth("100%");
		row.appendCellChild(filterAttributeCombo);
		filterValueCombo.setWidth("100%");
		row.appendChild(filterValueCombo);
		filterAttributeCombo.addEventListener(Events.ON_SELECT, this);

		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(labelGroup);
		row.appendCellChild(div);
		row.appendCellChild(groupAttributeCombo, 2);
		groupAttributeCombo.setWidth("100%");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(labelPriceList);
		row.appendCellChild(div, 1);
		row.appendCellChild(pickPriceList, 2);
		ZKUpdateUtil.setWidth(pickPriceList, "100%");
		
		row = new Row();
		rows.appendChild(row);
		div = new Div();
		div.setStyle("text-align: right;");
		div.appendChild(labelWarehouse);
		row.appendCellChild(div, 1);
		row.appendCellChild(pickWarehouse, 2);
		ZKUpdateUtil.setWidth(pickWarehouse, "100%");
		
		div = new Div();
		div.setStyle("text-align: center;");
		div.appendChild(gridSelection);
		
		Tabpanel tabSelectionPanel = new Tabpanel();
		tabSelectionPanel.appendChild(div);

		Tab tabSelection = new Tab(Msg.getMsg(Env.getCtx(), "Selection"));
		tabpanels.appendChild(tabSelectionPanel);
		tabs.appendChild(tabSelection);

		Tabpanel tabAttributeGridPanel = new Tabpanel();
		tabAttributeGridPanel.appendChild(gridView);
		
		Tab tabAttributeGrid = new Tab(Msg.getMsg(Env.getCtx(), "AttributeGrid"));
		tabpanels.appendChild(tabAttributeGridPanel);
		tabs.appendChild(tabAttributeGrid);
		
		ZKUpdateUtil.setWidth(this, "100%");
		ZKUpdateUtil.setHeight(this, "100%");
		Borderlayout layout = new Borderlayout();
		layout.setStyle("height: 100%; width: 100%; position: relative;");
		this.appendChild(layout);

		Center center = new Center();
		center.setVflex("true");
		layout.appendChild(center);
		center.appendChild(tabbox);
		tabbox.addEventListener(Events.ON_SELECT, this);
		South south = new South();
		layout.appendChild(south);
		south.appendChild(confirmPanel);
		confirmPanel.addActionListener(this);
		confirmPanel.setStyle("margin-top: 5px;");
		south.setVflex("min");				
	}	//	init

	private Grid gridSelection;
	private AttributeGrid attributeGrid = new AttributeGrid();
	/** Product Attributes	*/
	private MAttribute[]	m_attributes = null;
	/**	Logger	*/
	private static final CLogger log = CLogger.getCLogger (WAttributeGrid.class);
	
	/** Price List Version	*/
	private int				m_M_PriceList_Version_ID = 0;
	private DecimalFormat	m_price = DisplayType.getNumberFormat(DisplayType.CostPrice);
	/** Warehouse			*/
	private int				m_M_Warehouse_ID = 0;
	private DecimalFormat	m_qty = DisplayType.getNumberFormat(DisplayType.Quantity);
	
	/** UI			**/
	private Tabbox 		tabbox = new Tabbox();
	private Tabs 		tabs = new Tabs();
	private Tabpanels 	tabpanels = new Tabpanels();
	
	private Label		attributeLabel1 = new Label(Msg.getElement(Env.getCtx(), "M_Attribute_ID") + " 1");
	private Listbox		attributeCombo1 = null;
	private Label		attributeLabel2 = new Label(Msg.getElement(Env.getCtx(), "M_Attribute_ID") + " 2");
	private Listbox		attributeCombo2 = null;
	private Label 		labelPriceList = new Label(Msg.getElement(Env.getCtx(), "M_PriceList_ID"));
	private Listbox 	pickPriceList = ListboxFactory.newDropdownListbox();
	private Label 		labelWarehouse = new Label(Msg.getElement(Env.getCtx(), "M_Warehouse_ID"));
	private Listbox 	pickWarehouse = ListboxFactory.newDropdownListbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel(true);
	//
	private Borderlayout gridView = new Borderlayout();
	
	private Label 		labelFilter = new Label(Msg.getMsg(Env.getCtx(), "filter.by"));
	private Listbox		filterAttributeCombo = null;
	private Listbox		filterValueCombo = ListboxFactory.newDropdownListbox();
	private Map<Integer, Decimalbox> productInputMap = new HashMap<Integer, Decimalbox>();
	private Map<Integer, Integer> productOrderLineMap = new HashMap<Integer, Integer>();

	private Map<Treeitem, List<Component[]>> nodeContent = null;

	private Tree tree = null;
	private MOrder m_order = null;

	private Label labelGroup = new Label("Group By");
	private Listbox	groupAttributeCombo = null;

	/**
	 * Fill Picks with values
	 * @param pickWarehouse 
	 * @param pickPriceList 
	 */
	private void fillPriceListAndWarehouse (Listbox pickPriceList, Listbox pickWarehouse)
	{
		List<KeyNamePair> priceLists = new ArrayList<>();
		List<KeyNamePair> warehouses = new ArrayList<>();
		attributeGrid.fillPriceListAndWarehouse(priceLists, warehouses);
		for(KeyNamePair knp : priceLists)
			pickPriceList.addItem(knp);
		for(KeyNamePair knp : warehouses)
			pickWarehouse.addItem(knp);
	}

	@Override
	public void onEvent(Event e) throws Exception
	{
		if (e.getTarget() instanceof Tab)
		{
			if(tabbox.getSelectedIndex() == 1)
				createGrid();
		}
		else if (e.getTarget().getId().equals(ConfirmPanel.A_OK))
		{
			if (tabbox.getSelectedIndex() == 0)
				createGrid();
			else
				gridOK();
		}
		else if (e.getTarget().getId().equals(ConfirmPanel.A_CANCEL))
			dispose();
		else if (e.getTarget() == filterAttributeCombo)
		{
			populateFilterValueCombo();
		}
		else if (Events.ON_OPEN.equals(e.getName()) && e.getTarget() instanceof Treeitem)
		{
			Treeitem ti = (Treeitem) e.getTarget();
			onOpen(ti);
		}
	}

	private void onOpen(Treeitem ti) {
		Treechildren subChildren = ti.getTreechildren();
		if (subChildren == null) return;
		if (!subChildren.getChildren().isEmpty()) return;
		List<Component[]> components = nodeContent.get(ti);
		if (components == null || components.isEmpty()) return;
		for(int x = 0; x < components.size(); x++)
		{
			Treeitem subItem = new Treeitem();
			subChildren.appendChild(subItem);
			Treerow subRow = new Treerow();
			subItem.appendChild(subRow);
			Component[] elements = components.get(x);
			for (Component c : elements)
			{
				Treecell cell = new Treecell();
				subRow.appendChild(cell);
				if (c != null)
					cell.appendChild(c);
				else
					cell.appendChild(new Space());
			}
		}
	}
	
	private void populateFilterValueCombo() {
		int index = filterAttributeCombo.getSelectedIndex();
		if(index < 0) return;
		else if(index == 0) filterValueCombo.removeAllItems();
		else
		{
			filterValueCombo.removeAllItems();
			filterValueCombo.appendItem("", -1);
			MAttributeValue[] values = m_attributes[index-1].getMAttributeValues();
			for (int i = 0; i < values.length; i++)
			{
				if(values[i] == null) continue;
				filterValueCombo.addItem(values[i].getKeyNamePair());
			}			
		}
		filterValueCombo.invalidate();
	}

	private void gridOK()
	{
		if(m_order != null && m_order.get_ID() > 0)
		{
			if (saveOrderLines())
			{
				onClose();
				return;
			}
		}
		tabbox.setSelectedIndex(0);
	}	//	gridOK

	private boolean saveOrderLines() {
		Map<Integer, BigDecimal> productQtyMap = new HashMap<>();
		for (Integer id : productInputMap.keySet()) {
			productQtyMap.put(id, productInputMap.get(id).getValue());
		}
		
		Trx trx = Trx.get(Trx.createTrxName("WAttributeGrid_SaveOrderInput"), true);
		try {			
			int changesMake = attributeGrid.saveOrderLines(m_order.get_ID(), productQtyMap, productOrderLineMap, trx.getTrxName());			
			if (changesMake > 0)
			{
				trx.commit(true);
			}			
		} catch (Exception e) {
			trx.rollback();
			log.log(Level.SEVERE, e.getMessage(), e);
			Dialog.error(m_WindowNo, "SaveError", e.getLocalizedMessage());
			return false;
		} finally {
			trx.close();
		}
		return true;
	}
	
	/**
	 * 	Create Grid
	 */
	private void createGrid()
	{
		if (attributeCombo1 == null)
			return;	
		
		Object attribute1 = attributeCombo1.getSelectedItem().getValue();
		if (attribute1 == null || ((Number)attribute1).intValue() <= 0)
		{
			Dialog.error(m_WindowNo, "Mandatory", attributeLabel1.getValue());
			tabbox.setSelectedIndex(0);
			return;
		}
		Object attribute2 = attributeCombo2.getSelectedItem().getValue();
		if (attribute1 == null || ((Number)attribute2).intValue() <= 0)
		{
			Dialog.error(m_WindowNo, "Mandatory", attributeLabel2.getValue());
			tabbox.setSelectedIndex(0);
			return;
		}
		
		if (attribute1.equals(attribute2))
		{
			Dialog.error(m_WindowNo, "SameAttributeSelectedForXY", getTitle());
			tabbox.setSelectedIndex(0);
			return;
		}
		m_M_PriceList_Version_ID = 0;		
		ListItem pl = pickPriceList.getSelectedItem();
		if (pl != null)
			m_M_PriceList_Version_ID = Integer.valueOf(pl.getValue().toString());
		
		m_M_Warehouse_ID = 0;
		ListItem wh = pickWarehouse.getSelectedItem();
		if (wh != null)
			m_M_Warehouse_ID = Integer.valueOf(wh.getValue().toString());
		
		int filterSelectedIndex = filterAttributeCombo.getSelectedIndex() - 1;
		MAttributeValue filterValue = null;
		if (filterSelectedIndex >= 0)
		{
			MAttributeValue[] filterValues = m_attributes[filterSelectedIndex].getMAttributeValues();
			ListItem listItem = (ListItem) filterValueCombo.getSelectedItem();
			if(listItem != null)
			{
				Object value = listItem.getValue();
				for(int i = 0; i < filterValues.length; i++)
				{
					if(filterValues[i] == null) continue;
					if(value.equals(filterValues[i].getKeyNamePair().getKey()))
					{
						filterValue = filterValues[i];
						break;
					}
				}
			}
		}

		int groupSelectedIndex = groupAttributeCombo.getSelectedIndex() - 1;

		//	x dimension
		int attribute1Index = -1;
		MAttributeValue[] xValues = null;
		if (attribute1 != null)
		{
			int value = Integer.parseInt(attribute1.toString());
			for(int i = 0; i < m_attributes.length; i++)
			{
				if(m_attributes[i].getKeyNamePair().getKey() == value)
				{
					attribute1Index = i;
					break;
				}
			}
		}
		
		if (attribute1Index >= 0)
		{
			if(filterValue != null && attribute1Index == filterSelectedIndex)
			{
				xValues = new MAttributeValue[] {null, filterValue};
			}
			else
			{
				xValues = m_attributes[attribute1Index].getMAttributeValues();
			}
		}

		if (xValues == null || xValues.length == 0)
		{
			Dialog.error(m_WindowNo, "NoAttributeValuesForX");
			tabbox.setSelectedIndex(0);
			return;
		}

		//	y dimension
		int attribute2Index = -1;
		MAttributeValue[] yValues = null;
		if (attribute2 != null)
		{
			int value = Integer.parseInt(attribute2.toString());
			for(int i = 0; i < m_attributes.length; i++)
			{
				if(m_attributes[i].getKeyNamePair().getKey() == value)
				{
					attribute2Index = i;
					break;
				}
			}
		}
		
		if (attribute2Index >= 0)
		{
			if(filterValue != null && attribute2Index == filterSelectedIndex)
			{
				yValues = new MAttributeValue[] {null, filterValue};
			}
			else
			{
				yValues = m_attributes[attribute2Index].getMAttributeValues();
			}
		}

		if (yValues == null || yValues.length == 0)
		{
			Dialog.error(m_WindowNo, "NoAttributeValuesForY");
			tabbox.setSelectedIndex(0);
			return;
		}

		MAttributeValue[] groupValues = null;
		if (groupSelectedIndex >= 0)
		{
			groupValues = m_attributes[groupSelectedIndex].getMAttributeValues();
		}

		//filter not applicable x,y and g values
		List<MAttributeValue> xValueList = new ArrayList<MAttributeValue>();
		List<MAttributeValue> yValueList = new ArrayList<MAttributeValue>();
		List<MAttributeValue> gValueList = new ArrayList<MAttributeValue>();
		xValueList.add(xValues[0]);
		filterAttributeValues(xValues, yValues[1].getM_Attribute_ID(), groupValues != null ? groupValues[1].getM_Attribute_ID() : 0, filterValue, xValueList);
		yValueList.add(yValues[0]);
		filterAttributeValues(yValues, xValues[1].getM_Attribute_ID(), groupValues != null ? groupValues[1].getM_Attribute_ID() : 0, filterValue, yValueList);
		if (groupValues != null)
			filterAttributeValues(groupValues, xValues[1].getM_Attribute_ID(), yValues[1].getM_Attribute_ID(), filterValue, gValueList);

		xValues = new MAttributeValue[xValueList.size()];
		if (xValues.length <= 1)
		{
			Dialog.error(m_WindowNo, "NoProductsFoundForXAttribute");
			tabbox.setSelectedIndex(0);
			return;
		}
		xValueList.toArray(xValues);
		int noOfCols = xValues.length;

		yValues = new MAttributeValue[yValueList.size()];
		if (yValues.length <= 1)
		{
			Dialog.error(m_WindowNo, "NoProductsFoundForYAttribute");
			tabbox.setSelectedIndex(0);
			return;
		}
		yValueList.toArray(yValues);
		int noOfRows = yValues.length;

		groupValues = new MAttributeValue[gValueList.size()];
		gValueList.toArray(groupValues);

		productInputMap.clear(); 
		productOrderLineMap.clear();
		
		gridView.getChildren().clear();
		
		tree = new Tree();
		tree.setRows(0);
		tree.setPageSize(-1);
		Treecols treeCols = new Treecols();
		tree.appendChild(treeCols);
		tree.setSizedByContent(false);
		tree.setHflex("1");

		// create column header
		Treecol treeCol = new Treecol();
		treeCol.setLabel(m_attributes[attribute2Index].getName());
		treeCol.setWidth("25%");
		treeCols.appendChild(treeCol);
		treeCols.setSizable(true);
		int colWidth = 75 / noOfCols;
		for (int col = 1; col < noOfCols; col++)
		{
			MAttributeValue xValue = xValues[col];
			treeCol = new Treecol();
			treeCol.setLabel(xValue.getName());
			treeCol.setWidth(colWidth+"%");
			treeCols.appendChild(treeCol);
		}
			
		Treechildren treeChildren = new Treechildren();
		tree.appendChild(treeChildren);
		nodeContent = new HashMap<Treeitem, List<Component[]>>();
		if (groupValues.length > 0) 
		{
			for(int g = 0; g < groupValues.length; g++)
			{
				Treeitem gItem = new Treeitem();
				treeChildren.appendChild(gItem);
				Treerow gRow = new Treerow();
				gItem.appendChild(gRow);
				gItem.setOpen(true);
				Treecell gCell = new Treecell();
				gRow.appendChild(gCell);
				gCell.setLabel(groupValues[g].getValue());
				gCell = new Treecell();
				gCell.setLabel("");
				gCell.setSpan(noOfCols - 1);
				gRow.appendChild(gCell);
				Treechildren yChildren = new Treechildren();
				gItem.appendChild(yChildren);
				MAttributeValue groupValue = groupValues[g]; 
				buildAttributeTree(noOfRows, noOfCols, xValues, yValues, filterValue, groupValue, yChildren);
			}
		} 
		else
		{
			buildAttributeTree(noOfRows, noOfCols, xValues, yValues, filterValue, null, treeChildren);
		}

		if (m_order != null && m_order.get_ID() > 0)
		{
			North north = new North();
			gridView.appendChild(north);
			MDocType docType = new MDocType(m_order.getCtx(),
					m_order.getC_DocType_ID() > 0 ? m_order.getC_DocType_ID() : m_order.getC_DocTypeTarget_ID(), null);
			Label docLabel = new Label(docType.getName() + ": " + m_order.getDocumentNo());
			String f = filterValue != null ? (m_attributes[filterSelectedIndex].getName() + ": " + filterValue.getKeyNamePair().getName()) : null;			
			Div div = new Div();
			div.appendChild(docLabel);
			if (f != null)
			{
				Label fLabel = new Label(f);
				Space space = new Space();
				space.setSpacing("40px");
				div.appendChild(space);
				div.appendChild(fLabel);
			}
			north.appendChild(div);
		}
		
		Center center = new Center();
		gridView.appendChild(center);
		center.appendChild(tree);
		tree.setStyle("width: 100%");
		tree.setVflex(true);
		center.setAutoscroll(false);
		center.setVflex("true");

		tabbox.setSelectedIndex(1);
	}	//	createGrid

	private void buildAttributeTree(int noOfRows, int noOfCols, MAttributeValue[] xValues, MAttributeValue[] yValues,
			MAttributeValue filterValue, MAttributeValue groupValue, Treechildren treeChildren) {
		for (int row = 1; row < noOfRows; row++)
		{
			MAttributeValue yValue = yValues[row];
			if (!hasProduct(yValue, filterValue, groupValue))
				continue;
			
			Treeitem treeItem = new Treeitem();
			treeChildren.appendChild(treeItem);
			Treerow treeRow = new Treerow();
			treeItem.appendChild(treeRow);
			treeItem.setOpen(false);
			ArrayList<Component[]> componentsList = new ArrayList<Component[]>();
			for (int col = 0; col < noOfCols; col++)
			{
				MAttributeValue xValue = null;
				if (xValues != null)
					xValue = xValues[col];

				if (col == 0)	//	row labels
				{
					Treecell treeCell = new Treecell();
					treeRow.appendChild(treeCell);
					treeCell.setLabel(yValue.getName());
					treeCell = new Treecell();
					treeCell.setLabel("");
					treeCell.setSpan(noOfCols - 1);
					treeRow.appendChild(treeCell);
				}
				else
				{
					ArrayList<Component> panels = getGridElement(xValue, yValue, filterValue);
					for(int p = 0; p < panels.size(); p++)
					{
						Component panel = panels.get(p);
				
						if(p < componentsList.size())
						{
							Component[] comp = componentsList.get(p);
							comp[col] = panel;
							componentsList.set(p, comp);
						}
						else
						{
							Component[] comp = new Component[noOfCols];
							comp[col] = panel;
							componentsList.add(comp);
						}
					}
				}
			}

			if (!componentsList.isEmpty())
			{
				nodeContent.put(treeItem, componentsList);
				Treechildren subChildren = new Treechildren();
				treeItem.appendChild(subChildren);
				treeItem.addEventListener(Events.ON_OPEN, this);
			}
		}
	}
	
	private boolean hasProduct(MAttributeValue attributeValue, MAttributeValue filterValue, MAttributeValue groupValue) {
		return attributeGrid.hasProduct(attributeValue, filterValue, groupValue);
	}

	/**
	 * 	Get Grid Element
	 *	@param xValue X value
	 *	@param yValue Y value
	 *	@return Panel with Info
	 */
	private ArrayList<Component> getGridElement (MAttributeValue xValue, MAttributeValue yValue, MAttributeValue filterValue)
	{
		ArrayList<Component> elements = new ArrayList<Component>();
		
		attributeGrid.travelProducts(xValue, yValue, filterValue, product -> {
			addProduct (elements, product, filterValue != null ? filterValue.getKeyNamePair().getName() : "");
		});
		
		return elements;
	}	//	getGridElement
	
	/**
	 * 	Add Product
	 *	@param element panel
	 *	@param product product
	 *  @param filterName
	 */
	private void addProduct(ArrayList<Component> elements, MProduct product, String filterName)
	{
		int M_Product_ID = product.getM_Product_ID();
		Div pe = new Div();
		pe.setStyle("border-width: thin; border-color: blue; padding: 5px;");
		
		Hbox row = new Hbox();
		pe.appendChild(row);
		//	Product Value - Price
		String p = product.getValue();
		if (p.startsWith(filterName)) {
			p = p.substring(filterName.length());
		}
		row.appendChild(new Label(p));
		String formatted = "";
		if (m_M_PriceList_Version_ID != 0)
		{
			MProductPrice pp = MProductPrice.get(Env.getCtx(), m_M_PriceList_Version_ID, M_Product_ID, null);
			if (pp != null)
			{
				BigDecimal price = pp.getPriceStd();
				formatted = m_price.format(price);
			}
			else
				formatted = "-";
		}
		row.appendChild(new Label(formatted));
		
		//	Product Name - Qty
		row = new Hbox();
		pe.appendChild(row);
		row.appendChild(new Label(product.getName()));
		formatted = "";
		if (m_M_Warehouse_ID != 0)
		{
			BigDecimal qty = MStorageReservation.getQtyAvailable(m_M_Warehouse_ID, M_Product_ID, 0, null);
			if (qty == null)
				formatted = "-";
			else
				formatted = m_qty.format(qty);
		}
		row.appendChild(new Label(formatted));
		if(m_order != null && m_order.get_ID() > 0)
		{
			row = new Hbox();
			pe.appendChild(row);
			Decimalbox nbox = new Decimalbox();
			productInputMap.put(M_Product_ID, nbox);
			int C_OrderLine_ID = attributeGrid.getC_OrderLine_ID(m_order.get_ID(), M_Product_ID, (String)null);
			if (C_OrderLine_ID > 0)
			{
				productOrderLineMap.put(M_Product_ID, C_OrderLine_ID);
				BigDecimal QtyEntered = attributeGrid.getQtyEnter(C_OrderLine_ID, (String)null);
				nbox.setValue(QtyEntered);
			}
			row.appendChild(nbox);
			//
		}
		//
		elements.add(pe);
	}	//	addProduct
	
	private void filterAttributeValues(MAttributeValue[] inputValues,
			int attributeId1, int attributeId2,
			MAttributeValue filterValue, List<MAttributeValue> outputValueList) {
		attributeGrid.filterAttributeValues(inputValues, attributeId1, attributeId2, filterValue, outputValueList);
	}

	@Override
	public void dispose() {
		Object attribute = getAttribute(Window.MODE_KEY);
		if (attribute == null || Window.MODE_EMBEDDED.equals(attribute))
			SessionManager.getAppDesktop().closeActiveWindow();
		else
			super.dispose();
	}

	/**
	 * 
	 * @param C_Order_ID
	 */
	protected void setOrder(int C_Order_ID)
	{
		m_order = new MOrder(Env.getCtx(), C_Order_ID, null);
		m_M_Warehouse_ID = m_order.getM_Warehouse_ID();

		for(int i = 0; i < pickWarehouse.getItemCount(); i++)
		{
			Integer selected = (Integer) pickWarehouse.getItemAtIndex(i).getValue();
			if(selected.intValue() == m_M_Warehouse_ID)
			{
				pickWarehouse.setSelectedIndex(i);
				break;
			}
		}

		MPriceList priceList = MPriceList.get(m_order.getM_PriceList_ID());
		MPriceListVersion plv = priceList != null ? priceList.getPriceListVersion(null) : null;
		m_M_PriceList_Version_ID = plv != null ? plv.getM_PriceList_Version_ID() : 0;

		for(int i = 0; i < pickPriceList.getItemCount(); i++)
		{
			Integer selected = (Integer) pickPriceList.getItemAtIndex(i).getValue();
			if(selected.intValue() == m_M_PriceList_Version_ID)
			{
				pickPriceList.setSelectedIndex(i);
				break;
			}
		}

		Rows rows = (Rows) gridSelection.getRows();
		Row row = new Row();
		rows.appendChild(row);
		row.appendCellChild(new Space(), 3);
		row = new Row();
		rows.appendChild(row);
		MDocType docType = new MDocType(m_order.getCtx(), m_order.getDocTypeID(), null);
		row.appendCellChild(new Label(docType.getName()).rightAlign());
		row.appendCellChild(new Label(m_order.getDocumentNo()), 2);
	}
	
	@Override
	public void setProcessInfo(ProcessInfo pi) {
		super.setProcessInfo(pi);
		if (getProcessInfo() != null && getProcessInfo().getTable_ID() == MOrder.Table_ID && getProcessInfo().getRecord_ID() > 0)
			setOrder(getProcessInfo().getRecord_ID());
	}

	@Override
	public Mode getWindowMode() {
		if (m_order != null)
			return Mode.HIGHLIGHTED;
		else
			return super.getWindowMode();
	}
}	//	WAttributeGrid
