/******************************************************************************
 * Product: Posterita Ajax UI                                                 *
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

package org.adempiere.webui.panel;

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
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.util.CLogMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * Search Product and return selection
 * This class is based on org.compiere.apps.search.InfoPAttribute written by Jorg Janke
 * @author Elaine
 *
 * Zk Port
 * @author Elaine
 * @version	InfoPayment.java Adempiere Swing UI 3.4.1
 */

@Deprecated // replaced with InfoProductWindow IDEMPIERE-325
public class InfoProductPanel extends InfoPanel implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3728242035878883637L;

	private Label lblValue = new Label();
	private Textbox fieldValue = new Textbox();
	private Label lblName = new Label();
	private Textbox fieldName = new Textbox();
	private Label lblUPC = new Label();
	private Textbox fieldUPC = new Textbox();
	private Label lblSKU = new Label();
	private Textbox fieldSKU = new Textbox();
	private Label lblPriceList = new Label();
	private Listbox pickPriceList = new Listbox();
	private Label lblWarehouse = new Label();
	private Listbox pickWarehouse = new Listbox();
	private Label lblVendor = new Label();
	private Textbox fieldVendor = new Textbox();
	// Elaine 2008/11/21
	private Label lblProductCategory = new Label();
	private Listbox pickProductCategory = new Listbox();
	//
	private Label lblAS = new Label();
	private Listbox pickAS = new Listbox();

	// Elaine 2008/11/25
	private Borderlayout borderlayout = new Borderlayout();
	private Textbox fieldDescription = new Textbox();
	Tabbox tabbedPane = new Tabbox();
	WListbox warehouseTbl = ListboxFactory.newDataTable();
    String m_sqlWarehouse;
    WListbox substituteTbl = ListboxFactory.newDataTable();
    String m_sqlSubstitute;
    WListbox relatedTbl = ListboxFactory.newDataTable();
    String m_sqlRelated;
    //Available to Promise Tab
	private WListbox 			m_tableAtp = ListboxFactory.newDataTable();
	private int 				m_M_Product_ID = 0;
    int mWindowNo = 0;
    //

    //IDEMPIERE-337
    WListbox productpriceTbl = ListboxFactory.newDataTable();
    String m_sqlProductprice;
    
	/**	Search Button				*/
	private Button	m_InfoPAttributeButton = new Button();
	/** Instance Button				*/
	private Button	m_PAttributeButton = null;
	/** SQL From				*/
	private static final String s_productFrom =
		"M_Product p"
		+ " LEFT OUTER JOIN M_ProductPrice pr ON (p.M_Product_ID=pr.M_Product_ID AND pr.IsActive='Y')"
		+ " LEFT OUTER JOIN M_AttributeSet pa ON (p.M_AttributeSet_ID=pa.M_AttributeSet_ID)"
		+ " LEFT OUTER JOIN M_Product_PO ppo ON (p.M_Product_ID=ppo.M_Product_ID)"
		+ " LEFT OUTER JOIN C_BPartner bp ON (ppo.C_BPartner_ID=bp.C_BPartner_ID)";

	/**  Array of Column Info    */
	private static ColumnInfo[] s_productLayout = null;
	private static int INDEX_NAME = 0;
	private static int INDEX_PATTRIBUTE = 0;


	/** ASI							*/
	private int			m_M_AttributeSetInstance_ID = -1;
	/** Locator						*/
	private int			m_M_Locator_ID = 0;

	private String		m_pAttributeWhere = null;
	private int			m_C_BPartner_ID = 0;
	
	/**
	 *	Standard Constructor
	 * 	@param WindowNo window no
	 * 	@param M_Warehouse_ID warehouse
	 * 	@param M_PriceList_ID price list
	 * 	@param value    Query Value or Name if enclosed in @
	 * 	@param whereClause where clause
	 */
	public InfoProductPanel(int windowNo,
		int M_Warehouse_ID, int M_PriceList_ID, boolean multipleSelection,String value,
		 String whereClause)
	{
		this(windowNo, M_Warehouse_ID, M_PriceList_ID, multipleSelection, value, whereClause, true);
	}

	/**
	 *	Standard Constructor
	 * 	@param WindowNo window no
	 * 	@param M_Warehouse_ID warehouse
	 * 	@param M_PriceList_ID price list
	 * 	@param value    Query Value or Name if enclosed in @
	 * 	@param whereClause where clause
	 */
	public InfoProductPanel(int windowNo,
		int M_Warehouse_ID, int M_PriceList_ID, boolean multipleSelection,String value,
		 String whereClause, boolean lookup)
	{
		super (windowNo, "p", "M_Product_ID",multipleSelection, whereClause, lookup);
		log.info(value + ", Wh=" + M_Warehouse_ID + ", PL=" + M_PriceList_ID + ", WHERE=" + whereClause);
		setTitle(Msg.getMsg(Env.getCtx(), "InfoProduct"));
		//
		initComponents();
		init();
		initInfo (M_Warehouse_ID, M_PriceList_ID);
		m_C_BPartner_ID = Env.getContextAsInt(Env.getCtx(), windowNo, "C_BPartner_ID");

        int no = contentPanel.getRowCount();
        setStatusLine(Integer.toString(no) + " " + Msg.getMsg(Env.getCtx(), "SearchRows_EnterQuery"), false);
        setStatusDB(Integer.toString(no));
		//	AutoQuery
		if (value != null && value.length() > 0)
        {
	        //	Set Value
	        if (value.indexOf("_") > 0) {
	        	String values[] = value.split("_");
	        	value = values[0];
	        }
			//	Set Value or Name
			fieldValue.setText(value);
			testCount();
			if (m_count <= 0) {
				fieldValue.setText("");
				fieldName.setValue(value);
			}

			executeQuery();
            renderItems();
        }

		tabbedPane.setSelectedIndex(0);

		p_loadedOK = true;

		//Begin - fer_luck @ centuryon
		mWindowNo = windowNo; // Elaine 2008/12/16
		//End - fer_luck @ centuryon

	}	//	InfoProductPanel

	/**
	 *	initialize fields
	 */
	private void initComponents()
	{
		lblValue = new Label();
		lblValue.setValue(Util.cleanAmp(Msg.translate(Env.getCtx(), "Value")));
		lblName = new Label();
		lblName.setValue(Util.cleanAmp(Msg.translate(Env.getCtx(), "Name")));
		lblUPC =  new Label();
		lblUPC.setValue(Msg.translate(Env.getCtx(), "UPC"));
		lblSKU = new Label();
		lblSKU.setValue(Msg.translate(Env.getCtx(), "SKU"));
		lblPriceList = new Label();
		lblPriceList.setValue(Msg.getMsg(Env.getCtx(), "PriceListVersion"));
		// Elaine 2008/11/21
		lblProductCategory = new Label();
		lblProductCategory.setValue(Msg.translate(Env.getCtx(), "M_Product_Category_ID"));
		//
		lblAS = new Label();
		lblAS.setValue(Msg.translate(Env.getCtx(), "M_AttributeSet_ID"));
		lblWarehouse = new Label();
		lblWarehouse.setValue(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Warehouse")));
		lblVendor = new Label();
		lblVendor.setValue(Msg.translate(Env.getCtx(), "Vendor"));

		m_InfoPAttributeButton.setImage(ThemeManager.getThemeResource("images/PAttribute16.png"));
		m_InfoPAttributeButton.setTooltiptext(Msg.getMsg(Env.getCtx(), "PAttribute"));
		m_InfoPAttributeButton.addEventListener(Events.ON_CLICK,this);

		fieldValue = new Textbox();
		fieldValue.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "value");
		fieldName = new Textbox();
		fieldName.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "name");
		fieldUPC = new Textbox();
		fieldUPC.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "upc");
		fieldSKU = new Textbox();
		fieldSKU.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "sku");
		pickPriceList = new Listbox();
		pickPriceList.setRows(0);
		pickPriceList.setMultiple(false);
		pickPriceList.setMold("select");
		ZKUpdateUtil.setHflex(pickPriceList, "1");
		pickPriceList.addEventListener(Events.ON_SELECT, this);
		pickPriceList.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "priceList");

		// Elaine 2008/11/21
		pickProductCategory = new Listbox();
		pickProductCategory.setRows(0);
		pickProductCategory.setMultiple(false);
		pickProductCategory.setMold("select");
		ZKUpdateUtil.setHflex(pickProductCategory, "1");
		pickProductCategory.addEventListener(Events.ON_SELECT, this);
		pickProductCategory.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "productCategory");
		//
		pickAS = new Listbox();
		pickAS.setRows(0);
		pickAS.setMultiple(false);
		pickAS.setMold("select");
		ZKUpdateUtil.setHflex(pickAS, "1");
		pickAS.addEventListener(Events.ON_SELECT, this);
		pickAS.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "attributeSet");

		pickWarehouse = new Listbox();
		pickWarehouse.setRows(0);
		pickWarehouse.setMultiple(false);
		pickWarehouse.setMold("select");
		ZKUpdateUtil.setHflex(pickWarehouse, "1");
		pickWarehouse.addEventListener(Events.ON_SELECT, this);
		pickWarehouse.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "warehouse");

		fieldVendor = new Textbox();		

        ZKUpdateUtil.setVflex(contentPanel, true);
	}	//	initComponents

	private void init()
	{
    	Grid grid = GridFactory.newGridLayout();

		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lblValue.rightAlign());
		row.appendChild(fieldValue);
		ZKUpdateUtil.setHflex(fieldValue, "1");
		row.appendChild(lblUPC.rightAlign());
		row.appendChild(fieldUPC);
		ZKUpdateUtil.setHflex(fieldUPC, "1");
		row.appendChild(lblWarehouse.rightAlign());
		row.appendChild(pickWarehouse);
		row.appendChild(m_InfoPAttributeButton);

		row = new Row();
		row.appendCellChild(lblName.rightAlign());
		row.appendCellChild(fieldName);
		ZKUpdateUtil.setHflex(fieldName, "1");
		row.appendCellChild(lblSKU.rightAlign());
		row.appendCellChild(fieldSKU);
		ZKUpdateUtil.setHflex(fieldSKU, "1");
		row.appendCellChild(lblVendor.rightAlign());
		row.appendCellChild(fieldVendor);
		rows.appendChild(row);
		ZKUpdateUtil.setHflex(fieldVendor, "1");
		
		//

		row = new Row();
		rows.appendChild(row);
		row.appendChild(lblPriceList.rightAlign());
		row.appendChild(pickPriceList);
		row.appendChild(lblProductCategory.rightAlign());
		row.appendChild(pickProductCategory);
		row.appendChild(lblAS.rightAlign());
		row.appendChild(pickAS);

		row = new Row();
		rows.appendChild(row);
		row.appendCellChild(statusBar, 6);
		statusBar.setEastVisibility(false);
		ZKUpdateUtil.setWidth(statusBar, "100%");

		// Product Attribute Instance
		m_PAttributeButton = confirmPanel.createButton(ConfirmPanel.A_PATTRIBUTE);
		confirmPanel.addComponentsLeft(m_PAttributeButton);
		m_PAttributeButton.addActionListener(this);
		m_PAttributeButton.setEnabled(false);

        // Elaine 2008/11/25
        fieldDescription.setMultiline(true);
		fieldDescription.setReadonly(true);
		ZKUpdateUtil.setHflex(fieldDescription, "1");

		//
        ColumnInfo[] s_layoutWarehouse = new ColumnInfo[]{
        		new ColumnInfo(Msg.translate(Env.getCtx(), "Warehouse"), "Warehouse", String.class),
        		new ColumnInfo(Msg.translate(Env.getCtx(), "QtyAvailable"), "sum(QtyAvailable)", Double.class),
        		new ColumnInfo(Msg.translate(Env.getCtx(), "QtyOnHand"), "sum(QtyOnHand)", Double.class),
        		new ColumnInfo(Msg.translate(Env.getCtx(), "QtyReserved"), "sum(QtyReserved)", Double.class)};
        /**	From Clause							*/
        String s_sqlFrom = " M_PRODUCT_STOCK_V ";
        /** Where Clause						*/
        String s_sqlWhere = "Value = ?";
        m_sqlWarehouse = warehouseTbl.prepareTable(s_layoutWarehouse, s_sqlFrom, s_sqlWhere, false, "M_PRODUCT_STOCK_V");
		m_sqlWarehouse += " GROUP BY Warehouse";
		warehouseTbl.setMultiSelection(false);
		warehouseTbl.setShowTotals(true);
		warehouseTbl.autoSize();
        warehouseTbl.getModel().addTableModelListener(this);

        ColumnInfo[] s_layoutSubstitute = new ColumnInfo[]{
        		new ColumnInfo(Msg.translate(Env.getCtx(), "Warehouse"), "orgname", String.class),
        		new ColumnInfo(
    					Msg.translate(Env.getCtx(), "Value"),
    					"(Select Value from M_Product p where p.M_Product_ID=M_PRODUCT_SUBSTITUTERELATED_V.Substitute_ID)",
    					String.class),
    			new ColumnInfo(Msg.translate(Env.getCtx(), "Name"), "Name", String.class),
    			new ColumnInfo(Msg.translate(Env.getCtx(), "QtyAvailable"), "QtyAvailable", Double.class),
  	        	new ColumnInfo(Msg.translate(Env.getCtx(), "QtyOnHand"), "QtyOnHand", Double.class),
    	        new ColumnInfo(Msg.translate(Env.getCtx(), "QtyReserved"), "QtyReserved", Double.class),
  	        	new ColumnInfo(Msg.translate(Env.getCtx(), "PriceStd"), "PriceStd", Double.class)};
        s_sqlFrom = "M_PRODUCT_SUBSTITUTERELATED_V";
        s_sqlWhere = "M_Product_ID = ? AND M_PriceList_Version_ID = ? and RowType = 'S'";
        m_sqlSubstitute = substituteTbl.prepareTable(s_layoutSubstitute, s_sqlFrom, s_sqlWhere, false, "M_PRODUCT_SUBSTITUTERELATED_V");
        substituteTbl.setMultiSelection(false);
        substituteTbl.autoSize();
        substituteTbl.getModel().addTableModelListener(this);

        ColumnInfo[] s_layoutRelated = new ColumnInfo[]{
        		new ColumnInfo(Msg.translate(Env.getCtx(), "Warehouse"), "orgname", String.class),
        		new ColumnInfo(
    					Msg.translate(Env.getCtx(), "Value"),
    					"(Select Value from M_Product p where p.M_Product_ID=M_PRODUCT_SUBSTITUTERELATED_V.Substitute_ID)",
    					String.class),
    			new ColumnInfo(Msg.translate(Env.getCtx(), "Name"), "Name", String.class),
    			new ColumnInfo(Msg.translate(Env.getCtx(), "QtyAvailable"), "QtyAvailable", Double.class),
  	        	new ColumnInfo(Msg.translate(Env.getCtx(), "QtyOnHand"), "QtyOnHand", Double.class),
    	        new ColumnInfo(Msg.translate(Env.getCtx(), "QtyReserved"), "QtyReserved", Double.class),
  	        	new ColumnInfo(Msg.translate(Env.getCtx(), "PriceStd"), "PriceStd", Double.class)};
        s_sqlFrom = "M_PRODUCT_SUBSTITUTERELATED_V";
        s_sqlWhere = "M_Product_ID = ? AND M_PriceList_Version_ID = ? and RowType = 'R'";
        m_sqlRelated = relatedTbl.prepareTable(s_layoutRelated, s_sqlFrom, s_sqlWhere, false, "M_PRODUCT_SUBSTITUTERELATED_V");
        relatedTbl.setMultiSelection(false);
        relatedTbl.autoSize();
        relatedTbl.getModel().addTableModelListener(this);

        //Available to Promise Tab
        m_tableAtp.setMultiSelection(false);

        //IDEMPIERE-337
        ArrayList<ColumnInfo> list = new ArrayList<ColumnInfo>();
        list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "PriceListVersion"), "plv.Name", String.class));
        list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "ValidFrom"), "plv.ValidFrom", Timestamp.class));
        if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3027/*PriceList*/, false))
        		list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "PriceList"), "bomPriceList(pp.M_Product_ID, pp.M_PriceList_Version_ID) AS PriceList", Double.class));
        if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3028/*PriceStd*/, false))
        		list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "PriceStd"), "bomPriceStd(pp.M_Product_ID, pp.M_PriceList_Version_ID) AS PriceStd", Double.class));
        if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3028/*PriceStd*/, false) && MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3029/*PriceLimit*/, false))
        	list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "Margin"), "bomPriceStd(pp.M_Product_ID, pp.M_PriceList_Version_ID)-bomPriceLimit(pp.M_Product_ID, pp.M_PriceList_Version_ID) AS Margin", Double.class));
        if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3029/*PriceLimit*/, false))
        	list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "PriceLimit"), "bomPriceLimit(pp.M_Product_ID, pp.M_PriceList_Version_ID) AS PriceLimit", Double.class));
        ColumnInfo[] s_layoutProductPrice = new ColumnInfo[list.size()];
        list.toArray(s_layoutProductPrice);
        s_sqlFrom = "M_ProductPrice pp INNER JOIN M_PriceList_Version plv ON (pp.M_PriceList_Version_ID = plv.M_PriceList_Version_ID)";
        s_sqlWhere = "pp.M_Product_ID = ? AND plv.IsActive = 'Y' AND pp.IsActive = 'Y'";
        m_sqlProductprice = productpriceTbl.prepareTable(s_layoutProductPrice, s_sqlFrom, s_sqlWhere, false, "pp") + " ORDER BY plv.ValidFrom DESC";
        productpriceTbl.setMultiSelection(false);
        productpriceTbl.autoSize();
        productpriceTbl.getModel().addTableModelListener(this);
        
        ZKUpdateUtil.setHeight(tabbedPane, "100%");
		Tabpanels tabPanels = new Tabpanels();
		tabbedPane.appendChild(tabPanels);
		Tabs tabs = new Tabs();
		tabbedPane.appendChild(tabs);

		Tab tab = new Tab(Util.cleanAmp(Msg.translate(Env.getCtx(), "Warehouse")));
		tabs.appendChild(tab);
		Tabpanel desktopTabPanel = new Tabpanel();
		ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
		desktopTabPanel.appendChild(warehouseTbl);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.translate(Env.getCtx(), "Description"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
		ZKUpdateUtil.setWidth(fieldDescription, "99%");
		ZKUpdateUtil.setHeight(fieldDescription, "99%");
		desktopTabPanel.appendChild(fieldDescription);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.translate(Env.getCtx(), "Substitute_ID"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
		desktopTabPanel.appendChild(substituteTbl);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.translate(Env.getCtx(), "RelatedProduct_ID"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
		desktopTabPanel.appendChild(relatedTbl);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.getMsg(Env.getCtx(), "ATP"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
		desktopTabPanel.appendChild(m_tableAtp);
		tabPanels.appendChild(desktopTabPanel);
		
		tab = new Tab(Msg.translate(Env.getCtx(), "Price"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
		desktopTabPanel.appendChild(productpriceTbl);
		tabPanels.appendChild(desktopTabPanel);
		//
		int height = SessionManager.getAppDesktop().getClientInfo().desktopHeight * 90 / 100;
		int width = SessionManager.getAppDesktop().getClientInfo().desktopWidth * 80 / 100;

		ZKUpdateUtil.setWidth(borderlayout, "100%");
		ZKUpdateUtil.setHeight(borderlayout, "100%");
        if (isLookup())
        	borderlayout.setStyle("border: none; position: relative; ");
        else
        	borderlayout.setStyle("border: none; position: absolute; ");
        Center center = new Center();
        //true will conflict with listbox scrolling
        center.setAutoscroll(false);
        borderlayout.appendChild(center);
		center.appendChild(contentPanel);
		ZKUpdateUtil.setVflex(contentPanel, "1");
		ZKUpdateUtil.setHflex(contentPanel, "1");
		South south = new South();
		int detailHeight = (height * 25 / 100);
		ZKUpdateUtil.setHeight(south, detailHeight + "px");
		south.setCollapsible(true);
		south.setSplittable(true);
		south.setTitle(Msg.translate(Env.getCtx(), "WarehouseStock"));
		south.setTooltiptext(Msg.translate(Env.getCtx(), "WarehouseStock"));
		borderlayout.appendChild(south);
		tabbedPane.setSclass("info-product-tabbedpane");
		south.appendChild(tabbedPane);
		ZKUpdateUtil.setVflex(tabbedPane, "1");
		ZKUpdateUtil.setHflex(tabbedPane, "1");

        Borderlayout mainPanel = new Borderlayout();
        ZKUpdateUtil.setWidth(mainPanel, "100%");
        ZKUpdateUtil.setHeight(mainPanel, "100%");
        North north = new North();
        mainPanel.appendChild(north);
        north.appendChild(grid);
        center = new Center();
        mainPanel.appendChild(center);
        center.appendChild(borderlayout);
        south = new South();
        mainPanel.appendChild(south);
        south.appendChild(confirmPanel);
        if (!isLookup())
        {
        	mainPanel.setStyle("position: absolute");
        }

		this.appendChild(mainPanel);
		if (isLookup())
		{
			ZKUpdateUtil.setWidth(this, width + "px");
			ZKUpdateUtil.setHeight(this, height + "px");
		}

		contentPanel.addActionListener(new EventListener<Event>() {
			public void onEvent(Event event) throws Exception {
				int row = contentPanel.getSelectedRow();
				if (row >= 0) {
					int M_Warehouse_ID = 0;
					ListItem listitem = pickWarehouse.getSelectedItem();
					if (listitem != null)
						M_Warehouse_ID = (Integer)listitem.getValue();

					int M_PriceList_Version_ID = 0;
					listitem = pickPriceList.getSelectedItem();
					if (listitem != null)
						M_PriceList_Version_ID = (Integer)listitem.getValue();

        			refresh(contentPanel.getValueAt(row,2), M_Warehouse_ID, M_PriceList_Version_ID);
        			borderlayout.getSouth().setOpen(true);
				}
			}
		});
	}

	/**
	 * IDEMPIERE-337
	 * Override InfoPanel.testCount() to allow counting distinct rows
	 * 
	 */
	@Override
	protected boolean testCount() {
		long start = System.currentTimeMillis();
		String dynWhere = getSQLWhere();
		
		int M_Warehouse_ID = 0;
		ListItem listitem = pickWarehouse.getSelectedItem();
		if (listitem != null)
			M_Warehouse_ID = (Integer)listitem.getValue();
		
		StringBuffer where = new StringBuffer();
		where.append("p.IsActive='Y'");
		if (M_Warehouse_ID != 0)
			where.append(" AND p.IsSummary='N'");
		//  dynamic Where Clause
		if (p_whereClause != null && p_whereClause.length() > 0)
			where.append(" AND ")   //  replace fully qualified name with alias
				.append(Util.replace(p_whereClause, "M_Product.", "p."));	
		
		StringBuilder sqlMain = new StringBuilder("SELECT ");
		int colIndex = 0;
		ColumnInfo[] layout = getProductLayout();
		for (colIndex = 0; colIndex < layout.length; colIndex++)
		{
			if (colIndex > 0)
				sqlMain.append(", ");
			sqlMain.append(layout[colIndex].getColSQL());
			if (layout[colIndex].isKeyPairCol())
				sqlMain.append(",").append(layout[colIndex].getKeyPairColSQL());
		}
		
		sqlMain.append(" FROM ").append(s_productFrom);
		sqlMain.append(" WHERE ").append(where);
		
		if (dynWhere.length() > 0)
			sqlMain.append(dynWhere); 
		
		String countSql = Msg.parseTranslation(Env.getCtx(), sqlMain.toString());	//	Variables
		countSql = MRole.getDefault().addAccessSQL	(countSql, getTableName(),
													MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
		String sqlCount = "SELECT COUNT(*) FROM (" + countSql + ") ProductInfo";
		
		log.finer(sqlCount);
		m_count = -1;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;;
		try
		{
			pstmt = DB.prepareStatement(sqlCount, null);
			setParameters (pstmt, false);
			rs = pstmt.executeQuery();
		
			if (rs.next())
				m_count = rs.getInt(1);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sqlCount, e);
			m_count = -2;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		if (log.isLoggable(Level.FINE)) log.fine("#" + m_count + " - " + (System.currentTimeMillis()-start) + "ms");

		return true;
	}
	
	@Override
	protected void insertPagingComponent() {
		North north = new North();
		north.appendChild(paging);
		borderlayout.appendChild(north);
	}

	/**
	 * 	Refresh Query
	 */
	private void refresh(Object obj, int M_Warehouse_ID, int M_PriceList_Version_ID)
	{
		//int M_Product_ID = 0;
		String sql = m_sqlWarehouse;
		log.finest(sql);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, (String)obj);
			rs = pstmt.executeQuery();
			warehouseTbl.loadTable(rs);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		m_M_Product_ID = getSelectedRowKey();
		sql = "SELECT DocumentNote FROM M_Product WHERE M_Product_ID=?";
		fieldDescription.setText(DB.getSQLValueString(null, sql, m_M_Product_ID));

		sql = m_sqlSubstitute;
		log.finest(sql);
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_M_Product_ID);
			pstmt.setInt(2, M_PriceList_Version_ID);
			rs = pstmt.executeQuery();
			substituteTbl.loadTable(rs);
		} catch (Exception e) {
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		sql = m_sqlRelated;
		log.finest(sql);
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_M_Product_ID);
			pstmt.setInt(2, M_PriceList_Version_ID);
			rs = pstmt.executeQuery();
			relatedTbl.loadTable(rs);
		} catch (Exception e) {
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		initAtpTab(M_Warehouse_ID);
		
		//IDEMPIERE-337
		sql = m_sqlProductprice;
		log.fine(sql);
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_M_Product_ID);
			rs = pstmt.executeQuery();
			productpriceTbl.loadTable(rs);
		} catch (Exception e) {
			log.log(Level.WARNING, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}	//	refresh

	/**
	 *	Dynamic Init
	 *
	 * @param M_Warehouse_ID warehouse
	 * @param M_PriceList_ID price list
	 */
	private void initInfo (int M_Warehouse_ID, int M_PriceList_ID)
	{
		//	Pick init
		fillPicks(M_PriceList_ID);
		int M_PriceList_Version_ID = findPLV (M_PriceList_ID);
		//	Set Warehouse
		if (M_Warehouse_ID == 0)
			M_Warehouse_ID = Env.getContextAsInt(Env.getCtx(), Env.M_WAREHOUSE_ID);
		if (M_Warehouse_ID != 0)
			setWarehouse (M_Warehouse_ID);
		// 	Set PriceList Version
		if (M_PriceList_Version_ID != 0)
			setPriceListVersion (M_PriceList_Version_ID);

		//	Create Grid
		String orderBy = null;
		StringBuilder where = new StringBuilder();
		where.append("p.IsActive='Y'");
		if (M_Warehouse_ID != 0)
		{
			where.append(" AND p.IsSummary='N'");
			orderBy = "QtyAvailable DESC";
		}
		//  dynamic Where Clause
		if (p_whereClause != null && p_whereClause.length() > 0)
			where.append(" AND ")   //  replace fully qalified name with alias
				.append(Util.replace(p_whereClause, "M_Product.", "p."));
		//
		prepareTable(getProductLayout(),
			s_productFrom,
			where.toString(),
			orderBy);

	}	//	initInfo

	/**
	 *	Fill Picks with values
	 *
	 * @param M_PriceList_ID price list
	 */
	private void fillPicks (int M_PriceList_ID)
	{
		//	Price List
		String SQL = "SELECT M_PriceList_Version.M_PriceList_Version_ID,"
			+ " M_PriceList_Version.Name || ' (' || c.Iso_Code || ')' AS ValueName "
			+ "FROM M_PriceList_Version, M_PriceList pl, C_Currency c "
			+ "WHERE M_PriceList_Version.M_PriceList_ID=pl.M_PriceList_ID"
			+ " AND pl.C_Currency_ID=c.C_Currency_ID"
			+ " AND M_PriceList_Version.IsActive='Y' AND pl.IsActive='Y'";
		//	Same PL currency as original one
		if (M_PriceList_ID != 0)
			SQL += " AND EXISTS (SELECT * FROM M_PriceList xp WHERE xp.M_PriceList_ID=" + M_PriceList_ID
				+ " AND pl.C_Currency_ID=xp.C_Currency_ID)";
		//	Add Access & Order
		SQL = MRole.getDefault().addAccessSQL (SQL, "M_PriceList_Version", true, false)	// fully qualidfied - RO
			+ " ORDER BY M_PriceList_Version.Name";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pickPriceList.appendItem("",Integer.valueOf(0));
			pstmt = DB.prepareStatement(SQL, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				pickPriceList.appendItem(rs.getString(2),Integer.valueOf(rs.getInt(1)));
			}
			DB.close(rs, pstmt);
			rs = null; pstmt = null;

			//	Warehouse
			SQL = MRole.getDefault().addAccessSQL (
				"SELECT M_Warehouse_ID, Value || ' - ' || Name AS ValueName "
				+ "FROM M_Warehouse "
				+ "WHERE IsActive='Y'",
					"M_Warehouse", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO)
				+ " ORDER BY Value";
			pickWarehouse.appendItem("", Integer.valueOf(0));
			pstmt = DB.prepareStatement(SQL, null);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				pickWarehouse.appendItem(rs.getString("ValueName"), Integer.valueOf(rs.getInt("M_Warehouse_ID")));
			}
			DB.close(rs, pstmt);
			rs = null; pstmt = null;

			// Elaine 2008/11/21
			//	Product Category
			SQL = MRole.getDefault().addAccessSQL (
				"SELECT M_Product_Category_ID, Value || ' - ' || Name FROM M_Product_Category WHERE IsActive='Y'",
					"M_Product_Category", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO)
				+ " ORDER BY Value";
			for (KeyNamePair kn : DB.getKeyNamePairs(SQL, true)) {
				pickProductCategory.addItem(kn);
			}

			//	Attribute Sets
			SQL = MRole.getDefault().addAccessSQL (
				"SELECT M_AttributeSet_ID, Name FROM M_AttributeSet WHERE IsActive='Y'",
					"M_AttributeSet", MRole.SQL_NOTQUALIFIED, MRole.SQL_RO)
				+ " ORDER BY Name";
			for (KeyNamePair kn : DB.getKeyNamePairs(SQL, true)) {
				pickAS.addItem(kn);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, SQL, e);
			setStatusLine(e.getLocalizedMessage(), true);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}	//	fillPicks

	/**
	 *	Set Warehouse
	 *
	 * 	@param M_Warehouse_ID warehouse
	 */
	private void setWarehouse(int M_Warehouse_ID)
	{
		for (int i = 0; i < pickWarehouse.getItemCount(); i++)
		{
			 Integer key = (Integer) pickWarehouse.getItemAtIndex(i).getValue();
			if (key == M_Warehouse_ID)
			{
				pickWarehouse.setSelectedIndex(i);
				return;
			}
		}
	}	//	setWarehouse

	/**
	 *	Set PriceList
	 *
	 * @param M_PriceList_Version_ID price list
	 */
	private void setPriceListVersion(int M_PriceList_Version_ID)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("M_PriceList_Version_ID=" + M_PriceList_Version_ID);
		for (int i = 0; i < pickPriceList.getItemCount(); i++)
		{
			Integer key = (Integer) pickPriceList.getItemAtIndex(i).getValue();
			if (key == M_PriceList_Version_ID)
			{
				pickPriceList.setSelectedIndex(i);
				return;
			}
		}
		log.fine("NOT found");
	}	//	setPriceList

	/**
	 *	Find Price List Version and update context
	 *
	 * @param M_PriceList_ID price list
	 * @return M_PriceList_Version_ID price list version
	 */
	private int findPLV (int M_PriceList_ID)
	{
		Timestamp priceDate = null;
		//	Sales Order Date
		String dateStr = Env.getContext(Env.getCtx(), p_WindowNo, "DateOrdered");
		if (dateStr != null && dateStr.length() > 0)
			priceDate = Env.getContextAsDate(Env.getCtx(), p_WindowNo, "DateOrdered");
		else	//	Invoice Date
		{
			dateStr = Env.getContext(Env.getCtx(), p_WindowNo, "DateInvoiced");
			if (dateStr != null && dateStr.length() > 0)
				priceDate = Env.getContextAsDate(Env.getCtx(), p_WindowNo, "DateInvoiced");
		}
		//	Today
		if (priceDate == null)
			priceDate = new Timestamp(System.currentTimeMillis());
		//
		if (log.isLoggable(Level.CONFIG)) log.config("M_PriceList_ID=" + M_PriceList_ID + " - " + priceDate);
		int retValue = 0;
		String sql = "SELECT plv.M_PriceList_Version_ID, plv.ValidFrom "
			+ "FROM M_PriceList pl, M_PriceList_Version plv "
			+ "WHERE pl.M_PriceList_ID=plv.M_PriceList_ID"
			+ " AND plv.IsActive='Y'"
			+ " AND pl.M_PriceList_ID=? "					//	1
			+ "ORDER BY plv.ValidFrom DESC";
		//	find newest one
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, M_PriceList_ID);
			rs = pstmt.executeQuery();
			while (rs.next() && retValue == 0)
			{
				Timestamp plDate = rs.getTimestamp(2);
				if (!priceDate.before(plDate))
					retValue = rs.getInt(1);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		Env.setContext(Env.getCtx(), p_WindowNo, "M_PriceList_Version_ID", retValue);
		return retValue;
	}	//	findPLV


	/**************************************************************************
	 *	Construct SQL Where Clause and define parameters
	 *  (setParameters needs to set parameters)
	 *  Includes first AND
	 *  @return SQL WHERE clause
	 */
	public String getSQLWhere()
	{
		StringBuilder where = new StringBuilder();

		//	Optional PLV
		int M_PriceList_Version_ID = 0;
		ListItem listitem = pickPriceList.getSelectedItem();
		if (listitem != null)
			M_PriceList_Version_ID = (Integer)listitem.getValue();
		if (M_PriceList_Version_ID != 0)
			where.append(" AND pr.M_PriceList_Version_ID=?");

		// Elaine 2008/11/29
		//  Optional Product Category
		if (getM_Product_Category_ID() > 0) {
			where.append(" AND p.M_Product_Category_ID=?");
		}
		//

		//  Optional Attribute Set
		if (getM_AttributeSet_ID() > 0) {
			where.append(" AND p.M_AttributeSet_ID=?");
		}

		//	Product Attribute Search
		if (m_pAttributeWhere != null)
		{
			where.append(m_pAttributeWhere);
			return where.toString();
		}

		//  => Value
		String value = fieldValue.getText().toUpperCase();
		if (!(value.equals("") || value.equals("%")))
			where.append(" AND UPPER(p.Value) LIKE ?");

		//  => Name
		String name = fieldName.getText().toUpperCase();
		if (!(name.equals("") || name.equals("%")))
			where.append(" AND UPPER(p.Name) LIKE ?");

		//  => UPC
		String upc = fieldUPC.getText().toUpperCase();
		if (!(upc.equals("") || upc.equals("%")))
			where.append(" AND UPPER(p.UPC) LIKE ?");

		//  => SKU
		String sku = fieldSKU.getText().toUpperCase();
		if (!(sku.equals("") || sku.equals("%")))
			where.append(" AND UPPER(p.SKU) LIKE ?");
		//	=> Vendor
		String vendor = fieldVendor.getText().toUpperCase();
		if (!(vendor.equals("") || vendor.equals("%")))
			where.append(" AND UPPER(bp.Name) LIKE ? AND ppo.IsCurrentVendor='Y' AND ppo.IsActive='Y'"); // Elaine 2008/12/16

		return where.toString();
	}	//	getSQLWhere

	/**
	 *  Set Parameters for Query
	 *  (as defined in getSQLWhere)	 *
	 * @param pstmt pstmt
	 *  @param forCount for counting records
	 * @throws SQLException
	 */
	protected void setParameters(PreparedStatement pstmt, boolean forCount) throws SQLException
	{
		int index = 1;

		//  => Warehouse
		int M_Warehouse_ID = 0;
		ListItem listitem = pickWarehouse.getSelectedItem();
		if (listitem != null)
			M_Warehouse_ID = (Integer)listitem.getValue();
		if (!forCount)	//	parameters in select
		{
			for (int i = 0; i < p_layout.length; i++)
			{
				if (p_layout[i].getColSQL().indexOf('?') != -1)
					pstmt.setInt(index++, M_Warehouse_ID);
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine("M_Warehouse_ID=" + M_Warehouse_ID + " (" + (index-1) + "*)");

		//  => PriceList
		int M_PriceList_Version_ID = 0;
		ListItem lstitem = pickPriceList.getSelectedItem();
		if (lstitem != null)
			M_PriceList_Version_ID = (Integer)lstitem.getValue();
		if (M_PriceList_Version_ID != 0)
		{
			pstmt.setInt(index++, M_PriceList_Version_ID);
			if (log.isLoggable(Level.FINE)) log.fine("M_PriceList_Version_ID=" + M_PriceList_Version_ID);
		}
		// Elaine 2008/11/29
		//  => Product Category
		int M_Product_Category_ID = getM_Product_Category_ID();
		if (M_Product_Category_ID > 0) {
			pstmt.setInt(index++, M_Product_Category_ID);
			if (log.isLoggable(Level.FINE)) log.fine("M_Product_Category_ID=" + M_Product_Category_ID);
		}
		//
		int M_AttributeSet_ID = getM_AttributeSet_ID();
		if (M_AttributeSet_ID > 0) {
			pstmt.setInt(index++, M_AttributeSet_ID);
			if (log.isLoggable(Level.FINE)) log.fine("M_AttributeSet_ID=" + M_AttributeSet_ID);
		}
		//	Rest of Parameter in Query for Attribute Search
		if (m_pAttributeWhere != null)
			return;

		//  => Value
		String value = fieldValue.getText().toUpperCase();
		if (!(value.equals("") || value.equals("%")))
		{
			if (!value.endsWith("%"))
				value += "%";
			pstmt.setString(index++, value);
			if (log.isLoggable(Level.FINE)) log.fine("Value: " + value);
		}

		//  => Name
		String name = fieldName.getText().toUpperCase();
		if (!(name.equals("") || name.equals("%")))
		{
			if (!name.endsWith("%"))
				name += "%";
			pstmt.setString(index++, name);
			if (log.isLoggable(Level.FINE)) log.fine("Name: " + name);
		}

		//  => UPC
		String upc = fieldUPC.getText().toUpperCase();
		if (!(upc.equals("") || upc.equals("%")))
		{
			if (!upc.endsWith("%"))
				upc += "%";
			pstmt.setString(index++, upc);
			if (log.isLoggable(Level.FINE)) log.fine("UPC: " + upc);
		}

		//  => SKU
		String sku = fieldSKU.getText().toUpperCase();
		if (!(sku.equals("") || sku.equals("%")))
		{
			if (!sku.endsWith("%"))
				sku += "%";
			pstmt.setString(index++, sku);
			if (log.isLoggable(Level.FINE)) log.fine("SKU: " + sku);
		}

		//  => Vendor
		String vendor = fieldVendor.getText().toUpperCase();
		if (!(vendor.equals("") || vendor.equals("%")))
		{
			if (!vendor.endsWith("%"))
				vendor += "%";
			pstmt.setString(index++, vendor);
			if (log.isLoggable(Level.FINE)) log.fine("Vendor: " + vendor);
		}
	}   //  setParameters

	/**
	 * 	Query per Product Attribute.
	 *  <code>
	 * 	Available synonyms:
	 *		M_Product p
	 *		M_ProductPrice pr
	 *		M_AttributeSet pa
	 *	</code>
	 */
	private void cmd_InfoPAttribute()
	{
		final InfoPAttributePanel ia = new InfoPAttributePanel(this);
		ia.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				m_pAttributeWhere = ia.getWhereClause();
				if (m_pAttributeWhere != null)
				{
					executeQuery();
					renderItems();
				}
			}
		});
		
	}	//	cmdInfoAttribute

	/**
	 *	Show History
	 */
	protected void showHistory()
	{
		log.info("");
		Integer M_Product_ID = getSelectedRowKey();
		if (M_Product_ID == null)
			return;
		int M_Warehouse_ID = 0;
		ListItem listitem = pickWarehouse.getSelectedItem();
		if (listitem != null)
			M_Warehouse_ID = (Integer)listitem.getValue();
		int M_AttributeSetInstance_ID = m_M_AttributeSetInstance_ID;
		if (m_M_AttributeSetInstance_ID < -1)	//	not selected
			M_AttributeSetInstance_ID = 0;
		//
		InvoiceHistory ih = new InvoiceHistory (this, 0,
			M_Product_ID.intValue(), M_Warehouse_ID, M_AttributeSetInstance_ID);
		ih.setVisible(true);
		ih = null;
	}	//	showHistory

	/**
	 *	Has History
	 *
	 * @return true (has history)
	 */
	protected boolean hasHistory()
	{
		return true;
	}	//	hasHistory

	// Elaine 2008/12/16
	/**
	 *	Zoom
	 */
	public void zoom()
	{
		log.info("");
		Integer M_Product_ID = getSelectedRowKey();
		if (M_Product_ID == null)
			return;

		MQuery query = new MQuery("M_Product");
		query.addRestriction("M_Product_ID", MQuery.EQUAL, M_Product_ID);
		query.setRecordCount(1);
		int AD_WindowNo = getAD_Window_ID("M_Product", true);	//	SO
		AEnv.zoom (AD_WindowNo, query);
	}	//	zoom
	//

	/**
	 *	Has Zoom
	 *  @return (has zoom)
	 */
	protected boolean hasZoom()
	{
		return true;
	}	//	hasZoom

	/**
	 *	Customize
	 */
	protected void customize()
	{
		log.info("");
	}	//	customize

	/**
	 *	Has Customize
	 *  @return false (no customize)
	 */
	protected boolean hasCustomize()
	{
		return false;	//	for now
	}	//	hasCustomize

	/**
	 *	Save Selection Settings for PriceList
	 */
	protected void saveSelectionDetail()
	{
		//  publish for Callout to read
		Integer ID = getSelectedRowKey();
		Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "M_Product_ID", ID == null ? "0" : ID.toString());
		ListItem pickPL = (ListItem)pickPriceList.getSelectedItem();
		if (pickPL!=null)
		{
            Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "M_PriceList_Version_ID",pickPL.getValue().toString());
        }
		ListItem pickWH = (ListItem)pickWarehouse.getSelectedItem();
		if (pickWH != null)
        {
            Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "M_Warehouse_ID",pickWH.getValue().toString());
        }
		//
		if (m_M_AttributeSetInstance_ID == -1)	//	not selected
		{
			Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID", "0");
			Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "M_Locator_ID", "0");
		}
		else
		{
			Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "M_AttributeSetInstance_ID",
				String.valueOf(m_M_AttributeSetInstance_ID));
			Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, "M_Locator_ID",
				String.valueOf(m_M_Locator_ID));
		}
	}	//	saveSelectionDetail

	/**
	 *  Get Product Layout
	 *
	 * @return array of Column_Info
	 */
	protected ColumnInfo[] getProductLayout()
	{
		// IDEMPIERE-337 - zkwebui - Improve Info Product window 
		//if (s_productLayout != null && s_productLayoutRole == MRole.getDefault().getAD_Role_ID())
		//	return s_productLayout;
		//
		s_productLayout = null;
		int M_Warehouse_ID = 0;
		ListItem listitem = pickWarehouse.getSelectedItem();
		if (listitem != null)
			M_Warehouse_ID = (Integer)listitem.getValue();
		int M_PriceList_ID = 0;
		listitem = pickPriceList.getSelectedItem();
		if (listitem != null)
			M_PriceList_ID = (Integer)listitem.getValue();
		
				
		ArrayList<ColumnInfo> list = new ArrayList<ColumnInfo>();
		list.add(new ColumnInfo(" ", "DISTINCT p.M_Product_ID", IDColumn.class));
		list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "Discontinued").substring(0, 1), "p.Discontinued", Boolean.class));
		list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "Value"), "p.Value", String.class));
		list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "Name"), "p.Name", String.class));
		// IDEMPIERE-337
		if (M_Warehouse_ID != 0)
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "QtyAvailable"), "bomQtyAvailable(p.M_Product_ID,?,0) AS QtyAvailable", Double.class, true, true, null));
		if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3027/*PriceList*/, false) && M_PriceList_ID != 0)
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "PriceList"), "bomPriceList(p.M_Product_ID, pr.M_PriceList_Version_ID) AS PriceList",  BigDecimal.class));
		if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3028/*PriceStd*/, false) && M_PriceList_ID != 0)
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "PriceStd"), "bomPriceStd(p.M_Product_ID, pr.M_PriceList_Version_ID) AS PriceStd", BigDecimal.class));
		if (M_Warehouse_ID != 0)
		{
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "QtyOnHand"), "bomQtyOnHand(p.M_Product_ID,?,0) AS QtyOnHand", Double.class));
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "QtyReserved"), "bomQtyReserved(p.M_Product_ID,?,0) AS QtyReserved", Double.class));
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "QtyOrdered"), "bomQtyOrdered(p.M_Product_ID,?,0) AS QtyOrdered", Double.class));
			if (isUnconfirmed())
			{
				list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "QtyUnconfirmed"), "(SELECT SUM(c.TargetQty) FROM M_InOutLineConfirm c INNER JOIN M_InOutLine il ON (c.M_InOutLine_ID=il.M_InOutLine_ID) INNER JOIN M_InOut i ON (il.M_InOut_ID=i.M_InOut_ID) WHERE c.Processed='N' AND i.M_Warehouse_ID=? AND il.M_Product_ID=p.M_Product_ID) AS QtyUnconfirmed", Double.class));
				list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "QtyUnconfirmedMove"), "(SELECT SUM(c.TargetQty) FROM M_MovementLineConfirm c INNER JOIN M_MovementLine ml ON (c.M_MovementLine_ID=ml.M_MovementLine_ID) INNER JOIN M_Locator l ON (ml.M_LocatorTo_ID=l.M_Locator_ID) WHERE c.Processed='N' AND l.M_Warehouse_ID=? AND ml.M_Product_ID=p.M_Product_ID) AS QtyUnconfirmedMove", Double.class));
			}
		}
		if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3028/*PriceStd*/, false) && MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3029/*PriceLimit*/, false) && M_PriceList_ID != 0)
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "Margin"), "bomPriceStd(p.M_Product_ID, pr.M_PriceList_Version_ID)-bomPriceLimit(p.M_Product_ID, pr.M_PriceList_Version_ID) AS Margin", BigDecimal.class));
		list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "Vendor"), "bp.Name", String.class));
		if (MRole.getDefault().isColumnAccess(251 /*M_ProductPrice*/, 3029/*PriceLimit*/, false) && M_PriceList_ID != 0)
			list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "PriceLimit"), "bomPriceLimit(p.M_Product_ID, pr.M_PriceList_Version_ID) AS PriceLimit", BigDecimal.class));
		list.add(new ColumnInfo(Msg.translate(Env.getCtx(), "IsInstanceAttribute"), "pa.IsInstanceAttribute", Boolean.class));
		s_productLayout = new ColumnInfo[list.size()];
		list.toArray(s_productLayout);
		INDEX_NAME = 3;
		INDEX_PATTRIBUTE = s_productLayout.length - 1;	//	last item

		return s_productLayout;
	}   //  getProductLayout

	/**
	 * 	System has Unforfirmed records
	 *	@return true if unconfirmed
	 */
	private boolean isUnconfirmed()
	{
		int no = DB.getSQLValue(null,
			"SELECT COUNT(*) FROM M_InOutLineConfirm WHERE AD_Client_ID=?",
			Env.getAD_Client_ID(Env.getCtx()));
		if (no > 0)
			return true;
		no = DB.getSQLValue(null,
			"SELECT COUNT(*) FROM M_MovementLineConfirm WHERE AD_Client_ID=?",
			Env.getAD_Client_ID(Env.getCtx()));
		return no > 0;
	}	//	isUnconfirmed

    public void onEvent(Event e)
    {
    	Component component = e.getTarget();

    	// Elaine 2008/12/16
		//  don't requery if fieldValue and fieldName are empty
    	// IDEMPIERE-337 - zkwebui - Improve Info Product window 
		if (e.getTarget() == pickWarehouse || e.getTarget() == pickPriceList)
		{
			boolean execute = true;
			if (fieldValue.getText().length() == 0 && fieldName.getText().length() == 0 && contentPanel.getRowCount() == 0)
				execute = false;
			// Remove existing headers
			if (contentPanel.getListhead() != null)
				contentPanel.getListhead().detach();
			//	Create Grid
			int M_Warehouse_ID = 0;
			ListItem listitem = pickWarehouse.getSelectedItem();
			if (listitem != null)
				M_Warehouse_ID = (Integer)listitem.getValue();
			StringBuilder where = new StringBuilder();
			where.append("p.IsActive='Y'");
			if (M_Warehouse_ID != 0)
				where.append(" AND p.IsSummary='N'");
			//  dynamic Where Clause
			if (p_whereClause != null && p_whereClause.length() > 0)
				where.append(" AND ")   //  replace fully qalified name with alias
					.append(Util.replace(p_whereClause, "M_Product.", "p."));
			//
			prepareTable(getProductLayout(),
				s_productFrom,
				where.toString(),
				"");
			if (!execute)
				return;
		}

    	if(component == m_InfoPAttributeButton)
    	{
    		cmd_InfoPAttribute();
    		return;
    	}

    	m_pAttributeWhere = null;
    	// Query Product Attribure Instance
    	int row = contentPanel != null ? contentPanel.getSelectedRow() : -1;
		if (component.equals(m_PAttributeButton) && row != -1)
		{
			Integer productInteger = getSelectedRowKey();
			String productName = (String)contentPanel.getValueAt(row, INDEX_NAME);

			ListItem warehouse = pickWarehouse.getSelectedItem();
			if (productInteger == null || productInteger.intValue() == 0 || warehouse == null)
				return;

			int M_Warehouse_ID = 0;
			if(warehouse.getValue() != null)
				M_Warehouse_ID = ((Integer)warehouse.getValue()).intValue();

			String title = warehouse.getLabel() + " - " + productName;
			final InfoPAttributeInstancePanel pai = new InfoPAttributeInstancePanel(this, title,
				M_Warehouse_ID, 0, productInteger.intValue(), m_C_BPartner_ID);
			pai.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {

				@Override
				public void onEvent(Event event) throws Exception {
					m_M_AttributeSetInstance_ID = pai.getM_AttributeSetInstance_ID();
					m_M_Locator_ID = pai.getM_Locator_ID();
					if (m_M_AttributeSetInstance_ID != -1)
						dispose(true);
				}
			});
			
			return;
		}
		//
		super.onEvent(e);
    }

	/**
	 *  Enable PAttribute if row selected/changed
	 */
	protected void enableButtons ()
	{
		m_M_AttributeSetInstance_ID = -1;
		if (m_PAttributeButton != null)
		{
			int row = contentPanel.getSelectedRow();
			boolean enabled = false;
			if (row >= 0)
			{
				Object value = contentPanel.getValueAt(row, INDEX_PATTRIBUTE);
				enabled = Boolean.TRUE.equals(value);
			}
			m_PAttributeButton.setEnabled(enabled);
		}

		super.enableButtons();
	}   //  enableButtons

    // Elaine 2008/11/26
	/**
	 *	Query ATP
	 */
	private void initAtpTab (int  m_M_Warehouse_ID)
	{
		//	Header
		Vector<String> columnNames = new Vector<String>();
		columnNames.add(Msg.translate(Env.getCtx(), "Date"));
		columnNames.add(Msg.translate(Env.getCtx(), "QtyOnHand"));
		columnNames.add(Msg.translate(Env.getCtx(), "C_BPartner_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "QtyOrdered"));
		columnNames.add(Msg.translate(Env.getCtx(), "QtyReserved"));
		columnNames.add(Msg.translate(Env.getCtx(), "M_Locator_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "M_AttributeSetInstance_ID"));
		columnNames.add(Msg.translate(Env.getCtx(), "DocumentNo"));
		columnNames.add(Msg.translate(Env.getCtx(), "M_Warehouse_ID"));

		//	Fill Storage Data
		boolean showDetail = CLogMgt.isLevelFine();
		String sql = "SELECT s.QtyOnHand, s.QtyReserved, s.QtyOrdered,"
			+ " productAttribute(s.M_AttributeSetInstance_ID), s.M_AttributeSetInstance_ID,";
		if (!showDetail)
			sql = "SELECT SUM(s.QtyOnHand), SUM(s.QtyReserved), SUM(s.QtyOrdered),"
				+ " productAttribute(s.M_AttributeSetInstance_ID), 0,";
		sql += " w.Name, l.Value "
			+ "FROM M_Storage s"
			+ " INNER JOIN M_Locator l ON (s.M_Locator_ID=l.M_Locator_ID)"
			+ " INNER JOIN M_Warehouse w ON (l.M_Warehouse_ID=w.M_Warehouse_ID) "
			+ "WHERE M_Product_ID=?";
		if (m_M_Warehouse_ID != 0)
			sql += " AND l.M_Warehouse_ID=?";
		if (m_M_AttributeSetInstance_ID > 0)
			sql += " AND s.M_AttributeSetInstance_ID=?";
		sql += " AND (s.QtyOnHand<>0 OR s.QtyReserved<>0 OR s.QtyOrdered<>0)";
		if (!showDetail)
			sql += " GROUP BY productAttribute(s.M_AttributeSetInstance_ID), w.Name, l.Value";
		sql += " ORDER BY l.Value";

		Vector<Vector<Object>> data = new Vector<Vector<Object>>();
		double qty = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_M_Product_ID);
			if (m_M_Warehouse_ID != 0)
				pstmt.setInt(2, m_M_Warehouse_ID);
			if (m_M_AttributeSetInstance_ID > 0)
				pstmt.setInt(3, m_M_AttributeSetInstance_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>(9);
				line.add(null);							//  Date
				double qtyOnHand = rs.getDouble(1);
				qty += qtyOnHand;
				line.add(Double.valueOf(qtyOnHand));  		//  Qty
				line.add(null);							//  BPartner
				line.add(Double.valueOf(rs.getDouble(3)));  //  QtyOrdered
				line.add(Double.valueOf(rs.getDouble(2)));  //  QtyReserved
				line.add(rs.getString(7));      		//  Locator
				String asi = rs.getString(4);
				if (showDetail && (asi == null || asi.length() == 0))
					asi = "{" + rs.getInt(5) + "}";
				line.add(asi);							//  ASI
				line.add(null);							//  DocumentNo
				line.add(rs.getString(6));  			//	Warehouse
				data.add(line);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//	Orders
		sql = "SELECT o.DatePromised, ol.QtyReserved,"
			+ " productAttribute(ol.M_AttributeSetInstance_ID), ol.M_AttributeSetInstance_ID,"
			+ " dt.DocBaseType, bp.Name,"
			+ " dt.PrintName || ' ' || o.DocumentNo As DocumentNo, w.Name "
			+ "FROM C_Order o"
			+ " INNER JOIN C_OrderLine ol ON (o.C_Order_ID=ol.C_Order_ID)"
			+ " INNER JOIN C_DocType dt ON (o.C_DocType_ID=dt.C_DocType_ID)"
			+ " INNER JOIN M_Warehouse w ON (ol.M_Warehouse_ID=w.M_Warehouse_ID)"
			+ " INNER JOIN C_BPartner bp  ON (o.C_BPartner_ID=bp.C_BPartner_ID) "
			+ "WHERE ol.QtyReserved<>0"
			+ " AND ol.M_Product_ID=?";
		if (m_M_Warehouse_ID != 0)
			sql += " AND ol.M_Warehouse_ID=?";
		if (m_M_AttributeSetInstance_ID > 0)
			sql += " AND ol.M_AttributeSetInstance_ID=?";
		sql += " ORDER BY o.DatePromised";
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_M_Product_ID);
			if (m_M_Warehouse_ID != 0)
				pstmt.setInt(2, m_M_Warehouse_ID);
			if (m_M_AttributeSetInstance_ID > 0)
				pstmt.setInt(3, m_M_AttributeSetInstance_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				Vector<Object> line = new Vector<Object>(9);
				line.add(rs.getTimestamp(1));			//  Date
				double oq = rs.getDouble(2);
				String DocBaseType = rs.getString(5);
				Double qtyReserved = null;
				Double qtyOrdered = null;
				if (MDocType.DOCBASETYPE_PurchaseOrder.equals(DocBaseType))
				{
					qtyOrdered = Double.valueOf(oq);
					qty += oq;
				}
				else
				{
					qtyReserved = Double.valueOf(oq);
					qty -= oq;
				}
				line.add(Double.valueOf(qty)); 		 		//  Qty
				line.add(rs.getString(6));				//  BPartner
				line.add(qtyOrdered);					//  QtyOrdered
				line.add(qtyReserved);					//  QtyReserved
				line.add(null);				      		//  Locator
				String asi = rs.getString(3);
				if (showDetail && (asi == null || asi.length() == 0))
					asi = "{" + rs.getInt(4) + "}";
				line.add(asi);							//  ASI
				line.add(rs.getString(7));				//  DocumentNo
				line.add(rs.getString(8));  			//	Warehouse
				data.add(line);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		//  Table
		ListModelTable model = new ListModelTable(data);
		m_tableAtp.setData(model, columnNames);
		//
		m_tableAtp.setColumnClass(0, Timestamp.class, true);   //  Date
		m_tableAtp.setColumnClass(1, Double.class, true);      //  Quantity
		m_tableAtp.setColumnClass(2, String.class, true);      //  Partner
		m_tableAtp.setColumnClass(3, Double.class, true);      //  Quantity
		m_tableAtp.setColumnClass(4, Double.class, true);      //  Quantity
		m_tableAtp.setColumnClass(5, String.class, true);   	  //  Locator
		m_tableAtp.setColumnClass(6, String.class, true);   	  //  ASI
		m_tableAtp.setColumnClass(7, String.class, true);      //  DocNo
		m_tableAtp.setColumnClass(8, String.class, true);   	  //  Warehouse
		//
		m_tableAtp.autoSize();
	}	//	initAtpTab
	//

    // Elaine 2008/11/21
    public int getM_Product_Category_ID()
    {
		int M_Product_Category_ID = 0;

		ListItem pickPC = (ListItem)pickProductCategory.getSelectedItem();
		if (pickPC!=null)
			M_Product_Category_ID = Integer.parseInt(pickPC.getValue().toString());

		return M_Product_Category_ID;
	}
    //

    public int getM_AttributeSet_ID()
    {
		int M_AttributeSet_ID = 0;

		ListItem itemAS = (ListItem)pickAS.getSelectedItem();
		if (itemAS!=null)
			M_AttributeSet_ID = Integer.parseInt(itemAS.getValue().toString());

		return M_AttributeSet_ID;
	}
}	//	InfoProduct
