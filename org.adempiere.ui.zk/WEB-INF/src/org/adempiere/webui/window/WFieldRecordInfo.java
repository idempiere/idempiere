/******************************************************************************
 * Copyright (C) 2009 Low Heng Sin                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.  					  *
 * 																			  *
 * @sponsor www.metas.de													  *
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

import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.component.SimpleListModel;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WEditorPopupMenu;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.MChangeLog;
import org.compiere.model.MColumn;
import org.compiere.model.MEntityType;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Listhead;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * Dialog to view field change log history
 * @author Low Heng Sin
 */
public class WFieldRecordInfo extends Window implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8544547290283904702L;

	private int AD_Table_ID;
	private int AD_Column_ID;
	private int Record_ID;
	private String Record_UU;
	/* SysConfig USE_ESC_FOR_TAB_CLOSING */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));
	private Object value;
	
	/**
	 *	Field Info
	 *	@param title title
	 *	@param AD_Table_ID
	 *  @param AD_Column_ID
	 *  @param Record_ID
	 *  @param Record_UU
	 */
	public WFieldRecordInfo (String title, int AD_Table_ID, int AD_Column_ID, int Record_ID, String Record_UU, Object value)
	{
		super ();
		this.setTitle(title);
		this.setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
		if (!ThemeManager.isUseCSSForWindowSize())
		{
			ZKUpdateUtil.setWindowWidthX(this, 640);
			ZKUpdateUtil.setWindowHeightX(this, 480);
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
		
		this.AD_Table_ID = AD_Table_ID;
		this.AD_Column_ID = AD_Column_ID;
		this.Record_ID = Record_ID;
		this.Record_UU = Record_UU;
		this.value = value;

		try
		{
			init ( dynInit(title) );
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
		AEnv.showCenterScreen(this);
	}	//	WFieldRecordInfo

	/** table for change log history */
	private Listbox table = new Listbox();
	private ConfirmPanel confirmPanel = new ConfirmPanel (false);

	/**	Logger			*/
	private static final CLogger	log = CLogger.getCLogger(WFieldRecordInfo.class);
	/** Data for {@link #table}		*/
	private Vector<Vector<String>>	m_data = new Vector<Vector<String>>();

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

	/**
	 * 	Layout dialog
	 *	@throws Exception
	 */
	private void init (boolean showTable) throws Exception
	{
		Borderlayout layout = new Borderlayout();
		layout.setParent(this);
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
		
		North north = new North();
		MColumn column = MColumn.get (Env.getCtx(), AD_Column_ID);

		north.setParent(layout);

		StringBuffer label = new StringBuffer();
		label.append(column.getAD_Table().getTableName()).append(".").append(column.getColumnName()).append("='").append(value).append("'");

		if (Env.IsShowTechnicalInfOnHelp(Env.getCtx()))
		{
			label.append("\n");
			MEntityType entityType = MEntityType.get(Env.getCtx(), column.getEntityType());
			label.append(entityType.getName()).append(" [ ").append(entityType.getEntityType()).append(" ]");
		}

		Label l = new Label(label.toString());
		l.setMultiline(true);
		north.appendChild(l);

		Center center = new Center();
		center.setParent(layout);
		if (showTable)
		{
			ZKUpdateUtil.setHflex(table, "true");
			ZKUpdateUtil.setVflex(table, "true");
			center.appendChild(table);
			ZKUpdateUtil.setWidth(table, "100%");
		}
		//
		South south = new South();
		south.setParent(layout);
		south.appendChild(confirmPanel);
		
		confirmPanel.addActionListener(Events.ON_CLICK, this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
		setSclass("field-record-info-dialog");
	}	//	init
		
	/**
	 * 	Init components and variables
	 *	@param title title
	 *	@return true if initialized ok
	 */
	private boolean dynInit(String title)
	{
		//	Title
		if (AD_Table_ID != 0)
		{
			MTable table1 = MTable.get (Env.getCtx(), AD_Table_ID);
			setTitle(title + " - " + table1.getName());
		}

		//	Only Client Preference can view Change Log
		if (!MRole.PREFERENCETYPE_Client.equals(MRole.getDefault().getPreferenceType()))
			return false;
		
		if (Record_ID == 0 && Util.isEmpty(Record_UU))
			return false;
		
		//	Data
		String sql = "SELECT AD_Column_ID, Updated, UpdatedBy, OldValue, NewValue "
			+ "FROM AD_ChangeLog "
			+ "WHERE AD_Table_ID=? AND (Record_ID=? OR Record_UU=?) AND AD_Column_ID=? "
			+ "ORDER BY Updated DESC";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Table_ID);
			pstmt.setInt (2, Record_ID);
			pstmt.setString (3, Record_UU);
			pstmt.setInt (4, AD_Column_ID);
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
		}
		
		//
		ArrayList<String> columnNames = new ArrayList<String>();
		columnNames.add(Msg.translate(Env.getCtx(), "NewValue"));
		columnNames.add(Msg.translate(Env.getCtx(), "OldValue"));
		columnNames.add(Msg.translate(Env.getCtx(), "UpdatedBy"));
		columnNames.add(Msg.translate(Env.getCtx(), "Updated"));
		
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
	 * 	Add new line to {@link #m_data}
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

		m_data.add(line);
	}	//	addLine
	
	/**
	 * @param event
	 */
	@Override
	public void onEvent(Event event) throws Exception {
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

	/**
	 * Open field record info dialog
	 * @param gridField
	 */
	public static void start(GridField gridField) {
		new WFieldRecordInfo(gridField.getColumnName(), 
				gridField.getGridTab().getAD_Table_ID(), gridField.getAD_Column_ID(), 
				gridField.getGridTab().getRecord_ID(),
				gridField.getGridTab().getRecord_UU(), gridField.getValue());
	}

	/**
	 * Add change log menu item
	 * @param popupMenu
	 */
	public static void addMenu(WEditorPopupMenu popupMenu) {
		Menuitem changeLogItem = new Menuitem();
        changeLogItem.setLabel(Msg.getElement(Env.getCtx(), "AD_ChangeLog_ID"));
        if (ThemeManager.isUseFontIconForImage())
        	changeLogItem.setIconSclass("z-icon-ChangeLog");
        else
        	changeLogItem.setImage(ThemeManager.getThemeResource("images/ChangeLog16.png"));
        changeLogItem.setAttribute(WEditorPopupMenu.EVENT_ATTRIBUTE, WEditorPopupMenu.CHANGE_LOG_EVENT);
        changeLogItem.addEventListener(Events.ON_CLICK, popupMenu);
        
        popupMenu.appendChild(changeLogItem);
	}
}	// WFieldRecordInfo
