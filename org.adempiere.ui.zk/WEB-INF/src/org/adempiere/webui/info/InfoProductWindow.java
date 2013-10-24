/**
 * 
 */
package org.adempiere.webui.info;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.ListboxFactory;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.panel.InfoPAttributeInstancePanel;
import org.adempiere.webui.panel.InvoiceHistory;
import org.adempiere.webui.session.SessionManager;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.model.MDocType;
import org.compiere.model.MRole;
import org.compiere.util.CLogMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.SwipeEvent;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;

/**
 * @author hengsin
 *
 */
public class InfoProductWindow extends InfoWindow {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4939032152860189380L;

	private Tabbox tabbedPane;
	private WListbox warehouseTbl;
    private String m_sqlWarehouse;
    private WListbox substituteTbl;
    private String m_sqlSubstitute;
    private WListbox relatedTbl;
    private String m_sqlRelated;
    //Available to Promise Tab
	private WListbox m_tableAtp;
	
	//IDEMPIERE-337
    private WListbox productpriceTbl;
    private String m_sqlProductprice;
    
    private Textbox fieldDescription;
    
    /** ASI							*/
	private int	m_M_AttributeSetInstance_ID;

	private Borderlayout contentBorderLayout;
	
	/** Instance Button				*/
	private Button	m_PAttributeButton;

	protected int m_M_Locator_ID;
	
	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 */
	public InfoProductWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID) {
		this(WindowNo, tableName, keyColumn, queryValue, multipleSelection, whereClause, AD_InfoWindow_ID, true);
	}

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 * @param lookup
	 */
	public InfoProductWindow(int WindowNo, String tableName, String keyColumn,
			String queryValue, boolean multipleSelection, String whereClause,
			int AD_InfoWindow_ID, boolean lookup) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup);
	}

	@Override
	protected String getSQLWhere() {
		StringBuilder where = new StringBuilder(super.getSQLWhere());
		if (getSelectedWarehouseId() > 0) {
			if (where.length() > 0) {
				where.append(" AND ");
			}
			where.append("p.IsSummary='N' ");
		}
		return where.toString();
	}

	@Override
	protected void createParameterPanel() {
		super.createParameterPanel();
		initParameters();
	}

	@Override
	protected void renderWindow() {
		super.renderWindow();
		// Product Attribute Instance
		m_PAttributeButton = confirmPanel.createButton(ConfirmPanel.A_PATTRIBUTE);
		confirmPanel.addComponentsLeft(m_PAttributeButton);
		m_PAttributeButton.setEnabled(false);
		m_PAttributeButton.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				onPAttributeClick();
			}
		});
		m_PAttributeButton.setVisible(true);
	}

	@Override
	protected void renderContentPane(Center center) {
		ColumnInfo[] s_layoutWarehouse = new ColumnInfo[]{
        		new ColumnInfo(Msg.translate(Env.getCtx(), "Warehouse"), "Warehouse", String.class),
        		new ColumnInfo(Msg.translate(Env.getCtx(), "QtyAvailable"), "sum(QtyAvailable)", Double.class),
        		new ColumnInfo(Msg.translate(Env.getCtx(), "QtyOnHand"), "sum(QtyOnHand)", Double.class),
        		new ColumnInfo(Msg.translate(Env.getCtx(), "QtyReserved"), "sum(QtyReserved)", Double.class)};
        /**	From Clause							*/
        String s_sqlFrom = " M_PRODUCT_STOCK_V ";
        /** Where Clause						*/
        String s_sqlWhere = "M_Product_ID = ?";
        warehouseTbl = ListboxFactory.newDataTable();
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
        substituteTbl = ListboxFactory.newDataTable();
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
        relatedTbl = ListboxFactory.newDataTable();
        m_sqlRelated = relatedTbl.prepareTable(s_layoutRelated, s_sqlFrom, s_sqlWhere, false, "M_PRODUCT_SUBSTITUTERELATED_V");
        relatedTbl.setMultiSelection(false);
        relatedTbl.autoSize();
        relatedTbl.getModel().addTableModelListener(this);

        //Available to Promise Tab
        m_tableAtp = ListboxFactory.newDataTable();
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
        productpriceTbl = ListboxFactory.newDataTable();
        m_sqlProductprice = productpriceTbl.prepareTable(s_layoutProductPrice, s_sqlFrom, s_sqlWhere, false, "pp") + " ORDER BY plv.ValidFrom DESC";
        productpriceTbl.setMultiSelection(false);
        productpriceTbl.autoSize();
        productpriceTbl.getModel().addTableModelListener(this);
        
        tabbedPane = new Tabbox();
        tabbedPane.setHeight("100%");
		Tabpanels tabPanels = new Tabpanels();
		tabbedPane.appendChild(tabPanels);
		Tabs tabs = new Tabs();
		tabbedPane.appendChild(tabs);

		Tab tab = new Tab(Util.cleanAmp(Msg.translate(Env.getCtx(), "Warehouse")));
		tabs.appendChild(tab);
		Tabpanel desktopTabPanel = new Tabpanel();
		desktopTabPanel.setHeight("100%");
		desktopTabPanel.appendChild(warehouseTbl);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.translate(Env.getCtx(), "Description"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		desktopTabPanel.setHeight("100%");
		fieldDescription = new Textbox();
		fieldDescription.setMultiline(true);
		fieldDescription.setReadonly(true);
		fieldDescription.setHflex("1");
		fieldDescription.setWidth("99%");
		fieldDescription.setHeight("99%");
		desktopTabPanel.appendChild(fieldDescription);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.translate(Env.getCtx(), "Substitute_ID"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		desktopTabPanel.setHeight("100%");
		desktopTabPanel.appendChild(substituteTbl);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.translate(Env.getCtx(), "RelatedProduct_ID"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		desktopTabPanel.setHeight("100%");
		desktopTabPanel.appendChild(relatedTbl);
		tabPanels.appendChild(desktopTabPanel);

		tab = new Tab(Msg.getMsg(Env.getCtx(), "ATP"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		desktopTabPanel.setHeight("100%");
		desktopTabPanel.appendChild(m_tableAtp);
		tabPanels.appendChild(desktopTabPanel);
		
		tab = new Tab(Msg.translate(Env.getCtx(), "Price"));
		tabs.appendChild(tab);
		desktopTabPanel = new Tabpanel();
		desktopTabPanel.setHeight("100%");
		desktopTabPanel.appendChild(productpriceTbl);
		tabPanels.appendChild(desktopTabPanel);
		//
		int height = SessionManager.getAppDesktop().getClientInfo().desktopHeight * 90 / 100;
		
		contentBorderLayout = new Borderlayout();
		contentBorderLayout.setWidth("100%");
        contentBorderLayout.setHeight("100%");
        if (isLookup())
        	contentBorderLayout.setStyle("border: none; position: relative; ");
        else
        	contentBorderLayout.setStyle("border: none; position: absolute; ");
        contentBorderLayout.appendCenter(contentPanel);
        //true will conflict with listbox scrolling
        contentBorderLayout.getCenter().setAutoscroll(false);
        South south = new South();
		int detailHeight = (height * 25 / 100);
		south.setHeight(detailHeight + "px");
		south.setCollapsible(true);
		south.setSplittable(true);
		south.setTitle(Msg.translate(Env.getCtx(), "WarehouseStock"));
		south.setTooltiptext(Msg.translate(Env.getCtx(), "WarehouseStock"));
		south.addEventListener(Events.ON_SWIPE, new EventListener<SwipeEvent>() {
			@Override
			public void onEvent(SwipeEvent event) throws Exception {
				South south = (South) event.getTarget();
				if ("down".equals(event.getSwipeDirection())) {
					south.setOpen(false);
				}
			}
		});
		south.setSclass("south-collapsible-with-title");
		contentBorderLayout.appendChild(south);
		tabbedPane.setSclass("info-product-tabbedpane");
		south.appendChild(tabbedPane);
		tabbedPane.setVflex("1");
		tabbedPane.setHflex("1");
		
		center.appendChild(contentBorderLayout);
		
		contentPanel.addActionListener(new EventListener<Event>() {
			public void onEvent(Event event) throws Exception {
				int row = contentPanel.getSelectedRow();
				if (row >= 0) {
					int M_Warehouse_ID = getSelectedWarehouseId();

					int M_PriceList_Version_ID = getSelectedPriceListVersionId();

					for(int i = 0; i < columnInfos.length; i++) {
						if (columnInfos[i].getGridField() != null && columnInfos[i].getGridField().getColumnName().equals("Value")) {
							refresh(M_Warehouse_ID, M_PriceList_Version_ID);
		        			contentBorderLayout.getSouth().setOpen(true);
		        			break;
						}
					}
					
					Object value = contentPanel.getValueAt(row, findColumnIndex("IsInstanceAttribute"));
					if (value != null && value.toString().equals("true")) {
						m_PAttributeButton.setEnabled(true);
					} else {
						m_PAttributeButton.setEnabled(false);
					}
				}
			}
		});
	}

	private void onPAttributeClick() {
		Integer productInteger = getSelectedRowKey();
		if (productInteger == null) {
			m_PAttributeButton.setEnabled(false);
			return;
		}
		String productName = (String)contentPanel.getValueAt(contentPanel.getSelectedRow(), findColumnIndex("Name"));

		if (productInteger == null || productInteger.intValue() == 0)
			return;

		int M_Warehouse_ID = getSelectedWarehouseId();
		if (M_Warehouse_ID <= 0)
			return;

		String title = getSelectedWarehouseLabel() + " - " + productName;
		int C_BPartner_ID = Env.getContextAsInt(Env.getCtx(), p_WindowNo, "C_BPartner_ID");;
		final InfoPAttributeInstancePanel pai = new InfoPAttributeInstancePanel(this, title,
			M_Warehouse_ID, 0, productInteger.intValue(), C_BPartner_ID);
		pai.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				m_M_AttributeSetInstance_ID = pai.getM_AttributeSetInstance_ID();
				m_M_Locator_ID = pai.getM_Locator_ID();
			}
		});
	}
	
	private String getSelectedWarehouseLabel() {
		for(WEditor editor : editors) {
			if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("M_Warehouse_ID")) {
				Number value = (Number) editor.getValue();
				if (value != null)
					return editor.getDisplay();
				
				break;
			}
		}
		return "";
	}

	protected int getSelectedPriceListVersionId() {
		for(WEditor editor : editors) {
			if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("M_PriceList_Version_ID")) {
				Number value = (Number) editor.getValue();
				if (value != null)
					return value.intValue();
				
				break;
			}
		}
		return 0;
	}

	protected int getSelectedWarehouseId() {
		for(WEditor editor : editors) {
			if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("M_Warehouse_ID")) {
				Number value = (Number) editor.getValue();
				if (value != null)
					return value.intValue();
				
				break;
			}
		}
		return 0;
	}

	private void initParameters() {		
		int M_Warehouse_ID = Env.getContextAsInt(Env.getCtx(), p_WindowNo, "M_Warehouse_ID");
		int M_PriceList_ID = Env.getContextAsInt(Env.getCtx(), p_WindowNo, "M_PriceList_ID");
		
		int M_PriceList_Version_ID = findPLV (M_PriceList_ID);
		//	Set Warehouse
		if (M_Warehouse_ID == 0)
			M_Warehouse_ID = Env.getContextAsInt(Env.getCtx(), "#M_Warehouse_ID");
		if (M_Warehouse_ID != 0)
			setWarehouse (M_Warehouse_ID);
		// 	Set PriceList Version
		if (M_PriceList_Version_ID != 0)
			setPriceListVersion (M_PriceList_Version_ID);
	}
	
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
		return retValue;
	}	//	findPLV
	
	/**
	 *	Set Warehouse
	 *
	 * 	@param M_Warehouse_ID warehouse
	 */
	private void setWarehouse(int M_Warehouse_ID)
	{
		for(WEditor editor : editors) {
			if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("M_Warehouse_ID")) {
				editor.setValue(M_Warehouse_ID);
				Env.setContext(infoContext, p_WindowNo, "M_Warehouse_ID", M_Warehouse_ID);
				Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO, "M_Warehouse_ID", Integer.toString(M_Warehouse_ID));
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
		
		for(WEditor editor : editors) {
			if (editor.getGridField() != null && editor.getGridField().getColumnName().equals("M_PriceList_Version_ID")) {
				editor.setValue(M_PriceList_Version_ID);
				Env.setContext(infoContext, p_WindowNo, "M_PriceList_Version_ID", M_PriceList_Version_ID);
				Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO, "M_PriceList_Version_ID", Integer.toString(M_PriceList_Version_ID));
				return;
			}
		}
		
		if (log.isLoggable(Level.FINE))
			log.fine("NOT found");
	}	//	setPriceListVersion
	
	/**
	 * 	Refresh Query
	 */
	private void refresh(int M_Warehouse_ID, int M_PriceList_Version_ID)
	{
		int m_M_Product_ID = getSelectedRowKey();
		String sql = m_sqlWarehouse;
		if (log.isLoggable(Level.FINEST)) log.finest(sql);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_M_Product_ID);
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

		sql = "SELECT DocumentNote FROM M_Product WHERE M_Product_ID=?";
		fieldDescription.setText(DB.getSQLValueString(null, sql, m_M_Product_ID));

		sql = m_sqlSubstitute;
		if (log.isLoggable(Level.FINEST)) log.finest(sql);
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
		if (log.isLoggable(Level.FINEST)) log.finest(sql);
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
		initAtpTab(M_Warehouse_ID, m_M_Product_ID);
		
		//IDEMPIERE-337
		sql = m_sqlProductprice;
		if (log.isLoggable(Level.FINEST)) log.finest(sql);
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
	
	// Elaine 2008/11/26
	/**
	 *	Query ATP
	 * @param m_M_Warehouse_ID
	 * @param m_M_Product_ID 
	 */
	private void initAtpTab (int  m_M_Warehouse_ID, int m_M_Product_ID)
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
				line.add(new Double(qtyOnHand));  		//  Qty
				line.add(null);							//  BPartner
				line.add(new Double(rs.getDouble(3)));  //  QtyOrdered
				line.add(new Double(rs.getDouble(2)));  //  QtyReserved
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
					qtyOrdered = new Double(oq);
					qty += oq;
				}
				else
				{
					qtyReserved = new Double(oq);
					qty -= oq;
				}
				line.add(new Double(qty)); 		 		//  Qty
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

	@Override
	protected void showHistory() {
		log.info("");
		Integer M_Product_ID = getSelectedRowKey();
		if (M_Product_ID == null)
			return;
		int M_Warehouse_ID = getSelectedWarehouseId();
		int M_AttributeSetInstance_ID = m_M_AttributeSetInstance_ID;
		if (m_M_AttributeSetInstance_ID < -1)	//	not selected
			M_AttributeSetInstance_ID = 0;
		//
		InvoiceHistory ih = new InvoiceHistory (this, 0,
			M_Product_ID.intValue(), M_Warehouse_ID, M_AttributeSetInstance_ID);
		ih.setVisible(true);
		ih = null;
	}

	@Override
	protected boolean hasHistory() {
		return true;
	}

	@Override
	protected void saveSelectionDetail() {
		super.saveSelectionDetail();
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
	}

	@Override
	protected void prepareTable(ColumnInfo[] layout, String from, String where,
			String orderBy) {
		if (getSelectedWarehouseId() > 0)
		{
			orderBy = "QtyAvailable DESC";
		}
		super.prepareTable(layout, from, where, orderBy);
	}

	@Override
	protected void executeQuery() {
		super.executeQuery();
		if (m_PAttributeButton != null)
			m_PAttributeButton.setEnabled(false);
	}
	
	
}
