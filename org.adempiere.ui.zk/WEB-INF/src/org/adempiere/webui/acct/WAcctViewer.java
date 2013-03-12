/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd. All Rights Reserved.                     *
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

package org.adempiere.webui.acct;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.util.Callback;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.VerticalBox;
import org.adempiere.webui.component.WListItemRenderer;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MColumn;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.model.X_C_AcctSchema_Element;
import org.compiere.report.core.RModel;
import org.compiere.report.core.RModelExcelExporter;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Center;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Groupbox;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Listhead;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Paging;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;

/**
 *  Account Viewer : Based on class AcctViewer
 *
 *  @author Niraj Sohun
 *  		July 27, 2007
 *
 *  @author Elaine Tan
 *  @author Low Heng Sin
 */

public class WAcctViewer extends Window implements EventListener<Event>
{
	private static final String TITLE = "Posting";

	/**
	 *
	 */
	private static final long serialVersionUID = -223185724918504685L;

	private static final int PAGE_SIZE = 1000;

	/** State Info          */
	private WAcctViewerData	m_data = null;

	private Listbox selAcctSchema = new Listbox();
	private Listbox selTable = new Listbox();
	private Listbox selPostingType = new Listbox();
	private Listbox selOrg = new Listbox();
	private Listbox sortBy1 = new Listbox();
	private Listbox sortBy2 = new Listbox();
	private Listbox sortBy3 = new Listbox();
	private Listbox sortBy4 = new Listbox();

	private Button selRecord = new Button();
	private Button selAcct = new Button();
	private Button bQuery = new Button();
	private Button bRePost = new Button();
	private Button bExport = new Button();
	private Button bZoom = new Button(); // Elaine 2009/07/29
	private Button sel1 = new Button();
	private Button sel2 = new Button();
	private Button sel3 = new Button();
	private Button sel4 = new Button();
	private Button sel5 = new Button();
	private Button sel6 = new Button();
	private Button sel7 = new Button();
	private Button sel8 = new Button();

	private Label statusLine = new Label();
	private Label lsel1 = new Label();
	private Label lsel2 = new Label();
	private Label lsel3 = new Label();
	private Label lsel4 = new Label();
	private Label lsel5 = new Label();
	private Label lsel6 = new Label();
	private Label lsel7 = new Label();
	private Label lsel8 = new Label();

	private Label lacctSchema = new Label();
	private Label lpostingType = new Label();
	private Label lOrg = new Label();
	private Label lAcct = new Label();
	private Label lDate = new Label();
	private Label lSort = new Label();
	private Label lGroup = new Label();

	private Datebox selDateFrom = new Datebox();
	private Datebox selDateTo = new Datebox();

	private Checkbox selDocument = new Checkbox();
	private Checkbox displayQty = new Checkbox();
	private Checkbox displaySourceAmt = new Checkbox();
	private Checkbox displayDocumentInfo = new Checkbox();
	private Checkbox group1 = new Checkbox();
	private Checkbox group2 = new Checkbox();
	private Checkbox group3 = new Checkbox();
	private Checkbox group4 = new Checkbox();
	private Checkbox forcePost = new Checkbox();

	private Tabbox tabbedPane = new Tabbox();

	private Listbox table = new Listbox();
	private Paging paging = new Paging();

	private VerticalBox displayPanel = new VerticalBox();
	private VerticalBox selectionPanel = new VerticalBox();

	private Tab tabQuery = new Tab();
	private Tab tabResult = new Tab();
	private Tabs tabs = new Tabs();
	private Tabpanel result = new Tabpanel();
	private Tabpanel query = new Tabpanel();
	private Tabpanels tabpanels = new Tabpanels();

	private Hlayout southPanel = new Hlayout();

	private int m_windowNo;

	private ArrayList<ArrayList<Object>> m_queryData;

	private South pagingPanel;

	private Borderlayout resultPanel;

	private RModel m_rmodel;

	/**	Logger				*/
	private static CLogger log = CLogger.getCLogger(WAcctViewer.class);

	/**
	 *  Default constructor
	 */

	public WAcctViewer()
	{
		this (0, 0, 0);
	} // AcctViewer

	/**
	 *  Detail Constructor
	 *
	 *  @param AD_Client_ID Client
	 *  @param AD_Table_ID Table
	 *  @param Record_ID Record
	 */

	public WAcctViewer(int AD_Client_ID, int AD_Table_ID, int Record_ID)
	{
		super ();

		log.info("AD_Table_ID=" + AD_Table_ID + ", Record_ID=" + Record_ID);

		//setDefaultCloseOperation(DISPOSE_ON_CLOSE);
		m_windowNo = SessionManager.getAppDesktop().registerWindow(this);
		m_data = new WAcctViewerData (Env.getCtx(), m_windowNo, AD_Client_ID, AD_Table_ID);

		try
		{
			init();
			dynInit (AD_Table_ID, Record_ID);
			setAttribute(MODE_KEY, MODE_EMBEDDED);
			AEnv.showWindow(this);
		}
		catch(Exception e)
		{
			log.log(Level.SEVERE, "", e);
			//dispose();
		}
	} // AcctViewer

	/**
	 *  Static Init.
	 *  <pre>
	 *  - mainPanel
	 *      - tabbedPane
	 *          - query
	 *          - result
	 *          - graphPanel
	 *  </pre>
	 *  @throws Exception
	 */

	private void init() throws Exception
	{
		// Selection Panel
		selectionPanel.setHflex("1");
			// Accounting Schema
		
		Grid grid = new Grid();
		grid.setHflex("1");
		grid.setSclass("grid-layout");
		
		selectionPanel.appendChild(grid);
		
		Columns columns = new Columns();
		grid.appendChild(columns);
		Column column = new Column();
		column.setWidth("30%");
		columns.appendChild(column);
		column = new Column();
		columns.appendChild(column);
		
		Rows rows = grid.newRows();

		lacctSchema.setValue(Msg.translate(Env.getCtx(), "C_AcctSchema_ID"));
		selAcctSchema.setMold("select");
		selAcctSchema.setRows(1);

		Row row = rows.newRow();
		row.appendChild(lacctSchema);
		row.appendChild(selAcctSchema);

		selDocument.setLabel(Msg.getMsg(Env.getCtx(), "SelectDocument"));
		selDocument.addEventListener(Events.ON_CHECK, this);
		selTable.setMold("select");
		selTable.setRows(1);

		row = rows.newRow();
		row.appendChild(selDocument);
		Hlayout hlayout = new Hlayout();
		hlayout.appendChild(selTable);
		hlayout.appendChild(selRecord);
		row.appendChild(hlayout);		

			// Posting Type

		lpostingType.setValue(Msg.translate(Env.getCtx(), "PostingType"));
		selPostingType.setMold("select");
		selPostingType.setRows(1);
		selPostingType.addEventListener(Events.ON_CLICK, this);

		row = rows.newRow();
		row.appendChild(lpostingType);
		row.appendChild(selPostingType);

			// Date

		lDate.setValue(Msg.translate(Env.getCtx(), "DateAcct"));

		row = rows.newRow();
		row.appendChild(lDate);
		hlayout = new Hlayout();
		hlayout.appendChild(selDateFrom);		
		hlayout.appendChild(new Label(" - "));
		hlayout.appendChild(selDateTo);
		row.appendChild(hlayout);

			// Organization

		lOrg.setValue(Msg.translate(Env.getCtx(), "AD_Org_ID"));
		selOrg.setMold("select");
		selOrg.setRows(1);
		selOrg.addEventListener(Events.ON_SELECT, this);

		row = rows.newRow();
		row.appendChild(lOrg);
		row.appendChild(selOrg);

			// Account

		lAcct.setValue(Msg.translate(Env.getCtx(), "Account_ID"));

		row = rows.newRow();
		row.appendChild(lAcct);
		row.appendChild(selAcct);

		row = rows.newRow();
		row.appendChild(lsel1);
		row.appendChild(sel1);

		row = rows.newRow();
		row.appendChild(lsel2);
		row.appendChild(sel2);

		row = rows.newRow();
		row.appendChild(lsel3);
		row.appendChild(sel3);

		row = rows.newRow();
		row.appendChild(lsel4);
		row.appendChild(sel4);

		row = rows.newRow();
		row.appendChild(lsel5);
		row.appendChild(sel5);

		row = rows.newRow();
		row.appendChild(lsel6);
		row.appendChild(sel6);

		row = rows.newRow();
		row.appendChild(lsel7);
		row.appendChild(sel7);

		row = rows.newRow();
		row.appendChild(lsel8);
		row.appendChild(sel8);
		
		//Display Panel

			// Display Document Info

		displayDocumentInfo.setLabel(Msg.getMsg(Env.getCtx(), "DisplayDocumentInfo"));
		displayDocumentInfo.addEventListener(Events.ON_CLICK, this);

			// Display Source Info

		displaySourceAmt.setLabel(Msg.getMsg(Env.getCtx(), "DisplaySourceInfo"));
		displaySourceAmt.addEventListener(Events.ON_CHECK, this);

			// Display Quantity

		displayQty.setLabel(Msg.getMsg(Env.getCtx(), "DisplayQty"));
		displayQty.addEventListener(Events.ON_CHECK, this);

		displayPanel.setWidth("100%");
		displayPanel.appendChild(displayDocumentInfo);
		displayPanel.appendChild(displaySourceAmt);
		displayPanel.appendChild(displayQty);
		
		grid = new Grid();
		grid.setSclass("grid-layout");
		grid.setHflex("1");
		displayPanel.appendChild(grid);
		columns = new Columns();
		grid.appendChild(columns);
		column = new Column();
		column.setWidth("70%");
		columns.appendChild(column);
		column = new Column();
		column.setWidth("30%");
		columns.appendChild(column);

		rows = grid.newRows();
		row = rows.newRow();
		lSort.setValue(Msg.getMsg(Env.getCtx(), "SortBy"));
		lGroup.setValue(Msg.getMsg(Env.getCtx(), "GroupBy"));
		row.appendChild(lSort);
		row.appendChild(lGroup);

		row = rows.newRow();		
		sortBy1.setMold("select");
		sortBy1.setRows(1);
		row.appendChild(sortBy1);
		row.appendChild(group1);

		row = rows.newRow();
		sortBy2.setMold("select");
		sortBy2.setRows(1);
		row.appendChild(sortBy2);
		row.appendChild(group2);

		row = rows.newRow();
		sortBy3.setMold("select");
		sortBy3.setRows(1);
		row.appendChild(sortBy3);
		row.appendChild(group3);

		row = rows.newRow();
		sortBy4.setMold("select");
		sortBy4.setRows(1);
		row.appendChild(sortBy4);
		row.appendChild(group4);

		//"images/InfoAccount16.png"

		Groupbox groupDisplay = new Groupbox();
		Caption capDisplay = new Caption("Display");
		groupDisplay.appendChild(capDisplay);
		groupDisplay.appendChild(displayPanel);

		Groupbox groupSelection = new Groupbox();
		Caption capSelection = new Caption("Selection");
		groupSelection.appendChild(capSelection);
		groupSelection.appendChild(selectionPanel);

		Hlayout boxQueryPanel = new Hlayout();
		boxQueryPanel.setHflex("3");

		boxQueryPanel.appendChild(groupSelection);
		groupSelection.setHflex("2");
		Separator separator = new Separator();
		separator.setOrient("vertical");
		boxQueryPanel.appendChild(separator);
		boxQueryPanel.appendChild(groupDisplay);
		groupDisplay.setHflex("1");

		//  South Panel

		bRePost.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "RePost")));
		bRePost.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "RePostInfo")));
		bRePost.addEventListener(Events.ON_CLICK, this);
		bRePost.setVisible(false);

		forcePost.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Force")));
		forcePost.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ForceInfo")));
		forcePost.setVisible(false);

		// Elaine 2009/07/29
		bZoom.setImage(ThemeManager.getThemeResource(ThemeManager.getThemeResource("images/Zoom16.png")));
		bZoom.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Zoom")));
		bZoom.setVisible(tabbedPane.getSelectedIndex() == 1);
		bZoom.addEventListener(Events.ON_CLICK, this);
		//
		
		bQuery.setImage(ThemeManager.getThemeResource(ThemeManager.getThemeResource("images/Refresh16.png")));
		bQuery.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Refresh")));
		bQuery.addEventListener(Events.ON_CLICK, this);

		bExport.setImage(ThemeManager.getThemeResource(ThemeManager.getThemeResource("images/Export16.png")));
		bExport.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Export")));
		bExport.addEventListener(Events.ON_CLICK, this);
		bExport.setVisible(false);

		southPanel.setHflex("5");
		Grid southLeftGrid = new Grid();
		southLeftGrid.setSclass("grid-layout");
		southPanel.appendChild(southLeftGrid);
		southLeftGrid.setHflex("4");
		rows = southLeftGrid.newRows();
		Row southLeft = rows.newRow();
		Hlayout repostLayout = new Hlayout();
		southLeft.appendChild(repostLayout);
		repostLayout.appendChild(bRePost);
		repostLayout.appendChild(new Separator());
		repostLayout.appendChild(forcePost);
		repostLayout.setHeight("24px");
		southLeft.appendChild(statusLine);
		
		Grid southRight = new Grid();
		southRight.setSclass("grid-layout");
		southRight.setHflex("1");
		southPanel.appendChild(southRight);
		Panel southRightPanel = new Panel();
		southRightPanel.appendChild(bZoom); // Elaine 2009/07/29
		southRightPanel.appendChild(bExport);
		southRightPanel.appendChild(bQuery);
		rows = southRight.newRows();
		row = rows.newRow();
		row.setAlign("right");
		row.appendChild(southRightPanel);

		// Result Tab

		resultPanel = new Borderlayout();
		resultPanel.setStyle("position: absolute");
		resultPanel.setWidth("99%");
		resultPanel.setHeight("99%");
		result.appendChild(resultPanel);

		Center resultCenter = new Center();
		resultPanel.appendChild(resultCenter);
		table.setHflex("1");
		table.setVflex(true);
		table.setHeight("99%");
		table.setStyle("position: absolute;");
		resultCenter.appendChild(table);
		table.setHflex("1");
		table.setVflex("1");

		pagingPanel = new South();
		resultPanel.appendChild(pagingPanel);
		pagingPanel.appendChild(paging);

		result.setHflex("1");
		result.setHeight("100%");
		result.setStyle("position: relative");

		paging.addEventListener("onPaging", this);
		paging.setAutohide(true);
		paging.setDetailed(true);

		// Query Tab

		query.setHflex("1");
		query.appendChild(boxQueryPanel);

		// Tabbox

		tabQuery.addEventListener(Events.ON_SELECT, this);
		tabQuery.setLabel(Msg.getMsg(Env.getCtx(), "ViewerQuery").replaceAll("[&]", ""));

		tabResult.addEventListener(Events.ON_SELECT, this);
		tabResult.setLabel(Msg.getMsg(Env.getCtx(), "ViewerResult").replaceAll("[&]", ""));

		tabs.appendChild(tabQuery);
		tabs.appendChild(tabResult);

		tabpanels.setHflex("1");
		tabpanels.appendChild(query);
		tabpanels.appendChild(result);

		tabbedPane.setHflex("1");
		tabbedPane.setVflex("1");
		tabbedPane.appendChild(tabs);
		tabbedPane.appendChild(tabpanels);

		Borderlayout layout = new Borderlayout();
		layout.setParent(this);
		layout.setHeight("100%");
		layout.setWidth("100%");
		layout.setStyle("background-color: transparent; margin: 0; position: absolute; padding: 0;");

		Center center = new Center();
		center.setParent(layout);
		center.setStyle("background-color: transparent; padding: 2px;");
		tabbedPane.setParent(center);
		tabbedPane.setHflex("1");
		tabbedPane.setVflex("1");

		South south = new South();
		south.setParent(layout);
		south.setStyle("background-color: transparent");
		south.setHeight("36px");
		southPanel.setParent(south);
		southPanel.setVflex("1");
		southPanel.setHflex("1");

		this.setTitle(TITLE);
		this.setClosable(true);
		this.setStyle("position: absolute; width: 100%; height: 100%;");
		this.setSizable(true);
		this.setMaximizable(true);
	}

	/**
	 *  Dynamic Init
	 *
	 *  @param AD_Table_ID table
	 *  @param Record_ID record
	 */

	private void dynInit (int AD_Table_ID, int Record_ID)
	{
		m_data.fillAcctSchema(selAcctSchema );
		selAcctSchema.addEventListener(Events.ON_SELECT, this);

		selAcctSchema.setSelectedIndex(0);
		actionAcctSchema();

		m_data.fillTable(selTable);
		selTable.addEventListener(Events.ON_SELECT, this);

		selRecord.setImage(ThemeManager.getThemeResource("images/Find16.png"));
		selRecord.addEventListener(Events.ON_CLICK, this);
		selRecord.setLabel("");

		m_data.fillPostingType(selPostingType);
		selPostingType.setSelectedIndex(0);

		//  Mandatory Elements

		m_data.fillOrg(selOrg);
		selAcct.setName("Account_ID");
		selAcct.addEventListener(Events.ON_CLICK, this);
		selAcct.setLabel("");
		selAcct.setImage(ThemeManager.getThemeResource("images/Find16.png"));

		statusLine.setValue(" " + Msg.getMsg(Env.getCtx(), "ViewerOptions"));

		//  Initial Query
		selOrg.setSelectedIndex(0);
		sortBy1.setSelectedIndex(0);
		sortBy2.setSelectedIndex(0);
		sortBy3.setSelectedIndex(0);
		sortBy4.setSelectedIndex(0);

		//  Document Select
		boolean haveDoc = (AD_Table_ID != 0 && Record_ID != 0);
		selDocument.setChecked(haveDoc);
		actionDocument();
		if (!haveDoc)
		{
			selTable.setSelectedIndex(0);
			actionTable();
		}
		else
		{
			if (setSelectedTable(AD_Table_ID, Record_ID))
			{
				actionQuery();
			}
			else
			{
				//reset
				haveDoc = false;
				selDocument.setChecked(haveDoc);
				actionDocument();
				selTable.setSelectedIndex(0);
				actionTable();
			}
		}

		if (tabResult.isSelected())
			stateChanged();
	} // dynInit

	private boolean setSelectedTable(int AD_Table_ID, int Record_ID)
	{
		int cnt = selTable.getItemCount();
		ValueNamePair vp = null;
		for (int i = 0; i < cnt; i++)
		{
			Listitem listitem = selTable.getItemAtIndex(i);
			vp = (ValueNamePair)listitem.getValue();
			int tableId = (Integer)m_data.tableInfo.get(vp.getValue());
			if (tableId == AD_Table_ID)
			{
				selTable.setSelectedIndex(i);
				m_data.AD_Table_ID = AD_Table_ID;

				//  Reset Record
				m_data.Record_ID = Record_ID;
				selRecord.setLabel("");
				selRecord.setName(vp.getValue() + "_ID");
				return true;
			}
		}
		return false;
	}

	/**
	 *  Dispose
	 */

	public void dispose()
	{
		m_data.dispose();
		m_data = null;
		this.detach();
	} // dispose;

	/**************************************************************************
	 *  Tab Changed
	 *  @param e ChangeEvent
	 */

	public void stateChanged()
	{
	//	log.info( "AcctViewer.stateChanged");
		boolean visible = m_data.documentQuery && tabResult.isSelected();

		bRePost.setVisible(visible);
		bExport.setVisible(tabResult.isSelected());
		bZoom.setVisible(tabResult.isSelected());

		if (Ini.isPropertyBool(Ini.P_SHOW_ADVANCED))
			forcePost.setVisible(visible);
	}   //  stateChanged

	/**
	 *  Event Performed (Event Listener)
	 *  @param e Event
	 */

	public void onEvent(Event e) throws Exception
	{
		// log.info(e.getActionCommand());

		Object source = e.getTarget();

		if (source == tabResult)
			stateChanged();
		else if (source == tabQuery)
			stateChanged();
		else if (source == selAcctSchema)
			actionAcctSchema();
		else if (source == bQuery)
			actionQuery();
		else if (source == selDocument)
			actionDocument();
		else if (source == selTable)
			actionTable();
		else if (source == bRePost)
			actionRePost();
		else if  (source == bExport)
			actionExport();
		// Elaine 2009/07/29
		else if (source == bZoom)
			actionZoom();
		//
		//  InfoButtons
		else if (source instanceof Button)
			actionButton((Button)source);
		else if (source == paging)
		{
			int pgno = paging.getActivePage();
			int start = pgno * PAGE_SIZE;
			int end = start + PAGE_SIZE;
			if ( end > paging.getTotalSize())
				end = paging.getTotalSize();
			List<ArrayList<Object>> list = m_queryData.subList(start, end);
			ListModelTable model = new ListModelTable(list);
			table.setModel(model);
		}
	} // onEvent

	private void actionExport() {
		if (m_rmodel != null && m_rmodel.getRowCount() > 0) {
			RModelExcelExporter exporter = new RModelExcelExporter(m_rmodel);
			File file;
			try {
				file = new File(FileUtil.getTempMailName(TITLE, ".xls"));
				exporter.export(file, Env.getLanguage(Env.getCtx()));
				Filedownload.save(file, "application/vnd.ms-excel");
			} catch (Exception e) {
				throw new RuntimeException(e);
			}			
		}
		
	}

	/**
	 * 	New Acct Schema
	 */

	private void actionAcctSchema()
	{
		Listitem listitem = selAcctSchema.getSelectedItem();

		KeyNamePair kp = null;

		if (listitem != null)
			kp = (KeyNamePair)listitem.getValue();

		if (kp == null)
			return;

		m_data.C_AcctSchema_ID = kp.getKey();
		m_data.ASchema = MAcctSchema.get(Env.getCtx(), m_data.C_AcctSchema_ID);

		log.info(m_data.ASchema.toString());

		//  Sort Options

		sortBy1.getChildren().clear();
		sortBy2.getChildren().clear();
		sortBy3.getChildren().clear();
		sortBy4.getChildren().clear();

		sortAddItem(new ValueNamePair("",""));
		sortAddItem(new ValueNamePair("DateAcct", Msg.translate(Env.getCtx(), "DateAcct")));
		sortAddItem(new ValueNamePair("DateTrx", Msg.translate(Env.getCtx(), "DateTrx")));
		sortAddItem(new ValueNamePair("C_Period_ID", Msg.translate(Env.getCtx(), "C_Period_ID")));

		Label[] labels = new Label[] {lsel1, lsel2, lsel3, lsel4, lsel5, lsel6, lsel7, lsel8};
		Button[] buttons = new Button[] {sel1 , sel2, sel3, sel4, sel5, sel6, sel7, sel8};

		int selectionIndex = 0;

		MAcctSchemaElement[] elements = m_data.ASchema.getAcctSchemaElements();

		for (int i = 0; i < elements.length && selectionIndex < labels.length; i++)
		{
			MAcctSchemaElement ase = elements[i];
			String columnName = ase.getColumnName();
			String displayColumnName = ase.getDisplayColumnName();

			//  Add Sort Option

			sortAddItem(new ValueNamePair(columnName, Msg.translate(Env.getCtx(), displayColumnName)));

			//  Additional Elements

			if (!ase.isElementType(X_C_AcctSchema_Element.ELEMENTTYPE_Organization)
				&& !ase.isElementType(X_C_AcctSchema_Element.ELEMENTTYPE_Account))
			{
				labels[selectionIndex].setValue(Msg.translate(Env.getCtx(), displayColumnName));
				labels[selectionIndex].setVisible(true);
				buttons[selectionIndex].setName(columnName); // actionCommand
				buttons[selectionIndex].addEventListener(Events.ON_CLICK, this);
				buttons[selectionIndex].setImage(ThemeManager.getThemeResource("images/Find16.png"));
				buttons[selectionIndex].setLabel("");
				buttons[selectionIndex].setVisible(true);
				selectionIndex++;
			}
		}

		//	don't show remaining

		while (selectionIndex < labels.length)
		{
			labels[selectionIndex].setVisible(false);
			buttons[selectionIndex++].setVisible(false);
		}
	} // actionAcctSchema

	/**
	 * 	Add to Sort
	 *	@param vn name pair
	 */

	private void sortAddItem(ValueNamePair vn)
	{
		sortBy1.appendItem(vn.getName(), vn);
		sortBy2.appendItem(vn.getName(), vn);
		sortBy3.appendItem(vn.getName(), vn);
		sortBy4.appendItem(vn.getName(), vn);
	} // sortAddItem

	/**
	 *  Query
	 */

	private void actionQuery()
	{
		//  Parameter Info

		StringBuilder para = new StringBuilder();

		//  Reset Selection Data

		m_data.C_AcctSchema_ID = 0;
		m_data.AD_Org_ID = 0;

		//  Save Selection Choices

		Listitem listitem = selAcctSchema.getSelectedItem();

		KeyNamePair kp = null;

		if (listitem != null)
			kp = (KeyNamePair)listitem.getValue();

		if (kp != null)
			m_data.C_AcctSchema_ID = kp.getKey();

		para.append("C_AcctSchema_ID=").append(m_data.C_AcctSchema_ID);

		listitem = selPostingType.getSelectedItem();

		ValueNamePair vp = null;

		if (listitem != null)
			vp = (ValueNamePair)listitem.getValue();
		else
			return;

		m_data.PostingType = vp.getValue();
		para.append(", PostingType=").append(m_data.PostingType);

		//  Document

		m_data.documentQuery = selDocument.isChecked();
		para.append(", DocumentQuery=").append(m_data.documentQuery);

		if (selDocument.isChecked())
		{
			if (m_data.AD_Table_ID == 0 || m_data.Record_ID == 0)
				return;

			para.append(", AD_Table_ID=").append(m_data.AD_Table_ID)
				.append(", Record_ID=").append(m_data.Record_ID);
		}
		else
		{
			m_data.DateFrom = selDateFrom.getValue() != null
				? new Timestamp(selDateFrom.getValue().getTime()) : null;
			para.append(", DateFrom=").append(m_data.DateFrom);
			m_data.DateTo = selDateTo.getValue() != null
				? new Timestamp(selDateTo.getValue().getTime()) : null;
			para.append(", DateTo=").append(m_data.DateTo);

			listitem = selOrg.getSelectedItem();

			if (listitem != null)
				kp = (KeyNamePair)listitem.getValue();
			else
				kp = null;

			if (kp != null)
				m_data.AD_Org_ID = kp.getKey();
			para.append(", AD_Org_ID=").append(m_data.AD_Org_ID);
			//
			Iterator<String> it = m_data.whereInfo.values().iterator();
			while (it.hasNext())
				para.append(", ").append(it.next());
		}

		//  Save Display Choices

		m_data.displayQty = displayQty.isChecked();
		para.append(" - Display Qty=").append(m_data.displayQty);
		m_data.displaySourceAmt = displaySourceAmt.isChecked();
		para.append(", Source=").append(m_data.displaySourceAmt);
		m_data.displayDocumentInfo = displayDocumentInfo.isChecked();
		para.append(", Doc=").append(m_data.displayDocumentInfo);

		listitem = sortBy1.getSelectedItem();
		vp = null;

		if (listitem != null)
		{
			vp = (ValueNamePair)listitem.getValue();
			if (vp.getName() != null && vp.getName().trim().length() > 0)
			{
				m_data.sortBy1 = vp.getValue();//vp.getName();
				m_data.group1 = group1.isChecked();
				para.append(" - Sorting: ").append(m_data.sortBy1).append("/").append(m_data.group1);
			}
		}

		listitem = sortBy2.getSelectedItem();
		vp = null;

		if (listitem != null)
		{
			vp = (ValueNamePair)listitem.getValue();
			if (vp.getName() != null && vp.getName().trim().length() > 0)
			{
				m_data.sortBy2 = vp.getValue();//vp.getName();
				m_data.group2 = group2.isChecked();
				para.append(", ").append(m_data.sortBy2).append("/").append(m_data.group2);
			}
		}

		listitem = sortBy3.getSelectedItem();
		vp = null;

		if (listitem != null)
		{
			vp = (ValueNamePair)listitem.getValue();
			if (vp.getName() != null && vp.getName().trim().length() > 0)
			{
				m_data.sortBy3 = vp.getValue();//vp.getName();
				m_data.group3 = group3.isChecked();
				para.append(", ").append(m_data.sortBy3).append("/").append(m_data.group3);
			}
		}

		listitem = sortBy4.getSelectedItem();
		vp = null;

		if (listitem != null)
		{
			vp = (ValueNamePair)listitem.getValue();
			if (vp.getName() != null && vp.getName().trim().length() > 0)
			{
				m_data.sortBy4 = vp.getValue();//vp.getName();
				m_data.group4 = group4.isChecked();
				para.append(", ").append(m_data.sortBy4).append("/").append(m_data.group4);
			}
		}

		bQuery.setEnabled(false);
		statusLine.setValue(" " + Msg.getMsg(Env.getCtx(), "Processing"));

		if (log.isLoggable(Level.CONFIG)) log.config(para.toString());

		//  Switch to Result pane

		tabbedPane.setSelectedIndex(1);
		stateChanged();

		//  Set TableModel with Query

		m_rmodel = m_data.query();
		m_queryData = m_rmodel.getRows();
		List<ArrayList<Object>> list = null;
		paging.setPageSize(PAGE_SIZE);
		if (m_queryData.size() > PAGE_SIZE)
		{
			list = m_queryData.subList(0, PAGE_SIZE);
			paging.setTotalSize(m_queryData.size());
			pagingPanel.setVisible(true);
		}
		else
		{
			list = m_queryData;
			paging.setTotalSize(m_queryData.size());
			pagingPanel.setVisible(false);
		}
		paging.setActivePage(0);

		ListModelTable listmodeltable = new ListModelTable(list);

		if (table.getListhead() == null)
		{
			Listhead listhead = new Listhead();
			listhead.setSizable(true);

			for (int i = 0; i < m_rmodel.getColumnCount(); i++)
			{
				Listheader listheader = new Listheader(m_rmodel.getColumnName(i));
				listheader.setTooltiptext(m_rmodel.getColumnName(i));
				if (!m_data.displayDocumentInfo) {
					if ("AD_Table_ID".equals(m_rmodel.getRColumn(i).getColumnName())) 
					{
						listheader.setVisible(false);
					}
					else if ("Record_ID".equals(m_rmodel.getRColumn(i).getColumnName()))
					{
						listheader.setVisible(false);
					}
				}
				listhead.appendChild(listheader);
			}

			table.appendChild(listhead);
		}
		// Elaine 2008/07/28
		else
		{
			Listhead listhead = table.getListhead();

			// remove existing column header
			listhead.getChildren().clear();

			// add in new column header
			for (int i = 0; i < m_rmodel.getColumnCount(); i++)
			{
				Listheader listheader = new Listheader(m_rmodel.getColumnName(i));
				if (!m_data.displayDocumentInfo) {
					if ("AD_Table_ID".equals(m_rmodel.getRColumn(i).getColumnName())) 
					{
						listheader.setVisible(false);
					}
					else if ("Record_ID".equals(m_rmodel.getRColumn(i).getColumnName()))
					{
						listheader.setVisible(false);
					}
				}
				listhead.appendChild(listheader);
			}
		}
		//

		table.getItems().clear();

		table.setItemRenderer(new WListItemRenderer());
		table.setModel(listmodeltable);

		resultPanel.invalidate();

		bQuery.setEnabled(true);
		statusLine.setValue(" " + Msg.getMsg(Env.getCtx(), "ViewerOptions"));
	}   //  actionQuery

	/**
	 *  Document selection
	 */

	private void actionDocument()
	{
		boolean doc = selDocument.isChecked();
		selTable.setEnabled(doc);
		selRecord.setEnabled(doc);
		//
		selDateFrom.setEnabled(!doc);
		selDateTo.setEnabled(!doc);
		selOrg.setEnabled(!doc);
		selAcct.setEnabled(!doc);
		sel1.setEnabled(!doc);
		sel2.setEnabled(!doc);
		sel3.setEnabled(!doc);
		sel4.setEnabled(!doc);
		sel5.setEnabled(!doc);
		sel6.setEnabled(!doc);
		sel7.setEnabled(!doc);
		sel8.setEnabled(!doc);
	} // actionDocument

	/**
	 *  Save Table selection (reset Record selection)
	 */

	private void actionTable()
	{
		Listitem listitem = selTable.getSelectedItem();
		ValueNamePair vp = null;

		if (listitem != null)
			vp = (ValueNamePair)listitem.getValue();
		else
			return;

		m_data.AD_Table_ID = ((Integer)m_data.tableInfo.get(vp.getValue())).intValue();
		if (log.isLoggable(Level.CONFIG)) log.config(vp.getValue() + " = " + m_data.AD_Table_ID);

		//  Reset Record

		m_data.Record_ID = 0;
		selRecord.setLabel("");
		selRecord.setName(vp.getValue() + "_ID");
	} // actionTable

	/**
	 *  Action Button
	 *
	 *  @param button pressed button
	 *  @return ID
	 * @throws Exception
	 */

	private void actionButton(final Button button) throws Exception
	{
		final String keyColumn = button.getName();
		log.info(keyColumn);
		String whereClause = "(IsSummary='N' OR IsSummary IS NULL)";
		String lookupColumn = keyColumn;

		if ("Account_ID".equals(keyColumn))
		{
			lookupColumn = "C_ElementValue_ID";
			MAcctSchemaElement ase = m_data.ASchema
				.getAcctSchemaElement(X_C_AcctSchema_Element.ELEMENTTYPE_Account);

			if (ase != null)
				whereClause += " AND C_Element_ID=" + ase.getC_Element_ID();
		}
		else if ("User1_ID".equals(keyColumn))
		{
			lookupColumn = "C_ElementValue_ID";
			MAcctSchemaElement ase = m_data.ASchema
				.getAcctSchemaElement(X_C_AcctSchema_Element.ELEMENTTYPE_UserList1);

			if (ase != null)
				whereClause += " AND C_Element_ID=" + ase.getC_Element_ID();
		}
		else if ("User2_ID".equals(keyColumn))
		{
			lookupColumn = "C_ElementValue_ID";
			MAcctSchemaElement ase = m_data.ASchema
				.getAcctSchemaElement(X_C_AcctSchema_Element.ELEMENTTYPE_UserList2);

			if (ase != null)
				whereClause += " AND C_Element_ID=" + ase.getC_Element_ID();
		}
		else if (keyColumn.equals("AD_OrgTrx_ID"))
		{
			lookupColumn = "AD_Org_ID";
		}
		else if (keyColumn.equals("UserElement1_ID")) // KTU
		{	
			MAcctSchemaElement ase = m_data.ASchema.getAcctSchemaElement(X_C_AcctSchema_Element.ELEMENTTYPE_UserElement1);
			lookupColumn = MColumn.getColumnName(Env.getCtx(), ase.getAD_Column_ID());
			whereClause = "";
		}
		else if (keyColumn.equals("UserElement2_ID")) // KTU
		{
			MAcctSchemaElement ase = m_data.ASchema.getAcctSchemaElement(X_C_AcctSchema_Element.ELEMENTTYPE_UserElement2);
			lookupColumn = MColumn.getColumnName(Env.getCtx(), ase.getAD_Column_ID());
			whereClause = "";
		}
		else if (keyColumn.equals("M_Product_ID"))
		{
			whereClause = "";
		}
		else if (selDocument.isChecked())
			whereClause = "";

		final String tableName = lookupColumn.substring(0, lookupColumn.length()-3);

		final InfoPanel info = InfoPanel.create(m_data.WindowNo, tableName, lookupColumn, "", false, whereClause);

		if (!info.loadedOK())
		{
			button.setLabel("");
			m_data.whereInfo.put(keyColumn, "");
			return;
		}

		info.setVisible(true);
		final String lookupColumnRef = lookupColumn;
		info.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				String selectSQL = info.getSelectedSQL();       //  C_Project_ID=100 or ""
				Integer key = (Integer)info.getSelectedKey();

				if (selectSQL == null || selectSQL.length() == 0 || key == null)
				{
					button.setLabel("");
					m_data.whereInfo.put(keyColumn, "");    //  no query
					return;
				}

				//  Save for query

				if (log.isLoggable(Level.CONFIG)) log.config(keyColumn + " - " + key);
				if (button == selRecord)                            //  Record_ID
					m_data.Record_ID = key.intValue();
				else
					m_data.whereInfo.put(keyColumn, keyColumn + "=" + key.intValue());

				//  Display Selection and resize
				button.setLabel(m_data.getButtonText(tableName, lookupColumnRef, selectSQL));
				//pack();
				
			}
		});
		AEnv.showWindow(info);
		
	} // actionButton

	/**
	 *  RePost Record
	 */

	private void actionRePost()
	{
		if (m_data.documentQuery
			&& m_data.AD_Table_ID != 0 && m_data.Record_ID != 0)
		{
			FDialog.ask(m_data.WindowNo, this, "PostImmediate?", new Callback<Boolean>() {
				
				@Override
				public void onCallback(Boolean result) 
				{
					if (result)
					{
						//setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
						boolean force = forcePost.isChecked();
						String error = AEnv.postImmediate (m_data.WindowNo, m_data.AD_Client_ID,
							m_data.AD_Table_ID, m_data.Record_ID, force);
						//setCursor(Cursor.getDefaultCursor());
						if (error != null)
							FDialog.error(0, WAcctViewer.this, "PostingError-N", error);

						actionQuery();
					}
				}
			});			
		}
	} // actionRePost

	// Elaine 2009/07/29
	private void actionZoom()
	{
		int selected = table.getSelectedIndex();
		if(selected == -1) return;

		int tableIdColumn = m_rmodel.getColumnIndex("AD_Table_ID");
		int recordIdColumn = m_rmodel.getColumnIndex("Record_ID");
		ListModelTable model = (ListModelTable) table.getListModel();
		int AD_Table_ID = ((KeyNamePair) model.getDataAt(selected, tableIdColumn)).getKey();
		int Record_ID = ((Integer) model.getDataAt(selected, recordIdColumn)).intValue();
		
		AEnv.zoom(AD_Table_ID, Record_ID);
	}
	//
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null)
			SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0);
	}
}
