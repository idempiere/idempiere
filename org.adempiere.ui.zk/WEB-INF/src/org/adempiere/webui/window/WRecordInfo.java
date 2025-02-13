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
package org.adempiere.webui.window;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.UserPreference;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.MChangeLog;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Util;
import org.zkoss.zhtml.Pre;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.Notification;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Listhead;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Toolbarbutton;

/**
 * Record Info (Who) With Change History
 * <p>
 * Change log:
 * <ul>
 * <li>2007-02-26 - teo_sarca - [ 1666598 ] RecordInfo shows ColumnName instead of name
 * </ul>
 * 
 * @author Jorg Janke
 * 
 * Zk Port
 * @author Low Heng Sin
 */
public class WRecordInfo extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7436682051825360216L;

	/**
	 *	Record Info
	 *	@param title title
	 *	@param dse data status event
	 * @param gridTab 
	 */
	public WRecordInfo (String title, DataStatusEvent dse, GridTab gridTab)
	{
		super ();
		this.setTitle(title);
		if (!ThemeManager.isUseCSSForWindowSize())
		{
			ZKUpdateUtil.setWindowWidthX(this, 800);
			ZKUpdateUtil.setWindowHeightX(this, 600);
		}
		else
		{
			addCallback(AFTER_PAGE_ATTACHED, t-> {
				ZKUpdateUtil.setCSSHeight(this);
				ZKUpdateUtil.setCSSWidth(this);
			});
		}
		this.setBorder("normal");
		this.setSizable(true);
		this.setClosable(true);
		this.setMaximizable(true);
		this.setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "recordInfo");
		this.setSclass("popup-dialog record-info-dialog");
		
		try
		{
			init ( dynInit(gridTab, dse, title) );
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		AEnv.showCenterScreen(this);
	}	//	RecordInfo

	/** listbox for change logs */
	private Listbox table = new Listbox();
	/** timeline view */
	private RecordTimeLinePanel timeLinePanel = new RecordTimeLinePanel();
	private ConfirmPanel confirmPanel = new ConfirmPanel (false);

	/**	Logger			*/
	private static final CLogger	log = CLogger.getCLogger(WRecordInfo.class);
	/** Change Log Data		*/
	private Vector<Vector<String>>	m_data = new Vector<Vector<String>>();
	/** Info			*/
	private StringBuffer	m_info = new StringBuffer();
	/** Permalink			*/
	private Toolbarbutton m_permalink = new Toolbarbutton();
	/** Copy Select			*/
	private Toolbarbutton m_copySelect = new Toolbarbutton();
	/* SysConfig USE_ESC_FOR_TAB_CLOSING */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));

	/** Date Time Format		*/
	private SimpleDateFormat	m_dateTimeFormat = DisplayType.getDateFormat
		(DisplayType.DateTime, Env.getLanguage(Env.getCtx()));
	/** Date Format			*/
	private SimpleDateFormat	m_dateFormat = DisplayType.getDateFormat
		(DisplayType.DateTime, Env.getLanguage(Env.getCtx()));
	/** Number Format		*/
	private DecimalFormat		m_numberFormat = DisplayType.getNumberFormat
		(DisplayType.Number, Env.getLanguage(Env.getCtx()));
	/** Amount Format		*/
	private DecimalFormat		m_amtFormat = DisplayType.getNumberFormat
		(DisplayType.Amount, Env.getLanguage(Env.getCtx()));
	/** Number Format		*/
	private DecimalFormat		m_intFormat = DisplayType.getNumberFormat
		(DisplayType.Integer, Env.getLanguage(Env.getCtx()));
	private Component tabPanels;
	private UserPreference userPreference;
	private Tabbox tabbox;
	private int windowNo;

	/**
	 * 	Layout dialog
	 *  @param showTable
	 *	@throws Exception
	 */
	private void init (boolean showTable) throws Exception
	{
		Div div = new Div();
		div.setStyle("width: 100%; height: 100%");
		Pre pre = new Pre();
		Text text = new Text(m_info.toString());
		text.setParent(pre);
		pre.setParent(div);			
		//
		
		Borderlayout layout = new Borderlayout();
		layout.setParent(this);
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
		
		Center center = new Center();
		center.setParent(layout);
		if (showTable)
		{
			table.setSclass("record-info-changelog-table");
			ZKUpdateUtil.setHflex(table, "true");
			ZKUpdateUtil.setVflex(table, "true");
			North north = new North();
			north.setParent(layout);
			north.appendChild(div);						
			center.appendChild(table);
			
			tabbox = new Tabbox();
			ZKUpdateUtil.setVflex(tabbox, "1");
			ZKUpdateUtil.setHflex(tabbox, "1");
			Tabs tabs = new Tabs();
			tabs.setParent(tabbox);
			tabPanels = new Tabpanels();
			tabPanels.setParent(tabbox);
			tabbox.addEventListener(Events.ON_SELECT, this);

			initTabs(tabs);
			center.appendChild(tabbox);
		}
		else
		{
			ZKUpdateUtil.setHflex(div, "true");
			ZKUpdateUtil.setVflex(div, "true");
			center.appendChild(div);
		}
		
		//
		South south = new South();
		south.setSclass("dialog-footer");
		south.setParent(layout);
		//
		m_permalink.setLabel(Msg.getMsg(Env.getCtx(), "Permalink"));
		m_permalink.setTooltiptext(Msg.getMsg(Env.getCtx(), "Permalink_tooltip"));
		m_copySelect.setLabel(Msg.getMsg(Env.getCtx(), "CopySelect"));
		m_copySelect.setTooltiptext(Msg.getMsg(Env.getCtx(), "CopySelect_tooltip"));
		Hbox hbox = new Hbox();
		hbox.setWidth("100%");
		south.appendChild(hbox);
		hbox.appendChild(m_permalink);
		hbox.appendChild(m_copySelect);
		ZKUpdateUtil.setHflex(confirmPanel, "true");
		hbox.appendChild(confirmPanel);
		
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}	//	init
	
	
	private void initTabs(Tabs tabs) {
		Tab tab = new Tab();
		tab.setId("C");
		tab.setLabel(Msg.getElement(Env.getCtx(), "AD_ChangeLog_ID"));
		tab.setParent(tabs);
		Tabpanel tabPanel = createTable();
		tabPanel.setParent(tabPanels);
		
		tab = new Tab();
		tab.setId("T");
		tab.setLabel(Msg.getMsg(Env.getCtx(), "TimeLine"));
		tab.setParent(tabs);
		tabPanel = createTimeline();
		tabPanel.setParent(tabPanels);
		
		if("T".equals(userPreference.getProperty(UserPreference.P_RECORD_INFO_DEFAULT_TAB)))
			tab.setSelected(true);
	}


	private Tabpanel createTable() {
		Tabpanel tabPanel = new Tabpanel();
		tabPanel.appendChild(table);
		return tabPanel;
	}


	private Tabpanel createTimeline() {
		Tabpanel tabPanel = new Tabpanel();
		tabPanel.appendChild(timeLinePanel);
		return tabPanel;
	}



	/**
	 * 	Load change logs
	 *  @param gridTab 
	 *	@param dse data status event
	 *	@param title title
	 *	@return true if table initialized
	 */
	private boolean dynInit(GridTab gridTab, DataStatusEvent dse, String title)
	{
		if (dse.CreatedBy == null)
			return false;
		//  Info
		MUser user = MUser.get(Env.getCtx(), dse.CreatedBy.intValue());
		m_info.append(" ")
			.append(Msg.getElement(Env.getCtx(), "CreatedBy"))
			.append(": ").append(user.getName())
			.append(" - ").append(m_dateTimeFormat.format(dse.Created)).append("\n");
		
		// get user preference
		userPreference = new UserPreference();
		userPreference.loadPreference(user.getAD_User_ID());
		
		if (!dse.Created.equals(dse.Updated) 
			|| !dse.CreatedBy.equals(dse.UpdatedBy))
		{
			if (!dse.CreatedBy.equals(dse.UpdatedBy))
				user = MUser.get(Env.getCtx(), dse.UpdatedBy.intValue());
			m_info.append(" ")
				.append(Msg.getElement(Env.getCtx(), "UpdatedBy"))
				.append(": ").append(user.getName())
				.append(" - ").append(m_dateTimeFormat.format(dse.Updated)).append("\n");
		}
		if (dse.Info != null && dse.Info.length() > 0)
			m_info.append("\n ").append(dse.Info).append("");
		
		//get uuid
		GridTable gridTable = null;
		String tabName = null;
		if (gridTab != null)
		{
			gridTable = gridTab.getTableModel();
			windowNo = gridTab.getWindowNo();
		}
		else if (dse.getSource() instanceof GridTab) 
		{
			gridTab = (GridTab) dse.getSource();
			gridTable = gridTab.getTableModel();			
			tabName = gridTab.getName();
			windowNo = gridTab.getWindowNo();
		}
		else if (dse.getSource() instanceof GridTable)
		{
			gridTable = (GridTable) dse.getSource();
			GridField firstField = gridTable.getField(0);
			if (firstField != null) {
				windowNo = firstField.getWindowNo();
				if (firstField.getGridTab() != null) {
					tabName = firstField.getGridTab().getName();
				}
			}
		}

		int Record_ID = -1;
		if (dse.Record_ID instanceof Integer)
			Record_ID = ((Integer)dse.Record_ID).intValue();
		String Record_UU = null;

		MTable dbtable = null;
		if (dse.AD_Table_ID != 0)
			dbtable = MTable.get(Env.getCtx(), dse.AD_Table_ID);

		if (gridTable != null && dse.getCurrentRow() >= 0 && dse.getCurrentRow() < gridTable.getRowCount())
		{
			PO po = gridTable.getPO(dse.getCurrentRow());
			if (po != null) {
				String uuidcol = po.getUUIDColumnName();
				Record_UU = po.get_UUID();
				if (!Util.isEmpty(Record_UU)) {
					StringBuilder uuinfo = new StringBuilder(uuidcol).append("=").append(Record_UU);
					if (! m_info.toString().contains(uuinfo))
						m_info.append("\n ").append(uuinfo);
				}
				String ticketURL;
				if (Record_ID <= 0)
					ticketURL = AEnv.getZoomUrlTableUU(po);
				else
					ticketURL = AEnv.getZoomUrlTableID(po);
				m_permalink.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
					public void onEvent(Event event) throws Exception {
						StringBuffer sb = new StringBuffer("navigator.clipboard.writeText(\"")
								.append(ticketURL)
								.append("\");");
						Clients.evalJavaScript(sb.toString());
						Notification.show(Msg.getMsg(Env.getCtx(), "Copied"), Notification.TYPE_INFO, m_permalink, "end_before", 1000);
					}
				});
				final String whereClause = po.get_WhereClause(true);
				m_copySelect.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
					public void onEvent(Event event) throws Exception {
						StringBuffer query = new StringBuffer("navigator.clipboard.writeText(\"SELECT * FROM ")
							.append(po.get_TableName())
							.append(" WHERE ")
							.append(whereClause);
						query.append("\");");
						Clients.evalJavaScript(query.toString());
						Notification.show(Msg.getMsg(Env.getCtx(), "Copied"), Notification.TYPE_INFO, m_copySelect, "end_before", 1000);
					}
				});
				m_copySelect.setVisible(true);
			}
		}
		if (gridTab != null)
		{
			timeLinePanel.render(gridTab);
		}
		
		//	Title
		if (tabName == null && dse.AD_Table_ID != 0)
		{
			tabName = dbtable.getName();
		}
		setTitle(title + " - " + tabName);

		//	Only Client Preference can view Change Log
		if (!MRole.PREFERENCETYPE_Client.equals(MRole.getDefault().getPreferenceType()))
			return false;
		
		if (Record_ID <= 0 && Util.isEmpty(Record_UU))
			return false;
		
		//	Data
		String sql = "SELECT AD_Column_ID, Updated, UpdatedBy, OldValue, NewValue "
			+ "FROM AD_ChangeLog "
			+ "WHERE AD_Table_ID=? AND (Record_ID=? OR Record_UU=?) "
			+ "ORDER BY Updated DESC";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, dse.AD_Table_ID);
			pstmt.setInt (2, Record_ID);
			pstmt.setString (3, Record_UU);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				addLine (rs.getInt(1), rs.getTimestamp(2), rs.getInt(3),
					rs.getString(4), rs.getString(5));
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		//
		ArrayList<String> columnNames = new ArrayList<String>();
		columnNames.add(Msg.getElement(Env.getCtx(), "Name"));
		columnNames.add(Msg.getElement(Env.getCtx(), "NewValue"));
		columnNames.add(Msg.getElement(Env.getCtx(), "OldValue"));
		columnNames.add(Msg.getElement(Env.getCtx(), "UpdatedBy"));
		columnNames.add(Msg.getElement(Env.getCtx(), "Updated"));
		columnNames.add(Msg.getElement(Env.getCtx(), "AD_Column_ID"));
		
		Listhead listhead = new Listhead();
		listhead.setSizable(true);
		
		for (int i = 0; i < columnNames.size(); i++)
		{
			Listheader listheader = new Listheader(columnNames.get(i).replaceAll("[&]", ""));
			listhead.appendChild(listheader);
		}
		
		table.appendChild(listhead);
		SimpleListModel model = new SimpleListModel(m_data);
		table.setItemRenderer(model);
		table.setModel(model);
		
		return true;
	}	//	dynInit
	
	/**
	 * 	Add change log line to {@link #m_data}
	 *	@param AD_Column_ID column
	 *	@param Updated updated
	 *	@param UpdatedBy user
	 *	@param OldValue old
	 *	@param NewValue new
	 */
	private void addLine (int AD_Column_ID, Timestamp Updated, int UpdatedBy,
		String OldValue, String NewValue)
	{
		Vector<String> line = new Vector<String>();
		//	Column
		MColumn column = MColumn.get (Env.getCtx(), AD_Column_ID);
		line.add(Msg.getElement(Env.getCtx(), column.getColumnName(), Env.isSOTrx(Env.getCtx(), windowNo)));
		//
		if (OldValue != null && OldValue.equals(MChangeLog.NULL))
			OldValue = null;
		String showOldValue = OldValue;
		if (NewValue != null && NewValue.equals(MChangeLog.NULL))
			NewValue = null;
		String showNewValue = NewValue;
		//
		try
		{
			if (DisplayType.isText (column.getAD_Reference_ID ()))
				;
			else if (column.getAD_Reference_ID() == DisplayType.YesNo)
			{
				if (OldValue != null)
				{
					boolean yes = OldValue.equals("true") || OldValue.equals("Y");
					showOldValue = Msg.getMsg(Env.getCtx(), yes ? "Y" : "N");
				}
				if (NewValue != null)
				{
					boolean yes = NewValue.equals("true") || NewValue.equals("Y");
					showNewValue = Msg.getMsg(Env.getCtx(), yes ? "Y" : "N");
				}
			}
			else if (column.getAD_Reference_ID() == DisplayType.Amount)
			{
				if (OldValue != null)
					showOldValue = m_amtFormat
						.format (new BigDecimal (OldValue));
				if (NewValue != null)
					showNewValue = m_amtFormat
						.format (new BigDecimal (NewValue));
			}
			else if (column.getAD_Reference_ID() == DisplayType.Integer)
			{
				if (OldValue != null)
					showOldValue = m_intFormat.format (Integer.valueOf(OldValue));
				if (NewValue != null)
					showNewValue = m_intFormat.format (Integer.valueOf(NewValue));
			}
			else if (DisplayType.isNumeric (column.getAD_Reference_ID ()))
			{
				if (OldValue != null)
					showOldValue = m_numberFormat.format (new BigDecimal (OldValue));
				if (NewValue != null)
					showNewValue = m_numberFormat.format (new BigDecimal (NewValue));
			}
			else if (column.getAD_Reference_ID() == DisplayType.Date)
			{
				if (OldValue != null)
					showOldValue = m_dateFormat.format (Timestamp.valueOf (OldValue));
				if (NewValue != null)
					showNewValue = m_dateFormat.format (Timestamp.valueOf (NewValue));
			}
			else if (column.getAD_Reference_ID() == DisplayType.DateTime)
			{
				if (OldValue != null)
					showOldValue = m_dateTimeFormat.format (Timestamp.valueOf (OldValue));
				if (NewValue != null)
					showNewValue = m_dateTimeFormat.format (Timestamp.valueOf (NewValue));
			}
			else if (DisplayType.isLookup(column.getAD_Reference_ID ()))
			{
				MLookup lookup = MLookupFactory.get (Env.getCtx(), 0,
					AD_Column_ID, column.getAD_Reference_ID(),
					Env.getLanguage(Env.getCtx()), column.getColumnName(),
					column.getAD_Reference_Value_ID(),
					column.isParent(), null);
				if (OldValue != null)
				{
					Object key = OldValue; 
					NamePair pp = lookup.get(key);
					if (pp != null)
						showOldValue = pp.getName();
				}
				if (NewValue != null)
				{
					Object key = NewValue; 
					NamePair pp = lookup.get(key);
					if (pp != null)
						showNewValue = pp.getName();
				}
			}
			else if (DisplayType.isLOB (column.getAD_Reference_ID ()))
				;
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, OldValue + "->" + NewValue, e);
		}
		//
		line.add(showNewValue);
		line.add(showOldValue);
		//	UpdatedBy
		MUser user = MUser.get(Env.getCtx(), UpdatedBy);
		line.add(user.getName());
		//	Updated
		line.add(m_dateFormat.format(Updated));
		//	Column Name
		line.add(column.getColumnName());

		m_data.add(line);
	}	//	addLine
	
	@Override
	public void onEvent(Event event) throws Exception {
		if(event.getName().equals(Events.ON_SELECT)) {
			Tab selectedTab = (Tab) tabbox.getSelectedTab();
			userPreference.setProperty(UserPreference.P_RECORD_INFO_DEFAULT_TAB, selectedTab.getId());
			userPreference.savePreference();
			return;
		}
		onCancel();
	}

	/**
	 * Handle onCancel event
	 */
	private void onCancel() {
		// do not allow to close tab for Events.ON_CTRL_KEY event
		if(isUseEscForTabClosing)
			SessionManager.getAppDesktop().setCloseTabWithShortcut(false);

		this.detach();
	}

}	// WRecordInfo
