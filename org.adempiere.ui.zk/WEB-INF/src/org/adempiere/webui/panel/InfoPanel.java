/******************************************************************************
 * Product: Posterita Ajax UI 												  *
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

import java.awt.event.MouseEvent;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.IInfoColumn;
import org.adempiere.model.MInfoProcess;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialog;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.apps.WProcessCtl;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.ProcessInfoDialog;
import org.adempiere.webui.component.WListItemRenderer;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.event.WTableModelListener;
import org.adempiere.webui.factory.InfoManager;
import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.part.ITabOnSelectHandler;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.GridField;
import org.compiere.model.InfoColumnVO;
import org.compiere.model.InfoRelatedVO;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.event.SelectEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Listhead;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Paging;
import org.zkoss.zul.event.PagingEvent;
import org.zkoss.zul.event.ZulEvents;
import org.zkoss.zul.ext.Sortable;

/**
 *	Search Information and return selection - Base Class.
 *  Based on Info written by Jorg Janke
 *
 *  @author Sendy Yagambrum
 *
 * Zk Port 
 * @author Elaine
 * @version	Info.java Adempiere Swing UI 3.4.1
 * 
 * @contributor red1 IDEMPIERE-1711 with final review by HengSin 
 */
public abstract class InfoPanel extends Window implements EventListener<Event>, WTableModelListener, Sortable<Object>, IHelpContext
{
	protected static final String ON_USER_QUERY_ATTR = "ON_USER_QUERY";
	protected static final String INFO_QUERY_TIME_OUT_ERROR = "InfoQueryTimeOutError";
	protected static final String COLUMN_VISIBLE_ORIGINAL = "column.visible.original";
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5502211337030815819L;
	private final static int DEFAULT_PAGE_SIZE = 100;
	private final static int DEFAULT_PAGE_PRELOAD = 4;
	protected List<Button> btProcessList = new ArrayList<Button>();
	protected Map<String, WEditor> editorMap = new HashMap<String, WEditor>();
	protected final static String PROCESS_ID_KEY = "processId";
	protected final static String ON_RUN_PROCESS = "onRunProcess";
	// attribute key of info process
	protected final static String ATT_INFO_PROCESS_KEY = "INFO_PROCESS";
	protected int pageSize;
	public LinkedHashMap<KeyNamePair,LinkedHashMap<String, Object>> m_values = null;
	protected InfoRelatedVO[] relatedInfoList;
	// for test disable load all record when num of record < 1000
	protected boolean isIgnoreCacheAll = true;
	// Num of page preload, default is 2 page before current and 2 page after current 
	protected int numPagePreLoad = MSysConfig.getIntValue(MSysConfig.ZK_INFO_NUM_PAGE_PRELOAD, DEFAULT_PAGE_PRELOAD);
	// max end index is integer.max_value - 1, not integer.max_value.
	protected int extra_max_row = 1;
	/**
	 * MInfoColumn has isKey = true, play as key column in case non column has
	 * isKey = true, this column is null and we use {@link #p_keyColumn}
	 */
	protected MInfoColumn keyColumnOfView = null;
	
	/**
	 * index of {@link #keyColumnOfView} in data model, set when prepare listbox
	 */
	protected int indexKeyOfView = -1;
	
	protected boolean isIDColumnKeyOfView = false;
	protected boolean hasRightQuickEntry = true;
	protected boolean isHasNextPage = false;
	/**
	 * store selected record info
	 * key of map is value of column play as keyView
	 * in case has no key coloumn of view, use value of {@link #p_keyColumn}
	 * zk6.x listview don't provide event when click to checkbox select all, 
	 * so we can't manage selectedRecord time by time. 
	 * each time change page we will update this list with current
	 * selected record of this page by call function
	 * {@link #updateListSelected()} when move to zk7, just enough handle
	 * onclick. because don't direct use recordSelectedData, call
	 * {@link #getSelectedRowInfo()}
	 */
	protected Map<Integer, List<Object>> recordSelectedData = new HashMap<Integer, List<Object>>();
	
	/**
	 * when requery but don't clear selected record (example after run process)
	 * set flag to true to run sync selected record, also
	 * {@link #syncSelectedAfterRequery()}
	*/
	protected boolean isRequeryByRunSuccessProcess = false;
	
	
    public static InfoPanel create (int WindowNo,
            String tableName, String keyColumn, String value,
            boolean multiSelection, String whereClause)
    {
        return InfoManager.create(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, true);
    }

	/**
	 * Show panel based on tablename (non modal)
	 * @param tableName
	 */
    public static void showPanel (String tableName)
	{
		InfoPanel info = InfoManager.create(0, tableName, tableName + "_ID", "", false, "", false);
		info.setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
		AEnv.showWindow(info);
		info.setFocus(true);
	}	// showPanel

	/** Window Width                */
	static final int        INFO_WIDTH = 800;
	protected boolean m_lookup;
	protected int m_infoWindowID;
	private boolean m_closeAfterExecutionOfProcess = false;
	
	/**************************************************
     *  Detail Constructor
     * @param WindowNo  WindowNo
     * @param tableName tableName
     * @param keyColumn keyColumn
     * @param whereClause   whereClause
	 */
	protected InfoPanel (int WindowNo,
		String tableName, String keyColumn,boolean multipleSelection,
		 String whereClause)
	{
		this(WindowNo, tableName, keyColumn, multipleSelection, whereClause, true);
	}

	protected InfoPanel (int WindowNo,
			String tableName, String keyColumn,boolean multipleSelection,
			 String whereClause, boolean lookup){
		this(WindowNo, tableName, keyColumn, multipleSelection, whereClause,
				lookup, 0);
	}
	
	protected InfoPanel (int WindowNo,
			String tableName, String keyColumn,boolean multipleSelection,
			 String whereClause, boolean lookup, int ADInfoWindowID)
	{
		this(WindowNo, tableName, keyColumn, multipleSelection, 
				whereClause, lookup, ADInfoWindowID, null);
	}
	
	/**************************************************
     *  Detail Constructor
     * @param WindowNo  WindowNo
     * @param tableName tableName
     * @param keyColumn keyColumn
     * @param whereClause   whereClause
     * @param queryValue
	 */
	protected InfoPanel (int WindowNo,
		String tableName, String keyColumn,boolean multipleSelection,
		 String whereClause, boolean lookup, int ADInfoWindowID, String queryValue)
	{				
		if (WindowNo <= 0) {
			p_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		} else {
			p_WindowNo = WindowNo;
		}
		if (log.isLoggable(Level.INFO))
			log.info("WinNo=" + WindowNo + " " + whereClause);
		p_tableName = tableName;
		this.m_infoWindowID = ADInfoWindowID;
		p_keyColumn = keyColumn;
		
		this.queryValue = queryValue;
		if (queryValue != null && queryValue.trim().length() > 0)
		{
			parseQueryValue();
		}
		
        p_multipleSelection = multipleSelection;
        m_lookup = lookup;
        loadInfoWindowData();
		if (whereClause == null || whereClause.indexOf('@') == -1)
			p_whereClause = whereClause == null ? "" : whereClause;
		else
		{
			p_whereClause = Env.parseContext(Env.getCtx(), p_WindowNo, whereClause, false, false);
			if (p_whereClause.length() == 0)
				log.log(Level.SEVERE, "Cannot parse context= " + whereClause);
		}

		pageSize = MSysConfig.getIntValue(MSysConfig.ZK_PAGING_SIZE, DEFAULT_PAGE_SIZE, Env.getAD_Client_ID(Env.getCtx()));
		if (infoWindow != null && infoWindow.getPagingSize() > 0)
			pageSize = infoWindow.getPagingSize();

		init();

		this.setAttribute(ITabOnSelectHandler.ATTRIBUTE_KEY, new ITabOnSelectHandler() {
			public void onSelect() {
				scrollToSelectedRow();
			}
		});
		
		setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infopanel");
		
		addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
		addEventListener(ON_RUN_PROCESS, this);
		addEventListener(Events.ON_CLOSE, this);
		addEventListener(Events.ON_CANCEL, e -> onCancel());
	}	//	InfoPanel

	protected void parseQueryValue() {
		if (Util.isEmpty(queryValue, true))
			return;
		
		int start = queryValue.indexOf("?autocomplete={");
		if (start > 0 && queryValue.endsWith("}")) {
			this.isAutoComplete = true;
			this.numPagePreLoad = 1;
			String optionInput = queryValue.substring(start+"?autocomplete={".length(), queryValue.length()-1);
			queryValue = queryValue.substring(0, start);
			String[] options = optionInput.split("[,]");
			for(String option : options) {
				String[] pair = option.trim().split("[:]");
				if (pair.length != 2)
					continue;
				if (pair[0].equalsIgnoreCase("timeout")) {
					try {
						int t = Integer.parseInt(pair[1]);
						if (t > 0)
							setFixedQueryTimeout(t);
					} catch (Exception e) {}
				} else if (pair[0].equalsIgnoreCase("pagesize")) {
					try {
						int t = Integer.parseInt(pair[1]);
						if (t > 0)
							this.pageSize = t;
					} catch (Exception e) {}
				} else if (pair[0].equalsIgnoreCase("searchcolumn")) {
					this.autoCompleteSearchColumn = pair[1];
				}
			}
		}
	}
	
	/**
	 * set fixed query timeout value, overwrite the value from sysconfig
	 * @param timeout
	 */
	public void setFixedQueryTimeout(int timeout) {
		this.queryTimeout = timeout;
		useQueryTimeoutFromSysConfig = false;
	}

	private void init()
	{
		if (isLookup())
		{
			setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
			setBorder("normal");
			setClosable(true);
			int height = ClientInfo.get().desktopHeight;
			int width = ClientInfo.get().desktopWidth;
			if (width <= ClientInfo.MEDIUM_WIDTH)
			{
				ZKUpdateUtil.setWidth(this, "100%");
				ZKUpdateUtil.setHeight(this, "100%");
			}
			else
			{
				height = height * 85 / 100;
	    		width = width * 80 / 100;
	    		ZKUpdateUtil.setWidth(this, width + "px");
	    		ZKUpdateUtil.setHeight(this, height + "px");
			}
    		this.setContentStyle("overflow: auto");
		}
		else
		{
			setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
			setBorder("none");
			ZKUpdateUtil.setWidth(this, "100%");
			ZKUpdateUtil.setHeight(this, "100%");
		}

		confirmPanel = new ConfirmPanel(true, true, true, true, true, true);  // Elaine 2008/12/16 
		confirmPanel.addComponentsLeft(confirmPanel.createButton(ConfirmPanel.A_NEW));
        confirmPanel.addActionListener(Events.ON_CLICK, this);
        ZKUpdateUtil.setHflex(confirmPanel, "1");
        if (ClientInfo.isMobile())
        {
        	if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH) || ClientInfo.maxHeight(ClientInfo.SMALL_HEIGHT))
        	{
        		confirmPanel.useSmallButtonClassForSmallScreen();
        	}
        }

        // Elaine 2008/12/16
		confirmPanel.getButton(ConfirmPanel.A_CUSTOMIZE).setVisible(hasCustomize());
		confirmPanel.getButton(ConfirmPanel.A_HISTORY).setVisible(hasHistory());
		confirmPanel.getButton(ConfirmPanel.A_ZOOM).setVisible(hasZoom());
		confirmPanel.getButton(ConfirmPanel.A_NEW).setVisible(hasNew());
		//
		if (!isLookup())
		{
			confirmPanel.getButton(ConfirmPanel.A_OK).setVisible(false);
		}

        this.setSizable(true);
        this.setMaximizable(true);

        this.addEventListener(Events.ON_OK, this);
        if (isLookup())
        	addEventListener(Events.ON_CANCEL, this);
        contentPanel.setOddRowSclass(null);
//        contentPanel.setSizedByContent(true);
        contentPanel.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infoListbox");
        contentPanel.addEventListener("onAfterRender", this);
        contentPanel.setSclass("z-word-nowrap");
        
        this.setSclass("info-panel");
	}  //  init
	protected ConfirmPanel confirmPanel;
	/** Master (owning) Window  */
	protected int				p_WindowNo;
	/** Table Name              */
	protected String            p_tableName;
	/** Key Column Name         */
	protected String            p_keyColumn;
	/** Enable more than one selection  */
	protected boolean			p_multipleSelection;
	/** Initial WHERE Clause    */
	protected String			p_whereClause = "";
	protected StatusBarPanel statusBar = new StatusBarPanel();
	/**                    */
    private List<Object> line;

	private boolean			    m_ok = false;
	/** Cancel pressed - need to differentiate between OK - Cancel - Exit	*/
	private boolean			    m_cancel = false;
	/** Result IDs              */
	private ArrayList<Integer>	m_results = new ArrayList<Integer>(3);

    private ListModelTable model;
	/** Layout of Grid          */
	protected ColumnInfo[]     p_layout;
	/** Main SQL Statement      */
	protected String              m_sqlMain;
	/** Count SQL Statement		*/
	protected String              m_sqlCount;
	/** Order By Clause         */
	protected String              m_sqlOrder;
	private String              m_sqlUserOrder;
	/* sql column of infocolumn (can be alias) */
	protected int              	  indexOrderColumn = -1;
	protected String              sqlOrderColumn;
	protected Boolean             isColumnSortAscending = null;
	/**ValueChange listeners       */
    private ArrayList<ValueChangeListener> listeners = new ArrayList<ValueChangeListener>();
	/** Loading success indicator       */
	protected boolean	        p_loadedOK = false;
	/**	SO Zoom Window						*/
	private int					m_SO_Window_ID = -1;
	/**	PO Zoom Window						*/
	private int					m_PO_Window_ID = -1;
	
	protected MInfoWindow infoWindow;

	/**	Logger			*/
	protected transient CLogger log = CLogger.getCLogger(getClass());

	protected WListbox contentPanel = new WListbox();
	protected Paging paging;
	protected int pageNo;
	protected int m_count;
	private int cacheStart;
	private int cacheEnd;
	private boolean m_useDatabasePaging = false;
	private BusyDialog progressWindow;
	// in case double click to item. this store clicked item (maybe it's un-select item)
	private int m_lastSelectedIndex = -1;
	protected GridField m_gridfield;

	/**
	 * false, use saved where clause
	 * IDEMPIERE-1979
	 */
	protected boolean isQueryByUser = false;
	
	protected boolean isAutoComplete = false;
	
	protected int queryTimeout = 0;
	protected boolean useQueryTimeoutFromSysConfig = true;
	
	protected String autoCompleteSearchColumn = null;
	
	protected String queryValue;
	
	/**
	 * save where clause of prev requery
	 */
	protected String prevWhereClause = null;
	/**
	 * save value of parameter to set info query paramenter
	 */
	protected List<Object> prevParameterValues = null;
	protected List<String> prevQueryOperators = null;
	protected List<WEditor> prevRefParmeterEditor = null;
	private static final String[] lISTENER_EVENTS = {};

	/**
	* All info process of this infoWindow
	*/
	protected MInfoProcess [] infoProcessList;
	/**
	* flag detect exists info process
	*/
	protected boolean haveProcess = false;
	/**
	* Info process have style is button
	*/
	protected List<MInfoProcess> infoProcessBtList;
	/**
	* Info process have style is drop down list
	*/
	protected List<MInfoProcess> infoProcessDropList;
	/**
	* Info process have style is menu
	*/
	protected List<MInfoProcess> infoProcessMenuList;
	/**
	* save selected id and viewID
	*/
	protected Collection<KeyNamePair> m_viewIDMap = new ArrayList <KeyNamePair>();
	
	/**
	 * store index of infoColumn have data append. each infoColumn just append only one time.
	 * index increase from 0.
	 */
	protected Map <Integer, Integer> columnDataIndex = new HashMap <Integer, Integer> ();
	/**
	 * after load first record, set it to false. 
	 * when need update index of column data append to end of list {@link #columnDataIndex}, set it to true 
	 */
	protected boolean isMustUpdateColumnIndex = true;
	/**
	 * When start update index of column data append to end of list {@link #columnDataIndex}, reset it to 0,
	 * each read data for new append column, increase it up 1
	 */
	protected int indexColumnCount = 0;
	/**
	 * to prevent append duplicate data, when begin read each record reset this list, 
	 * when read a column store id of infoColumn to list to check duplicate
	 */
	protected List <Integer> lsReadedColumn = new ArrayList <Integer> ();
	
	/**
	 * IDEMPIERE-1334
	 * button and combobox when layout process button as dropdow list
	 */
	protected Button btCbbProcess;
	protected Combobox cbbProcess;
	protected Button btMenuProcess;
	/**
	 *  Loaded correctly
	 *  @return true if loaded OK
	 */
	public boolean loadedOK()
	{
		return p_loadedOK;
	}   //  loadedOK

	/**
	 *	Set Status Line
	 *  @param text text
	 *  @param error error
	 */
	public void setStatusLine (String text, boolean error)
	{
		statusBar.setStatusLine(text, error);
	}	//	setStatusLine

	/**
	 *	Set Status DB
	 *  @param text text
	 */
	public void setStatusDB (String text)
	{
		statusBar.setStatusDB(text);
	}	//	setStatusDB

	/**
	 *	Set Status DB
	 */
	public void setStatusSelected ()
	{
		if (!p_multipleSelection)
			return;
		
		int selectedCount = recordSelectedData.size();
		
		for (int rowIndex = 0; rowIndex < contentPanel.getModel().getRowCount(); rowIndex++){			
			Integer keyCandidate = getColumnValue(rowIndex);
			
			@SuppressWarnings("unchecked")
			List<Object> candidateRecord = (List<Object>)contentPanel.getModel().get(rowIndex);
						
			if (contentPanel.getModel().isSelected(candidateRecord)){
				if (!recordSelectedData.containsKey(keyCandidate)){
					selectedCount++;
				}
			}else{
				if (recordSelectedData.containsKey(keyCandidate)){// unselected record
					selectedCount--;
				}
			}
		}	
		
		String msg = Msg.getMsg(Env.getCtx(), "IWStatusSelected", new Object [] {String.valueOf(selectedCount)});
		statusBar.setSelectedRowNumber(msg);
	}	//	setStatusDB
	
	protected void prepareTable (ColumnInfo[] layout,
            String from,
            String where,
            String orderBy)
	{
        String sql =contentPanel.prepareTable(layout, from,
                where,p_multipleSelection,
                getTableName(),false);
        if (infoWindow != null)	
        	contentPanel.setwListBoxName("AD_InfoWindow_UU|"+ infoWindow.getAD_InfoWindow_UU() );
        else
	    	contentPanel.setwListBoxName("AD_InfoPanel|"+ from );
        p_layout = contentPanel.getLayout();
		m_sqlMain = sql;
		m_sqlCount = "SELECT COUNT(*) FROM " + from + " WHERE " + where;
		//
		m_sqlOrder = "";
//		m_sqlUserOrder = "";
		if (orderBy != null && orderBy.trim().length() > 0)
			m_sqlOrder = " ORDER BY " + orderBy;
	}   //  prepareTable

	protected boolean isLoadPageNumber(){
		return infoWindow == null || infoWindow.isLoadPageNum();
	}
	
	/**************************************************************************
	 *  Execute Query
	 */
	protected void executeQuery()
	{
		saveWlistBoxColumnWidth(this.getFirstChild());
		line = new ArrayList<Object>();
		setCacheStart(-1);
		cacheEnd = -1;
		if (isLoadPageNumber())
			testCount();
		else
			m_count = Integer.MAX_VALUE;
		
		if (m_count > 0)
		{
			m_useDatabasePaging = isIgnoreCacheAll || (m_count > 1000);
			if (m_useDatabasePaging)
			{
				return ;
			}
			else
			{
				readLine(0, -1);
			}
		}
	}

	private void readData(ResultSet rs) throws SQLException {
		int colOffset = 1;  //  columns start with 1
		List<Object> data = new ArrayList<Object>();
	
		for (int col = 0; col < p_layout.length; col++)
		{
			Object value = null;
			Class<?> c = p_layout[col].getColClass();
			int colIndex = col + colOffset;
			if (c == IDColumn.class)
			{
		        value = new IDColumn(rs.getInt(colIndex));

			}
			else if (c == Boolean.class)
		        value = Boolean.valueOf("Y".equals(rs.getString(colIndex)));
			else if (c == Timestamp.class)
		        value = rs.getTimestamp(colIndex);
			else if (c == BigDecimal.class)
		        value = rs.getBigDecimal(colIndex);
			else if (c == Double.class)
		        value = Double.valueOf(rs.getDouble(colIndex));
			else if (c == Integer.class)
		        value = Integer.valueOf(rs.getInt(colIndex));
			else if (c == KeyNamePair.class)
			{				
				if (p_layout[col].isKeyPairCol())
				{
					String display = rs.getString(colIndex);
					int key = rs.getInt(colIndex+1);
					if (! rs.wasNull()) {
		                value = new KeyNamePair(key, display);
					}
	
					colOffset++;
				}
				else
				{
					int key = rs.getInt(colIndex);
					if (! rs.wasNull()) {
						WEditor editor = editorMap.get(p_layout[col].getColSQL());
						if (editor != null)
						{
							editor.setValue(key);
							value = new KeyNamePair(key, editor.getDisplayTextForGridView(key));
						}					
						else
						{
							value = new KeyNamePair(key, Integer.toString(key));
						}
					}
				}
			}
			else if (c == ValueNamePair.class)
			{
				String key = rs.getString(colIndex);
				WEditor editor = editorMap.get(p_layout[col].getColSQL());
				if (editor != null)
				{
					value = new ValueNamePair(key, editor.getDisplayTextForGridView(key));
				}					
				else
				{
					value = new ValueNamePair(key, key);
				}
			}
			else
			{
		        value = rs.getString(colIndex);
		        if (! rs.wasNull()) {
					WEditor editor = editorMap.get(p_layout[col].getColSQL());
					if (editor != null && editor.getGridField() != null && editor.getGridField().isLookup())
					{
						editor.setValue(value);
						value = editor.getDisplay();
					}
		        }
			}
			data.add(value);
		}
		
        line.add(data);
        
        appendDataForViewID(rs, data, lsReadedColumn);
        
        appendDataForParentLink(rs, data, lsReadedColumn);
        
        appendDataForKeyView (rs, data, lsReadedColumn);
	}
	
	/**
	 * save data of all viewID column in infoProcessList to end of data line
	 * when override {@link #readData(ResultSet)} consider call this method 
	 * IDEMPIERE-1970
	 * @param rs record set to read data
	 * @param data data line to append
	 * @param listReadedColumn list column is appended
	 * @throws SQLException
	 */
	protected void appendDataForViewID(ResultSet rs, List<Object> data, List<Integer> listReadedColumn) throws SQLException {
		appendInfoColumnData(rs, data, infoProcessList, listReadedColumn);
	}
	
	/**
	 * save data of all viewID column in infoProcessList to end of data line
	 * when override {@link #readData(ResultSet)} consider call this method 
	 * IDEMPIERE-2152
	 * @param rs
	 * @param data
	 * @param listReadedColumn
	 * @throws SQLException
	 */
	protected void appendDataForParentLink(ResultSet rs, List<Object> data, List<Integer> listReadedColumn) throws SQLException {
		appendInfoColumnData(rs, data, relatedInfoList, listReadedColumn);
	}
	
	/**
	 * save data of all viewID column in infoProcessList to end of data line
	 * when override {@link #readData(ResultSet)} consider call this method 
	 * IDEMPIERE-1970
	 * @param rs record set to read data
	 * @param data data line to append
	 * @param listReadedColumn list column is appended
	 * @throws SQLException
	 */
	protected void appendDataForKeyView(ResultSet rs, List<Object> data, List<Integer> listReadedColumn) throws SQLException {
		if (isNeedAppendKeyViewData())
			appendInfoColumnData(rs, data, new IInfoColumn [] {keyColumnOfView}, listReadedColumn);
	}
	
	/**
	 * save data of all infoColumn in listModelHaveInfoColumn to end of data line
	 * @param rs record set to read data
	 * @param data data line to append
	 * @param listModelHasInfoColumn
	 * @param listReadedColumn list column is appended
	 * @throws SQLException
	 */
	protected void appendInfoColumnData(ResultSet rs, List<Object> data, IInfoColumn [] listModelHasInfoColumn, List<Integer> listReadedColumn) throws SQLException {
		if (listModelHasInfoColumn == null || listModelHasInfoColumn.length == 0) {
			return;
		}
		
		// get InfoColumn from each modelHaveInfoColumn, read it form resultSet by name and append to data line
		for (IInfoColumn modelHasInfoColumn : listModelHasInfoColumn){
			// have no InfoColumn or this column is readed, read next column
			if (modelHasInfoColumn.getInfoColumnID() <= 0 || listReadedColumn.contains(modelHasInfoColumn.getInfoColumnID()))
				continue;

			MInfoColumn infoColumnApp = (MInfoColumn) modelHasInfoColumn.getAD_InfoColumn();
			InfoColumnVO infoColumnAppend = new InfoColumnVO(Env.getCtx(), infoColumnApp);
			Object appendData = null;
			try {
				if (DisplayType.isID(infoColumnAppend.getAD_Reference_ID())) {
					appendData = rs.getInt(infoColumnAppend.getColumnName());
				} else if (DisplayType.isDate(infoColumnAppend.getAD_Reference_ID())) {
					appendData = rs.getTimestamp(infoColumnAppend.getColumnName());
				} else if (DisplayType.isNumeric(infoColumnAppend.getAD_Reference_ID())) {
					appendData = rs.getBigDecimal(infoColumnAppend.getColumnName());
				} else {
					appendData = rs.getString(infoColumnAppend.getColumnName());
				}
			} catch (SQLException e) {
				appendData = null;
			}
			if (rs.wasNull()) {
				appendData = null;
			}
			data.add(appendData);
			
			// when need update append column index, just update it.
			if (isMustUpdateColumnIndex && !columnDataIndex.containsKey(modelHasInfoColumn.getInfoColumnID())){
				columnDataIndex.put(modelHasInfoColumn.getInfoColumnID(), indexColumnCount);
				indexColumnCount++;
			}
			
			// mark this column is readed
			listReadedColumn.add(modelHasInfoColumn.getInfoColumnID());
		}

	}

    protected void renderItems()
    {
        if (m_count > 0)
        {
        	if (m_count > pageSize)
        	{
        		if (paging == null)
        		{
	        		paging = new Paging();
	    			paging.setPageSize(pageSize);
	    			paging.setTotalSize(m_count);
	    			paging.setDetailed(true);
	    			paging.addEventListener(ZulEvents.ON_PAGING, this);
        		}
        		else
        		{
        			paging.setTotalSize(m_count);
        			paging.setActivePage(0);
        		}
    			List<Object> subList = readLine(0, pageSize);
    			model = new ListModelTable(subList);
    			model.setSorter(this);
	            model.addTableModelListener(this);
	            model.setMultiple(p_multipleSelection);
	            contentPanel.setData(model, null);

	            pageNo = 0;
        	}
        	else
        	{
        		if (paging != null)
        		{
        			paging.setTotalSize(m_count);
        			paging.setActivePage(0);
        			pageNo = 0;
        		}
	            model = new ListModelTable(readLine(0, -1));
	            model.setSorter(this);
	            model.addTableModelListener(this);
	            model.setMultiple(p_multipleSelection);
	            contentPanel.setData(model, null);
        	}
        }
        else
        {
        	if (paging != null)
    		{
    			paging.setTotalSize(m_count);
    			paging.setActivePage(0);
    			pageNo = 0;
    		}
        	model = new ListModelTable(new ArrayList<Object>());
        	model.setSorter(this);
            model.addTableModelListener(this);
            model.setMultiple(p_multipleSelection);
            contentPanel.setData(model, null);
            contentPanel.renderCustomHeaderWidth();
        }
        autoHideEmptyColumns();
        restoreSelectedInPage();
        updateStatusBar (m_count);
        setStatusSelected ();
        addDoubleClickListener();
        
        if (paging != null && paging.getParent() == null)
        	insertPagingComponent();
    }

    /**
	 * auto hide empty columns
	 */
	protected void autoHideEmptyColumns() {		
		String attr = contentPanel.getUuid()+".autoHideEmptyColumns";
		if (Executions.getCurrent().getAttribute(attr) != null) {
			return;
		} else {
			Executions.getCurrent().setAttribute(attr, Boolean.TRUE);
		}
		
		Listhead columns = contentPanel.getListhead();
		List<Listheader> columnList = columns.getChildren();
		int rowCount = model.getSize();
		
		for(Listheader column : columnList) {
			if (!isAutoHideEmptyColumns()) {
				if (!column.isVisible()) {
					Object attrValue = column.getAttribute(COLUMN_VISIBLE_ORIGINAL);
					if (attrValue != null && attrValue instanceof Boolean) {
						Boolean b = (Boolean) attrValue;
						if (b.booleanValue())
							column.setVisible(true);
					}
				}
				continue;
			}
			
			boolean hideColumn = false;
			if (rowCount > 0) {
				hideColumn = true;
				for (int i = 0; i < rowCount; i++) {
					Object value = model.getDataAt(i, column.getColumnIndex());					
					String display = value != null ? value.toString() : "";
					if (!Util.isEmpty(display, true)) {
						hideColumn = false;
						break;
					}
				}
			}
			
			if (hideColumn && column.isVisible()) {
				column.setVisible(false);
				column.setAttribute(COLUMN_VISIBLE_ORIGINAL, Boolean.TRUE);
			} else if (!hideColumn && !column.isVisible()) {
				Object attrValue = column.getAttribute(COLUMN_VISIBLE_ORIGINAL);
				if (attrValue != null && attrValue instanceof Boolean) {
					Boolean b = (Boolean) attrValue;
					if (b.booleanValue())
						column.setVisible(true);
				}
			}
		}
	}

	/**
	 * 
	 * @return true if info window should auto hide empty columns
	 */
	protected boolean isAutoHideEmptyColumns() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_INFO_AUTO_HIDE_EMPTY_COLUMNS, false, Env.getAD_Client_ID(Env.getCtx()));
	}

	protected void updateStatusBar (int no){
    	setStatusLine((no == Integer.MAX_VALUE?"?":Integer.toString(no)) + " " + Msg.getMsg(Env.getCtx(), "SearchRows_EnterQuery"), false);
        setStatusDB(no == Integer.MAX_VALUE?"?":Integer.toString(no));
    }
    
    private List<Object> readLine(int start, int end) {
    	if (useQueryTimeoutFromSysConfig)
    		queryTimeout = MSysConfig.getIntValue(MSysConfig.ZK_INFO_QUERY_TIME_OUT, 0, Env.getAD_Client_ID(Env.getCtx()));
    	
    	//cacheStart & cacheEnd - 1 based index, start & end - 0 based index
    	if (getCacheStart() >= 1 && cacheEnd > getCacheStart())
    	{
    		if (m_useDatabasePaging)
    		{
    			if (start+1 >= getCacheStart() && end+1 <= cacheEnd)
    			{
    				return end == -1 ? line : getSubList(start-getCacheStart()+1, end-getCacheStart()+1, line);
    			}
    		}
    		else
    		{
    			if (end > cacheEnd || end <= 0)
    			{
    				end = cacheEnd;
    			}
    			return getSubList (start, end, line);
    		}
    	}

    	setCacheStart(getOverIntValue((long)start + 1 - (pageSize * numPagePreLoad)));
    	if (getCacheStart() <= 0)
    		setCacheStart(1);

    	if (end == -1)
    	{
    		cacheEnd = m_count;
    	}
    	else
    	{
	    	cacheEnd = getOverIntValue(end + 1 + (pageSize * numPagePreLoad));
	    	if (cacheEnd > m_count)
	    		cacheEnd = m_count;
    	}

    	line = new ArrayList<Object>();

    	PreparedStatement m_pstmt = null;
		ResultSet m_rs = null;
		String dataSql = null;
		
		long startTime = System.currentTimeMillis();
			//

        dataSql = buildDataSQL(start, end);
        isHasNextPage = false;
        if (log.isLoggable(Level.FINER))
        	log.finer(dataSql);
        Trx trx = null;
		try
		{
			//https://jdbc.postgresql.org/documentation/head/query.html#query-with-cursor
			String trxName = Trx.createTrxName("InfoPanelLoad:");
			trx  = Trx.get(trxName, true);
			trx.setDisplayName(getClass().getName()+"_readLine");
			m_pstmt = DB.prepareStatement(dataSql, trxName);
			if (queryTimeout > 0)
				m_pstmt.setQueryTimeout(queryTimeout);
			setParameters (m_pstmt, false);	//	no count
			if (log.isLoggable(Level.FINE))
				log.fine("Start query - " + (System.currentTimeMillis()-startTime) + "ms");
			m_pstmt.setFetchSize(100);
			m_rs = m_pstmt.executeQuery();
			if (log.isLoggable(Level.FINE))
				log.fine("End query - " + (System.currentTimeMillis()-startTime) + "ms");
			//skips the row that we dont need if we can't use native db paging
			if (end > start && m_useDatabasePaging && !DB.getDatabase().isPagingSupported())
			{
				for (int i = 0; i < getCacheStart() - 1; i++)
				{
					if (!m_rs.next())
						break;
				}
			}

			int rowPointer = getCacheStart()-1;
			
			while (m_rs.next())
			{
				rowPointer++;
				// reset list column readed to start new round
				lsReadedColumn.clear();
				
				readData(m_rs);
				// just set column index only one time.
				isMustUpdateColumnIndex = false;
				
				//check now of rows loaded, break if we hit the suppose end
				if (m_useDatabasePaging && rowPointer >= cacheEnd)
				{
					isHasNextPage = true;
					break;
				}
			}
		}

		catch (SQLException e)
		{
			if (DB.getDatabase().isQueryTimeout(e))
			{
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, dataSql, e);
				Dialog.error(p_WindowNo, INFO_QUERY_TIME_OUT_ERROR);
			}
			else
			{
				log.log(Level.SEVERE, dataSql, e);
				Dialog.error(p_WindowNo, "DBExecuteError", e.getMessage());
			}
		}

		finally
		{
			DB.close(m_rs, m_pstmt);
			trx.close();
		}

		if (end > cacheEnd || end <= 0)
		{
			end = cacheEnd;
		}
		validateEndPage ();

		if (end == -1) 
		{
			return line;
		}
		else
		{
			int fromIndex = start-getCacheStart()+1;
			int toIndex = end-getCacheStart()+1;
			return getSubList(fromIndex, toIndex, line);
		}
	}

    /**
     * after query from database, process validate.
     * if end page include in cache, process calculate total record
     * if current page is out of page (no record is query) process query count to detect end page
     */
    protected void validateEndPage (){
    	if (paging == null || isLoadPageNumber())
    		return;
    	
    	if (!isHasNextPage){
    		int extraPage = ((line.size() % pageSize > 0)?1:0);
    		int pageInCache = line.size() / pageSize + extraPage;
    		
    		if (pageInCache == 0 || pageInCache <= numPagePreLoad){
    			// selected page is out of page
    			testCount();
    			extraPage = ((m_count  % pageSize > 0)?1:0);
        		pageInCache = m_count  / pageSize + extraPage;    			
    			// this one will set current page to end page
    			paging.setTotalSize(m_count);
    			Event pagingEvent = new PagingEvent("onPaging", paging, paging.getPageCount() - 1);
    			Events.postEvent(pagingEvent);
    		}else if (pageInCache > numPagePreLoad){
    			// current page isn't end page. but page in cache has end page.
    			int prePage = pageNo - numPagePreLoad;
    			int readTotalRecord = (prePage > 0?prePage:0) * pageSize + line.size();
    			paging.setTotalSize(readTotalRecord);
    			m_count = readTotalRecord;
    		}
    		
    		updateStatusBar (m_count);
    	}
    }
    
    /**
     * fromIndex and toIndex calculate with assume always query record as {@link #testCount()}
     * example after testCount we get calculate 6page.
     * when user navigate to page 4. something change in system (a batch record change become don't match with search query) 
     * let we just get 5 page with current parameter.
     * so when user navigate to page 6. user will face with index issue. (out of index or start index &gt; end index)
     * this function is fix for it.
     * @param fromIndex
     * @param toIndex
     * @param line
     * @return
     */
    protected List<Object> getSubList (int fromIndex, int toIndex, List<Object> line){
    	if (toIndex > line.size())
    		toIndex = line.size();
    	
    	if (fromIndex >= line.size())
    		fromIndex = line.size();
    	
    	// case line.size = 0
    	if (fromIndex < 0)
    		fromIndex = 0;
    	
    	return line.subList(fromIndex, toIndex);
    }
    
    /**
     * when calculator value at bound, sometime value is overflow by data type
     * this function calculator at high type for avoid it
     * @param overValue
     * @return
     */
    protected int getOverIntValue (long overValue){
    	return getOverIntValue (overValue, 0);
    }
    
    /**
     * see {@link #getOverIntValue(long)}. when value over max_value set it near max_value.
     * @param overValue
     * @param extra
     * @return
     */
    protected int getOverIntValue (long overValue, int extra){
    	if (overValue >= Integer.MAX_VALUE)
    		overValue = Integer.MAX_VALUE - extra;
    	
    	return (int)overValue;
    }
	protected String buildDataSQL(int start, int end) {
		String dataSql;
		String dynWhere = getSQLWhere();
        StringBuilder sql = new StringBuilder (m_sqlMain);
        if (dynWhere.length() > 0)
            sql.append(dynWhere);   //  includes first AND
        
        if (sql.toString().trim().endsWith("WHERE")) {
        	int index = sql.lastIndexOf(" WHERE");
        	sql.delete(index, sql.length());
        }
        
        sql.append(getUserOrderClause());
        
        dataSql = Msg.parseTranslation(Env.getCtx(), sql.toString());    //  Variables
        dataSql = MRole.getDefault().addAccessSQL(dataSql, getTableName(),
            MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
        if (end > start && m_useDatabasePaging && DB.getDatabase().isPagingSupported())
        {
        	dataSql = DB.getDatabase().addPagingSQL(dataSql, getCacheStart(), cacheEnd);
        }
		return dataSql;
	}

	/**
	 * column of grid isn't fix, it can change by display logic of column each time load data
	 * {@link InfoWindow#prepareTable(ColumnInfo[], String, String, String)}
	 * so need to validate it by compare sql of current sort column
	 */
	protected void validateOrderIndex() {
		if (indexOrderColumn > 0 && (indexOrderColumn + 1 > p_layout.length || !p_layout[indexOrderColumn].getColSQL().trim().equals(sqlOrderColumn))) {
			// try to find out new index of ordered column, in case has other column is hide or display
			for (int testIndex = 0; testIndex < p_layout.length; testIndex++) {
				if (p_layout[testIndex].getColSQL().trim().equals(sqlOrderColumn)) {
					indexOrderColumn = testIndex;
					break;
				}
			}
			
			// index still incorrect and can't find out new index (ordered column become hide column)
			if (indexOrderColumn > 0 && (indexOrderColumn + 1 > p_layout.length || !p_layout[indexOrderColumn].getColSQL().trim().equals(sqlOrderColumn))) {
				indexOrderColumn = -1;
				sqlOrderColumn = null;
				m_sqlUserOrder = null;
			}
		}
			
	}
	/**
	 * build order clause of current sort order, and save it to m_sqlUserOrder
	 * @return
	 */
	protected String getUserOrderClause() {
		validateOrderIndex();
		if (indexOrderColumn < 0) {
			return m_sqlOrder;
		}
		
		if (m_sqlUserOrder == null) {
			m_sqlUserOrder = getUserOrderClause (indexOrderColumn);
		}
		return m_sqlUserOrder;
	}
	
	/**
	 * build order clause of give column
	 * if call that function before init list will raise a NPE. care about your code
	 * @param col
	 * @return
	 */
	protected String getUserOrderClause(int col) {
		String colsql = p_layout[col].getColSQL().trim();
		int lastSpaceIdx = colsql.lastIndexOf(" ");
		if (lastSpaceIdx > 0)
		{
			String tmp = colsql.substring(0, lastSpaceIdx).trim();
			char last = tmp.charAt(tmp.length() - 1);

			String alias = colsql.substring(lastSpaceIdx).trim();
			boolean hasAlias = alias.matches("^[a-zA-Z_][a-zA-Z0-9_]*$"); // valid SQL alias - starts with letter then digits, letters, underscore

			if (tmp.toLowerCase().endsWith("as") && hasAlias)
			{
				colsql = alias;
			}
			else if (!(last == '*' || last == '-' || last == '+' || last == '/' || last == '>' || last == '<' || last == '='))
			{
				if (alias.startsWith("\"") && alias.endsWith("\""))
				{
					colsql = alias;
				}
				else
				{
					if (hasAlias)
					{
						colsql = alias;
					}
				}
			}
		}
		
		return String.format(" ORDER BY %s %s ", colsql, isColumnSortAscending? "" : "DESC");
	}

    private void addDoubleClickListener() {
    	Iterator<EventListener<? extends Event>> i = contentPanel.getEventListeners(Events.ON_DOUBLE_CLICK).iterator();
		while (i.hasNext()) {
			if (i.next() == this)
				return;
		}
		contentPanel.addEventListener(Events.ON_DOUBLE_CLICK, this);
		contentPanel.addEventListener(Events.ON_SELECT, this);
	}

    protected void insertPagingComponent() {
		contentPanel.getParent().insertBefore(paging, contentPanel.getNextSibling());
	}

    public Vector<String> getColumnHeader(ColumnInfo[] p_layout)
    {
        Vector<String> columnHeader = new Vector<String>();

        for (ColumnInfo info: p_layout)
        {
             columnHeader.add(info.getColHeader());
        }
        return columnHeader;
    }
	/**
	 * 	Test Row Count
	 *	@return true if display
	 */
	protected boolean testCount()
	{
		if (useQueryTimeoutFromSysConfig)
			queryTimeout = MSysConfig.getIntValue(MSysConfig.ZK_INFO_QUERY_TIME_OUT, 0, Env.getAD_Client_ID(Env.getCtx()));
		
		long start = System.currentTimeMillis();
		String dynWhere = getSQLWhere();
		StringBuilder sql = new StringBuilder (m_sqlCount);

		if (dynWhere.length() > 0)
			sql.append(dynWhere);   //  includes first AND

		String countSql = Msg.parseTranslation(Env.getCtx(), sql.toString());	//	Variables
		if (countSql.trim().endsWith("WHERE")) {
			countSql = countSql.trim();
			countSql = countSql.substring(0, countSql.length() - 5);
		}
		countSql = MRole.getDefault().addAccessSQL	(countSql, getTableName(),
													MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
		if (log.isLoggable(Level.FINER))
			log.finer(countSql);
		m_count = -1;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(countSql, null);
			if (queryTimeout > 0)
				pstmt.setQueryTimeout(queryTimeout);
			setParameters (pstmt, true);
			rs = pstmt.executeQuery();

			if (rs.next())
				m_count = rs.getInt(1);
		}
		catch (Exception e)
		{		
			if (e instanceof SQLException && DB.getDatabase().isQueryTimeout((SQLException) e))
			{
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, countSql, e);
				Dialog.error(p_WindowNo, INFO_QUERY_TIME_OUT_ERROR);
			}
			else
			{
				log.log(Level.SEVERE, countSql, e);
				Dialog.error(p_WindowNo, "DBExecuteError", e.getMessage());
			}
			m_count = -2;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		if (log.isLoggable(Level.FINE))
			log.fine("#" + m_count + " - " + (System.currentTimeMillis()-start) + "ms");

		return true;
	}	//	testCount


	/**
	 *	Save Selection	- Called by dispose
	 */
	protected void saveSelection ()
	{
		//	Already disposed
		if (contentPanel == null)
			return;

		if (log.isLoggable(Level.CONFIG)) log.config( "OK=" + m_ok);
		// clear prev selected result
		m_results.clear();

		if (!m_ok)      //  did not press OK
		{
			contentPanel = null;
			this.detach();
            return;
		}

		//	Multi Selection
		if (p_multipleSelection)
		{
			m_results.addAll(getSelectedRowKeys());
		}
		else    //  singleSelection
		{
			Integer data = getSelectedRowKey();
			if (data != null)
				m_results.add(data);
		}

		if (log.isLoggable(Level.CONFIG)) log.config(getSelectedSQL());

		//	Save Settings of detail info screens
		saveSelectionDetail();

	}	//	saveSelection

	/**
	 *  Get the key of currently selected row
	 *  @return selected key
	 */
	protected Integer getSelectedRowKey()
	{
		Integer key = contentPanel.getSelectedRowKey();

		return key;
	}   //  getSelectedRowKey

	/**
     *  Get the keys of selected row/s based on layout defined in prepareTable
     *  @deprecated
     *  @return IDs if selection present
     *  author ashley
     */
    protected ArrayList<Integer> getSelectedRowKeys()
    {
        ArrayList<Integer> selectedDataList = new ArrayList<Integer>();
        Collection<Integer> lsKeyValueOfSelectedRow = getSelectedRowInfo().keySet();
        if (lsKeyValueOfSelectedRow.size() == 0)
        {
            return selectedDataList;
        }

        if (p_multipleSelection)
        {        	
        	for (Integer key : lsKeyValueOfSelectedRow){        		
        		selectedDataList.add(key);
        	}
        }

        return selectedDataList;
    }   //  getSelectedRowKeys

    /**
	 *	Get selected Keys as Collection
	 *  @deprecated use getSaveKeys
	 *  @return selected keys (Integers)
	 */
	public Collection<Integer> getSelectedKeysCollection()
	{
		m_ok = true;
		saveSelection();
		if (!m_ok || m_results.size() == 0)
			return null;	
		return m_results;
	}

	/**
	 * Save selected id, viewID of all process to map viewIDMap to save into T_Selection
	 */
	public Collection<KeyNamePair> getSaveKeys (int infoCulumnId){
		// clear result from prev time
		m_viewIDMap.clear();
		
		if (p_multipleSelection)
        {
			Map <Integer, List<Object>> selectedRow = getSelectedRowInfo();
			
            for (Entry<Integer, List<Object>> selectedInfo : selectedRow.entrySet())
            {
            	// get key data column
                Integer keyData = selectedInfo.getKey();
                
                if (infoCulumnId > 0){
                	// have viewID, get it
                	int dataIndex = columnDataIndex.get(infoCulumnId) + p_layout.length;
                	
            		// get row data from model
					Object viewIDValue = selectedInfo.getValue().get(dataIndex);
                	
                	m_viewIDMap.add (new KeyNamePair(keyData, viewIDValue == null?null:viewIDValue.toString()));
                }else{
                	// hasn't viewID, set viewID value is null
                	m_viewIDMap.add (new KeyNamePair(keyData, null));
                }
                
            }
            
            return m_viewIDMap;
        }else{
        	// never has this case, because when have process, p_multipleSelection always is true
        	return null;
        }

	}
	
	/**
	 * need overrider at infoWindow to check isDisplay
	 * @return
	 */
	protected boolean isNeedAppendKeyViewData (){
		return false;
	}
		
	/**
	 * Check type of object is IDColumn
	 * @param keyData
	 * @param isCheckNull when true, raise exception when data is null
	 * @return
	 */
	protected boolean isIDColumn(Object keyData, boolean isCheckNull){
		if (isCheckNull && keyData == null){
			AdempiereException ex = getKeyNullException();
			log.severe(ex.getMessage());
			throw ex;
		}
		
		if (keyData != null && keyData instanceof IDColumn){
			return true;
		}
		
		return false;
	}
	
	/**
	 * call {@link #isIDColumn(Object, boolean)} without check null value
	 * @param keyData
	 * @return
	 */
	protected boolean isIDColumn(Object keyData){
		return isIDColumn(keyData, false);
	}
	
	/**
	 * get all selected record of current page and update to {@link #recordSelectedData}
	 * remove unselected record and add new selected record
	 * we maintain value of key, and extra value append by {@link #appendInfoColumnData(ResultSet, List, IInfoColumn[], List)} 
	 */
	protected void updateListSelected (){
		for (int rowIndex = 0; rowIndex < contentPanel.getModel().getRowCount(); rowIndex++){			
			Integer keyCandidate = getColumnValue(rowIndex);
			
			@SuppressWarnings("unchecked")
			List<Object> candidateRecord = (List<Object>)contentPanel.getModel().get(rowIndex);
					
			if (contentPanel.getModel().isSelected(candidateRecord)){
				recordSelectedData.put(keyCandidate, candidateRecord);// add or update selected record info				
			}else{
				if (recordSelectedData.containsKey(keyCandidate)){// unselected record
					List<Object> recordSelected = recordSelectedData.get(keyCandidate);
					IDColumn idcSel = null;
					if (recordSelected.get(0) instanceof IDColumn) {
						idcSel = (IDColumn) recordSelected.get(0);
					}
					IDColumn idcCan = null;
					if (candidateRecord.get(0) instanceof IDColumn) {
						idcCan = (IDColumn) candidateRecord.get(0);
					}
					if (idcSel != null && idcCan != null && idcSel.getRecord_ID().equals(idcCan.getRecord_ID())) {
						recordSelected.set(0, candidateRecord.get(0)); // set same IDColumn for comparison
					}
					if (recordSelected.equals(candidateRecord)) {
						recordSelectedData.remove(keyCandidate);
					}
				}
			}
			
		}		    
	}
	
	/**
	 * get data index of keyView
	 * @return
	 */
	protected int getIndexKeyColumnOfView (){
		if (keyColumnOfView == null){
			return contentPanel.getKeyColumnIndex();
		}else if (isNeedAppendKeyViewData()){
			return columnDataIndex.get(keyColumnOfView.getInfoColumnID()) + p_layout.length;
		}else{
			return indexKeyOfView;
		}
	}	
	
	/**
	 * go through all data record, in case key value is in {@link #recordSelectedData}, mark it as selected record
	 */
	protected void restoreSelectedInPage (){
		if (!p_multipleSelection)
			return;
		
		Collection<Object> lsSelectionRecord = new ArrayList<Object>();
		for (int rowIndex = 0; rowIndex < contentPanel.getModel().getRowCount(); rowIndex++){
			Integer keyViewValue = getColumnValue(rowIndex);
			if (recordSelectedData.containsKey(keyViewValue)){
				// TODO: maybe add logic to check value of current record (focus only to viewKeys value) is same as value save in lsSelectedKeyValue
				// because record can change by other user
				Object row = contentPanel.getModel().get(rowIndex);
								
				if(onRestoreSelectedItemIndexInPage(keyViewValue, rowIndex, row)) // F3P: provide an hook for operations on restored index
					lsSelectionRecord.add(row);
			}
		}
		
		contentPanel.getModel().setSelection(lsSelectionRecord);
	}
	
	/** Hook to intercept 'restore selection' actions 
	 * 
	 * @param keyViewValue row view key
	 * @param rowIndex row index
	 * @param row row
	 * @return false to skip restore selection
	 */
	public boolean onRestoreSelectedItemIndexInPage(Integer keyViewValue, int rowIndex, Object row)
	{
		return true;
	}
		
	protected AdempiereException getKeyNullException (){
		String errorMessage = String.format("has null value at column %1$s use as key of view in info window %2$s", 
				keyColumnOfView == null ? p_keyColumn : keyColumnOfView, infoWindow.getName());
		return new AdempiereException(errorMessage);
	}
	/**
	 * get keyView value at rowIndex and clumnIndex
	 * also check in case value is null will rise a exception
	 * @param rowIndex
	 * @return
	 */
	protected Integer getColumnValue (int rowIndex){
		
		int keyIndex = getIndexKeyColumnOfView();
		Integer keyValue = null;
    	// get row data from model
		Object keyColumValue = contentPanel.getModel().getDataAt(rowIndex, keyIndex);
		// throw exception when value is null
		if (keyColumValue == null){
			AdempiereException ex = getKeyNullException();
			log.severe(ex.getMessage());
			throw ex;
		}
		
		// IDColumn is recreate after change page, because use value of IDColumn
		if (keyColumValue != null && keyColumValue instanceof IDColumn){
			keyColumValue = ((IDColumn)keyColumValue).getRecord_ID();
		}
		
		if (keyColumValue instanceof Integer){
			keyValue = (Integer)keyColumValue;
		}else {
			String msg = "keyView column must be integer";
			AdempiereException ex = new AdempiereException (msg);
			log.severe(msg);
			throw ex;
		}
		
		return (Integer)keyValue;
	}
	
	/**
	 * in case requery data, but want store selected record (example when run success a process)
	 * we must sync selected row, because some selected row maybe not at data list (process make it change not map with query)
	 * current 1000 line cache 
	 * because in case query get more 1000 record we can't sync or maintain selected record (ever maintain for current page will make user confuse).
	 * just clear selection
	 * in case &lt; 1000 record is ok
	 * TODO:rewrite
	 */
	protected void syncSelectedAfterRequery (){
		if (isRequeryByRunSuccessProcess){
			isRequeryByRunSuccessProcess = false;
			//TODO:it's hard to ensure in case use keyViewId we can re-sync. some issue:
			// + after RunSuccessProcess maybe key of record is change.
			// + after RunSuccessProcess maybe value of viewID change.
			// + after RunSuccessProcess maybe some record is out of query result
			// + when load many page, sync at one time effect to performance
			// maybe make two list, just sync for first page, old list use for reference, 
			// when user change page will use it for restore selected record, synced record will copy to new list
		}
	}
	
	/**
	 * update list column key value of selected record and return this list
	 * @return {@link #recordSelectedData} after update 
	 */
	public Map<Integer, List<Object>> getSelectedRowInfo (){
		updateListSelected();
		return recordSelectedData;
	}
	
	
	/**
	 *	Get selected Keys
	 *  @return selected keys (Integers)
	 */
	public Object[] getSelectedKeys()
	{
		if (!m_ok || m_results.size() == 0)
			return null;
		return m_results.toArray(new Integer[0]);
	}	//	getSelectedKeys;

	/**
	 *	Get (first) selected Key
	 *  @return selected key
	 */
	public Object getSelectedKey()
	{
		if (!m_ok || m_results.size() == 0)
			return null;
		return m_results.get(0);
	}	//	getSelectedKey

	/**
	 *	Is cancelled?
	 *	- if pressed Cancel = true
	 *	- if pressed OK or window closed = false
	 *  @return true if cancelled
	 */
	public boolean isCancelled()
	{
		return m_cancel;
	}	//	isCancelled

	/**
	 *	Get where clause for (first) selected key
	 *  @return WHERE Clause
	 */
	public String getSelectedSQL()
	{
		//	No results
		Object[] keys = getSelectedKeys();
		if (keys == null || keys.length == 0)
		{
			if (log.isLoggable(Level.CONFIG)) log.config("No Results - OK="
						+ m_ok + ", Cancel=" + m_cancel);
			return "";
		}
		//
		StringBuilder sb = new StringBuilder(getKeyColumn());
		if (keys.length > 1)
			sb.append(" IN (");
		else
			sb.append("=");

		//	Add elements
		for (int i = 0; i < keys.length; i++)
		{
			if (getKeyColumn().endsWith("_ID"))
				sb.append(keys[i].toString()).append(",");
			else
				sb.append("'").append(keys[i].toString()).append("',");
		}

		sb.replace(sb.length()-1, sb.length(), "");
		if (keys.length > 1)
			sb.append(")");
		return sb.toString();
	}	//	getSelectedSQL;

	/**
	 * query ADInfoWindow from ADInfoWindowID
	 */
	protected void loadInfoWindowData (){}

	/**
	 *  Get Table name Synonym
	 *  @return table name
	 */
	protected String getTableName()
	{
		return p_tableName;
	}   //  getTableName

	/**
	 *  Get Key Column Name
	 *  @return column name
	 */
	protected String getKeyColumn()
	{
		return p_keyColumn;
	}   //  getKeyColumn


	public String[] getEvents()
    {
        return InfoPanel.lISTENER_EVENTS;
    }

	/**
	 * enable all control button or disable all rely to selected record 
	 */
	protected void enableButtons (){
		boolean enable = (contentPanel.getSelectedCount() > 0 || getSelectedRowInfo().size() > 0);
		enableButtons(enable);
	}
	
	// Elaine 2008/11/28
	/**
	 * enable or disable all control button
	 *  Enable OK, History, Zoom if row/s selected
     *  ---
     *  Changes: Changed the logic for accommodating multiple selection
     *  author ashley
	 */
	protected void enableButtons (boolean enable)
	{
		confirmPanel.getOKButton().setEnabled(enable); //red1 allow Process for 1 or more records

		if (hasHistory())
			confirmPanel.getButton(ConfirmPanel.A_HISTORY).setEnabled(enable);
		if (hasZoom())
			confirmPanel.getButton(ConfirmPanel.A_ZOOM).setEnabled(!enable?enable : (contentPanel.getSelectedCount() == 1) ); //red1 only zoom for single record
		if (hasProcess())
			confirmPanel.getButton(ConfirmPanel.A_PROCESS).setEnabled(enable);
		// IDEMPIERE-1334 start
		for (Button btProcess : btProcessList){
			btProcess.setEnabled(enable);
		}
		if (btCbbProcess != null){
			btCbbProcess.setEnabled(enable);
		}
		
		if (btMenuProcess != null){
			btMenuProcess.setEnabled(enable);
		}
		
		if (cbbProcess != null){
			cbbProcess.setEnabled(enable);
		}
		// IDEMPIERE-1334 end
	}   //  enableButtons
	//

	/**************************************************************************
	 *  Get dynamic WHERE part of SQL
	 *	To be overwritten by concrete classes
	 *  When override this method, please consider isQueryByUser and prevWhereClause 
	 *  @return WHERE clause
	 */
	protected abstract String getSQLWhere();

	/**
	 *  Set Parameters for Query
	 *	To be overwritten by concrete classes
	 *  When override this method, please consider isQueryByUser and prevWhereClause
	 *  @param pstmt statement
	 *  @param forCount for counting records
	 *  @throws SQLException
	 */
	protected abstract void setParameters (PreparedStatement pstmt, boolean forCount)
		throws SQLException;
    /**
     * notify to search editor of a value change in the selection info
     */
	protected void showHistory()					{}
	/**
	 *  Has History (false)
	 *	To be overwritten by concrete classes
	 *  @return true if it has history (default false)
	 */
	protected boolean hasHistory()				{return false;}
	/**
	 *  Customize dialog
	 *	To be overwritten by concrete classes
	 */
	protected boolean hasProcess()				{return false;}
	/**
	 *  Customize dialog
	 *	To be overwritten by concrete classes
	 */	
	protected void customize()					{}
	/**
	 *  Has Customize (false)
	 *	To be overwritten by concrete classes
	 *  @return true if it has customize (default false)
	 */
	protected boolean hasCustomize()				{return false;}
	/**
	 *  Has Zoom (false)
	 *	To be overwritten by concrete classes
	 *  @return true if it has zoom (default false)
	 */
	protected boolean hasZoom()					{return false;}
	/**
	 *  Has new function for create new record (false)
	 *	To be overwritten by concrete classes 
	 * @return
	 */
	protected boolean hasNew()					{return false;}
	/**
	 *  Save Selection Details
	 *	To be overwritten by concrete classes
	 *  this function call when close info window.
	 *  default infoWindow will set value of all column of current selected record to environment variable with {@link Env#TAB_INFO}
	 *  class extends can do more by override it. 
	 */
	protected void saveSelectionDetail()          {}

	/**
	 * 	Get Zoom Window
	 *	@param tableName table name
	 *	@param isSOTrx sales trx
	 *	@return AD_Window_ID
	 */
	protected int getAD_Window_ID (String tableName, boolean isSOTrx)
	{
		if (!isSOTrx && m_PO_Window_ID > 0)
			return m_PO_Window_ID;
		if (m_SO_Window_ID > 0)
			return m_SO_Window_ID;
		//
		MTable table = MTable.get(Env.getCtx(), tableName);
		if (table != null)
		{
			m_SO_Window_ID = table.getAD_Window_ID();
			m_PO_Window_ID = table.getPO_Window_ID();
		}
		//
		if (!isSOTrx && m_PO_Window_ID > 0)
			return m_PO_Window_ID;
		return m_SO_Window_ID;
	}	//	getAD_Window_ID

    public void onEvent(Event event)
    {
        if  (event == null){
        	return;
        }
        
        if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_OK)))
        {
            onOk();
        }
        else if (event.getTarget() == contentPanel && event.getName().equals(Events.ON_SELECT))
        {
        	setStatusSelected ();
        	
        	SelectEvent<?, ?> selectEvent = (SelectEvent<?, ?>) event;
        	if (selectEvent.getReference() != null && selectEvent.getReference() instanceof Listitem)
        	{
        		Listitem m_lastOnSelectItem = (Listitem) selectEvent.getReference();
        		m_lastSelectedIndex = m_lastOnSelectItem.getIndex();
       		}

        	enableButtons();
        	
        }else if (event.getTarget() == contentPanel && event.getName().equals("onAfterRender")){           	
        	//IDEMPIERE-1334 at this event selected item from listBox and model is sync
        	enableButtons();
        }
        else if (event.getTarget() == contentPanel && event.getName().equals(Events.ON_DOUBLE_CLICK))
        {
        	if (event.getClass().equals(MouseEvent.class)){
        		return;
        	}
        	if (contentPanel.isMultiple() && m_lastSelectedIndex >= 0) {
				
        		contentPanel.setSelectedIndex(m_lastSelectedIndex);
				
        		model.clearSelection();
				List<Object> lsSelectedItem = new ArrayList<Object>();
				lsSelectedItem.add(model.getElementAt(m_lastSelectedIndex));
				model.setSelection(lsSelectedItem);
				
				int m_keyColumnIndex = contentPanel.getKeyColumnIndex();
				for (int i = 0; i < contentPanel.getRowCount(); i++) {
					// Find the IDColumn Key
					Object data = contentPanel.getModel().getValueAt(i, m_keyColumnIndex);
					if (data instanceof IDColumn) {
						IDColumn dataColumn = (IDColumn) data;

						if (i == m_lastSelectedIndex) {
							dataColumn.setSelected(true);
						}
						else {
							dataColumn.setSelected(false);
						}
					}
				}
        	}
        	onDoubleClick();
        	contentPanel.repaint();
        	m_lastSelectedIndex = -1;
        }
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_REFRESH)))
        {
        	onUserQuery();
        }
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_CANCEL)))
        {
        	onCancel();
        }
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_RESET))) {
        	resetParameters ();
        }
        // Elaine 2008/12/16
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_HISTORY)))
        {
        	if (!contentPanel.getChildren().isEmpty() && contentPanel.getSelectedRowKey()!=null)
            {
        		showHistory();
            }
        }
		else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_CUSTOMIZE)))
		{
        	if (!contentPanel.getChildren().isEmpty() && contentPanel.getSelectedRowKey()!=null)
            {
        		customize();
            }
		}
        //
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_ZOOM)))
        {
            if (!contentPanel.getChildren().isEmpty() && contentPanel.getSelectedRowKey()!=null)
            {
                zoom();
                if (isLookup())
                	this.detach();
            }
        }
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_NEW)))
        {
        	newRecordAction ();
        }
        // IDEMPIERE-1334 handle event click into process button start
        else if (ON_RUN_PROCESS.equals(event.getName())){
        	// hand echo event after click button process
        	runProcess((Integer)event.getData());        
        }else if (Events.ON_CLICK.equals(event.getName()) &&        		
        		event.getTarget() != null && event.getTarget() instanceof Menuitem && 
        		event.getTarget().getAttribute(PROCESS_ID_KEY) != null){
        	// handle event when click to menu item of info process 
        	preRunProcess((Integer)event.getTarget().getAttribute(PROCESS_ID_KEY));        	
        }
        else if (event.getTarget().equals(btCbbProcess)){
        	// click bt process in case display drop down list
        	Comboitem cbbSelectedItem = cbbProcess.getSelectedItem();

        	if (cbbSelectedItem == null || cbbSelectedItem.getValue() == null){
        		// do nothing when no process is selected
        		return;
        	}
            		
        	MProcess selectedProcess = (MProcess)cbbSelectedItem.getValue();
        	preRunProcess(selectedProcess.getAD_Process_ID());
        }
        else if (btProcessList.contains(event.getTarget())){
        	// click bt process in case display button list
        	Button btProcess = (Button)event.getTarget();
        	Integer processId =  (Integer)btProcess.getAttribute(PROCESS_ID_KEY);

        	preRunProcess (processId);
							}
        // IDEMPIERE-1334 handle event click into process button end
        else if (event.getTarget() == paging)
        {
        	updateListSelected();
        	int pgNo = paging.getActivePage();
        	if (pgNo == paging.getPageCount()-1  && !isLoadPageNumber()) {
        		testCount();
        		paging.setTotalSize(m_count);
        		pgNo = paging.getActivePage();
        	}

        	if (pageNo != pgNo)
        	{

        		contentPanel.clearSelection();

        		pageNo = pgNo;
        		int start = pageNo * pageSize;
        		int end = getOverIntValue ((long)start + pageSize, extra_max_row);
        		if (end >= m_count)
        			end = m_count;
        		List<Object> subList = readLine(start, end);
    			model = new ListModelTable(subList);
    			model.setSorter(this);
	            model.addTableModelListener(this);
	            model.setMultiple(p_multipleSelection);
	            contentPanel.setData(model, null);
	            restoreSelectedInPage();
				//contentPanel.setSelectedIndex(0);
	            
			}
        	autoHideEmptyColumns();
        }
        else if (event.getName().equals(Events.ON_CHANGE))
        {
        }
        else if (event.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT))
    	{
    		if (infoWindow != null)
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Info, infoWindow.getAD_InfoWindow_ID());
			else
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0);
    	}
        else if (event.getName().equals(Events.ON_CTRL_KEY))
        {
    		KeyEvent keyEvent = (KeyEvent) event;
    		if (LayoutUtils.isReallyVisible(this)) {
    			this.onCtrlKeyEvent(keyEvent);
    		}
    	}else if (event.getName().equals(Events.ON_OK)){// on ok when focus at non parameter component. example grid result
        	if (m_lookup && contentPanel.getSelectedIndex() >= 0){
    			// do nothing when parameter not change and at window mode, or at dialog mode but select non record    			
    			onOk();
    		}
        	else if (m_infoWindowID == 0 && event.getTarget() instanceof InfoGeneralPanel) {
        		onUserQuery();
        	}
    	}else if (event.getName().equals(Events.ON_CANCEL) || (event.getTarget().equals(this) && event.getName().equals(Events.ON_CLOSE))){
    		onCancel();
    	}
        //when user push enter keyboard at input parameter field
        else
        {
        	// onUserQuery(); // captured now on control key
        }
    }  //  onEvent

	protected void onCancel() {
		m_cancel = true;
		dispose(false);
	}

    public static final int VK_ENTER          = '\r';
    public static final int VK_ESCAPE         = 0x1B;
	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		if (keyEvent.isAltKey() && !keyEvent.isCtrlKey() && keyEvent.isShiftKey()) { // Shift+Alt
			if (keyEvent.getKeyCode() == KeyEvent.DOWN) { // Shift+Alt+Down
				// navigate to results
				if (contentPanel.getRowCount() > 0) {
					contentPanel.setFocus(true);
					contentPanel.setSelectedIndex(0);
				}
			}
		} else if (keyEvent.getKeyCode() == VK_ENTER) { // Enter
			// do nothing, let on_ok at infoWindo do, at this is too soon to get value from control, it's not bind
		}
	}

    /**
     * Call query when user click to query button enter in parameter field
     */
    public void onUserQuery (){
    	if (Executions.getCurrent().getAttribute(ON_USER_QUERY_ATTR) != null)
    		return;
    	
    	Executions.getCurrent().setAttribute(ON_USER_QUERY_ATTR, Boolean.TRUE);
    	if (validateParameters()){
            showBusyDialog();
            isQueryByUser = true;
            Clients.response(new AuEcho(this, "onQueryCallback", null));
        }
    }
    
    /**
    * validate parameter before run query
    * @return
    */
    public boolean validateParameters(){
    	return true;
    }

	/**
	 * Call after load parameter panel to set init value can call when reset
	 * parameter implement this method at inheritance class
	 * with each parameter, remember call Env.setContext to set new value to env  
	 */
	protected void initParameters() {

	}
	
	/**
	 * Update relate info when selection in main info change
	 */
	protected void updateSubcontent (){ updateSubcontent(-1);};
	
	/**
	 * Update relate info for a specific row, if targetRow &lt; 0 update using selected row
	 * @param targetRow
	 */
	protected void updateSubcontent (int targetRow){};


	/**
	 * Reset parameter to default value or to empty value? implement at
	 * inheritance class when reset parameter maybe need init again parameter,
	 * reset again default value
	 */
	protected void resetParameters() {
	}
    
    void preRunProcess (Integer processId){
    	// disable all control button when run process
    	enableButtons(false);
    	// call run process in next request to disable all button control
    	Events.echoEvent(ON_RUN_PROCESS, this, processId);
    }
    
    /**
     * Run a process.
     * show process dialog,
     * before start process, save id of record selected
     * after run process, show message report result 
     * @param processIdObj
     */
    protected void runProcess (Object processIdObj){
    	final Integer processId = (Integer)processIdObj;
    	final MProcess m_process = MProcess.get(Env.getCtx(), processId);
    	final ProcessInfo m_pi = new ProcessInfo(m_process.getName(), processId);
		m_pi.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));

		MPInstance instance = new MPInstance(Env.getCtx(), processId, 0);
		instance.saveEx();
		final int pInstanceID = instance.getAD_PInstance_ID();
		// devCoffee - enable use of special forms from process related with info windows
		m_pi.setAD_PInstance_ID(pInstanceID);

		int adFormID = m_process.getAD_Form_ID();
	    if (adFormID != 0 )
	    {
	            String title = m_process.getName();
	            if (title == null || title.length() == 0)
	                title = m_process.getValue();

	            // store in T_Selection table selected rows for Execute Process that retrieves from T_Selection in code.
	            DB.createT_SelectionNew(pInstanceID, getSaveKeys(getInfoColumnIDFromProcess(processId)), null);

	            ADForm form = ADForm.openForm(adFormID, null, m_pi);
	            Mode mode = form.getWindowMode();
	            form.setAttribute(Window.MODE_KEY, form.getWindowMode());
	            form.setAttribute(Window.INSERT_POSITION_KEY, Window.INSERT_NEXT);

	            if (mode == Mode.HIGHLIGHTED || mode == Mode.MODAL) {
	                form.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
	                    @Override
	                    public void onEvent(Event event) throws Exception {
	                        ;
	                    }
	                });
	                form.doHighlighted();
	                form.focus();
	            }
	            else {
	                form.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {
	                    @Override
	                    public void onEvent(Event event) throws Exception {
	                        updateListSelected();
	                        recordSelectedData.clear();
	                        Clients.response(new AuEcho(InfoPanel.this, "onQueryCallback", null));
	                        onUserQuery();
	                    }
	                });

	                SessionManager.getAppDesktop().showWindow(form);
	            }
	            return;
	    }
		// Execute Process
		m_pi.setAD_PInstance_ID(pInstanceID);		
		m_pi.setAD_InfoWindow_ID(infoWindow.getAD_InfoWindow_ID());
		
		//HengSin - to let process end with message and requery
		WProcessCtl.process(p_WindowNo, m_pi, (Trx)null, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				ProcessModalDialog processModalDialog = (ProcessModalDialog)event.getTarget();
				if (DialogEvents.ON_BEFORE_RUN_PROCESS.equals(event.getName())){
					updateListSelected();
					// store in T_Selection table selected rows for Execute Process that retrieves from T_Selection in code.
					DB.createT_SelectionNew(pInstanceID, getSaveKeys(getInfoColumnIDFromProcess(processModalDialog.getAD_Process_ID())),
						null);	
					saveResultSelection(getInfoColumnIDFromProcess(processModalDialog.getAD_Process_ID()));
					createT_Selection_InfoWindow(pInstanceID);
					recordSelectedData.clear();
				}else if (ProcessModalDialog.ON_WINDOW_CLOSE.equals(event.getName())){ 
					if (processModalDialog.isCancel()){
						//clear back 
						m_results.clear();
						// enable or disable control button rely selected record status 
						enableButtons();
					}else if (m_pi.isError()){
						ProcessInfoDialog.showProcessInfo(m_pi, p_WindowNo, InfoPanel.this, true);
						// enable or disable control button rely selected record status 
						enableButtons();
					}else if (!m_pi.isError()){						
						if (isCloseAfterExecutionOfProcess()) {
							ProcessInfoUtil.setLogFromDB(m_pi);
							ProcessInfoLog[] logs = m_pi.getLogs();
							if (logs != null && logs.length > 0) {
								ProcessInfoDialog dialog = ProcessInfoDialog.showProcessInfo(m_pi, p_WindowNo, InfoPanel.this, false);
								dialog.addEventListener(DialogEvents.ON_WINDOW_CLOSE, e -> InfoPanel.this.detach());
							} else {
								detach();
							}
						} else {
							ProcessInfoDialog.showProcessInfo(m_pi, p_WindowNo, InfoPanel.this, true);
							isRequeryByRunSuccessProcess = true;
							Clients.response(new AuEcho(InfoPanel.this, "onQueryCallback", null));
						}
					}
					recordSelectedData.clear();
				}
				
		//HengSin -- end --
			}
		});   		
    }
   
    
    /**
	 * save result values
	 */
	protected void saveResultSelection(int infoColumnId) {
		int m_keyColumnIndex = contentPanel.getKeyColumnIndex();
		if (m_keyColumnIndex == -1) {
			return;
		}

		m_values = new LinkedHashMap<KeyNamePair,LinkedHashMap<String,Object>>();
		
		if (p_multipleSelection) {
				
			Map <Integer, List<Object>> selectedRow = getSelectedRowInfo();
			
			// for selected rows
            for (Entry<Integer, List<Object>> selectedInfo : selectedRow.entrySet())
            {
            	// get key and viewID
                Integer keyData = selectedInfo.getKey();
                KeyNamePair kp = null;
                
                if (infoColumnId > 0){
                	int dataIndex = columnDataIndex.get(infoColumnId) + p_layout.length;
                	Object viewIDValue = selectedInfo.getValue().get(dataIndex);
                	kp = new KeyNamePair(keyData, viewIDValue == null ? null : viewIDValue.toString());
                }else{
                	kp = new KeyNamePair(keyData, null);
                }
                
                // get Data
				LinkedHashMap<String, Object> values = new LinkedHashMap<String, Object>();
				for(int col  = 0 ; col < p_layout.length; col ++)
				{
					// layout has same columns as selectedInfo
					if (!p_layout[col].isReadOnly())
						values.put(p_layout[col].getColumnName(), selectedInfo.getValue().get(col));
				}
				if(values.size() > 0)
					m_values.put(kp, values);
            }
		}
	} // saveResultSelection
	
	/**
	 * Insert result values
	 * @param AD_PInstance_ID
	 */
	public void createT_Selection_InfoWindow(int AD_PInstance_ID)
	{
		StringBuilder insert = new StringBuilder();
		insert.append("INSERT INTO T_Selection_InfoWindow (AD_PINSTANCE_ID, T_SELECTION_ID, COLUMNNAME , VALUE_STRING, VALUE_NUMBER , VALUE_DATE ) VALUES(?,?,?,?,?,?) ");
		for (Entry<KeyNamePair,LinkedHashMap<String, Object>> records : m_values.entrySet()) {
			//set Record ID
			
				LinkedHashMap<String, Object> fields = records.getValue();
				for(Entry<String, Object> field : fields.entrySet())
				{
					List<Object> parameters = new ArrayList<Object>();
					parameters.add(AD_PInstance_ID);
					
					Object key = records.getKey();
					
					if(key instanceof KeyNamePair)
					{
						KeyNamePair knp = (KeyNamePair)key;
						parameters.add(knp.getKey());
					}
					else
					{
						parameters.add(key);
					}

					parameters.add(field.getKey());
					
					Object data = field.getValue();
					// set Values					
					if (data instanceof IDColumn)
					{
						IDColumn id = (IDColumn) data;
						parameters.add(null);
						parameters.add(id.getRecord_ID());
						parameters.add(null);
					}					
					else if (data instanceof String)
					{
						parameters.add(data);
						parameters.add(null);
						parameters.add(null);
					}
					else if (data instanceof BigDecimal || data instanceof Integer || data instanceof Double)
					{
						parameters.add(null);
						if(data instanceof Double)
						{	
							BigDecimal value = BigDecimal.valueOf((Double)data);
							parameters.add(value);
						}	
						else	
							parameters.add(data);
						parameters.add(null);
					}
					else if (data instanceof Integer)
					{
						parameters.add(null);
						parameters.add((Integer)data);
						parameters.add(null);
					}
					else if (data instanceof Timestamp || data instanceof Date)
					{
						parameters.add(null);
						parameters.add(null);
						if(data instanceof Date)
						{
							Timestamp value = new Timestamp(((Date)data).getTime());
							parameters.add(value);
						}
						else 
						parameters.add(data);
					}
					else if(data instanceof KeyNamePair)
					{
						KeyNamePair knpData = (KeyNamePair)data;
						
						parameters.add(null);
						parameters.add(knpData.getKey());
						parameters.add(null);						
					}
					else
					{
						parameters.add(data);
						parameters.add(null);
						parameters.add(null);
					}
					DB.executeUpdateEx(insert.toString(),parameters.toArray() , null);
						
				}
		}
	} // createT_Selection_InfoWindow
	
    /**
     * Get InfoColumnID of infoProcess have processID is processId
     * @param processId
     * @return value InfoColumnID, -1 when has not any map
     */
    protected int getInfoColumnIDFromProcess (int processId){
    	for (int i = 0; i < infoProcessList.length; i++){
    		if (infoProcessList[i].getAD_Process_ID() == processId){
    			return infoProcessList[i].getAD_InfoColumn_ID();
    		}
    	}
    	return -1;
    }
   

	private void showBusyDialog() {
		progressWindow = new BusyDialog();
		progressWindow.setPage(this.getPage());
		progressWindow.doHighlighted();
	}

	private void hideBusyDialog() {		
		if (progressWindow != null) {
			progressWindow.dispose();
			progressWindow = null;
		}		
	}

	protected void correctHeaderOrderIndicator() {
		Listhead listHead = contentPanel.getListHead();
		if (listHead != null) {
			List<?> headers = listHead.getChildren();
			for(Object obj : headers)
			{
				Listheader header = (Listheader) obj;
				// idempiere use mix method. sometime call model method, sometime call component method
				// so index can be difference on complicate case, just wait to fix
				if (header.getColumnIndex() == indexOrderColumn)
	              header.setSortDirection(isColumnSortAscending?"ascending":"descending");
	            else
	              header.setSortDirection("natural");
			}
		}
	}
    public void onQueryCallback(Event event)
    {
    	try
    	{
    		// event == null mean direct call from reset button
    		if (event == null)
    			m_count = 0;
    		else
    			executeQuery();
    		
            renderItems();

            correctHeaderOrderIndicator();
            
        	// IDEMPIERE-1334 after refresh, restore prev selected item start         	
        	// just evaluate display logic of process button when requery by use click requery button
        	if (isQueryByUser){
        		bindInfoProcess();
        		// reset selected list
                recordSelectedData.clear();
                isRequeryByRunSuccessProcess = false;
        	}
        	if (isRequeryByRunSuccessProcess){
        		syncSelectedAfterRequery();
        		restoreSelectedInPage();
        	}
        	// IDEMPIERE-1334 after refresh, restore prev selected item end
        	updateSubcontent ();
        }
    	finally
    	{
    		isQueryByUser = false;
    		hideBusyDialog();
    	}
    }

    /**
    * evaluate display logic of button process
    * empty method. implement at child class extend
    */
    protected void bindInfoProcess (){}
    
    protected void onOk()
    {
		if (!contentPanel.getChildren().isEmpty() && getSelectedRowInfo().size() > 0)
		{
		    dispose(true);
		}
	}

    protected void onDoubleClick()
	{
		if (isLookup())
		{
			dispose(true);
		}
		else
		{
			zoom();
		}

	}

    public void tableChanged(WTableModelEvent event)
    {
    	enableButtons();
    }

    public void zoom()
    {    	
    	Integer recordId = contentPanel.getSelectedRowKey();
    	// prevent NPE when double click is raise but no recore is selected
    	if (recordId == null)
    		return;
    	
    	if (listeners != null && listeners.size() > 0)
    	{
	        ValueChangeEvent event = new ValueChangeEvent(this,"zoom",
	                   contentPanel.getSelectedRowKey(),contentPanel.getSelectedRowKey());
	        fireValueChange(event);
    	}
    	else
    	{    		
    		int AD_Table_ID = MTable.getTable_ID(p_tableName);
    		if (AD_Table_ID <= 0)
    		{
    			if (p_keyColumn.endsWith("_ID"))
    			{
    				AD_Table_ID = MTable.getTable_ID(p_keyColumn.substring(0, p_keyColumn.length() - 3));
    			}
    		}
    		if (AD_Table_ID > 0)
    			AEnv.zoom(AD_Table_ID, recordId);
    	}
    }

    /**
     * process action when user click to new button
     */
    protected void newRecordAction (){}
    
    public void addValueChangeListener(ValueChangeListener listener)
    {
        if (listener == null)
        {
            return;
        }

        listeners.add(listener);
    }

    public void fireValueChange(ValueChangeEvent event)
    {
        for (ValueChangeListener listener : listeners)
        {
           listener.valueChange(event);
        }
    }
    /**
     *  Dispose and save Selection
     *  @param ok OK pressed
     */
    public void dispose(boolean ok)
    {
    	if (log.isLoggable(Level.CONFIG)) log.config("OK=" + ok);
        m_ok = ok;
        //  End Worker
        if (isLookup())
        {
        	saveSelection();
        }
        if (Window.MODE_EMBEDDED.equals(getAttribute(Window.MODE_KEY)))
        	SessionManager.getAppDesktop().closeActiveWindow();
        else
	        this.detach();
    }   //  dispose

    private void saveWlistBoxColumnWidth(Component comp){

        if(comp instanceof WListbox){
        	((WListbox)comp).saveColumnWidth();
        }

        List<Component> list = comp.getChildren();
        for(Component child:list){
        	saveWlistBoxColumnWidth(child);
        }
     } 
    
	public void sort(Comparator<Object> cmpr, boolean ascending) {
		updateListSelected();
		WListItemRenderer.ColumnComparator lsc = (WListItemRenderer.ColumnComparator) cmpr;
		
		// keep column order
		int col = lsc.getColumnIndex();
		indexOrderColumn = col;
		isColumnSortAscending = ascending;
		sqlOrderColumn = p_layout[col].getColSQL().trim();
		m_sqlUserOrder = null; // clear cache value
		
		if (m_useDatabasePaging)
		{
			executeQuery();
		}
		else
		{
			Collections.sort(line, lsc);
		}
		renderItems();
	}

    public boolean isLookup()
    {
    	return m_lookup;
    }

    public void scrollToSelectedRow()
    {
    	if (contentPanel != null && contentPanel.getSelectedIndex() >= 0) {
    		Listitem selected = contentPanel.getItemAtIndex(contentPanel.getSelectedIndex());
    		if (selected != null) {
    			selected.focus();
    		}
    	}
    }
    
	@Override
	public String getSortDirection(Comparator<Object> cmpr) {
		return "natural";
	}

	public int getWindowNo() {
		return p_WindowNo;
	}
	
	public int getRowCount() {
		return contentPanel.getRowCount();
	}
	
	public Integer getFirstRowKey() {
		return contentPanel.getFirstRowKey();
	}

	public Integer getRowKeyAt(int row) {
		return contentPanel.getRowKeyAt(row);
	}

	/**
	 * @return the cacheStart
	 */
	protected int getCacheStart() {
		return cacheStart;
	}

	/**
	 * @param cacheStart the cacheStart to set
	 */
	private void setCacheStart(int cacheStart) {
		this.cacheStart = cacheStart;
	}
	
	/**
	 * @return the cacheEnd
	 */
	protected int getCacheEnd() {
		return cacheEnd;
	}
	
	protected boolean isUseDatabasePaging() {
		return m_useDatabasePaging;
	}
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			if (infoWindow != null)
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Info, infoWindow.getAD_InfoWindow_ID());
			else
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0);
		}
		SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		try {
			if (SessionManager.getSessionApplication() != null &&
				SessionManager.getSessionApplication().getKeylistener() != null)
				SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
			if (getFirstChild() != null)
				saveWlistBoxColumnWidth(getFirstChild());
		} catch (Exception e){
			log.log(Level.WARNING, e.getMessage(), e);
		}
	}

	/**
	 * field call this info panel as search editor
	 * null in case info window open in stand-alone window (from menu, fav,...) 
	 * @return
	 */
	public GridField getGridfield() {
		return m_gridfield;
	}

	public void setGridfield(GridField m_gridfield) {
		this.m_gridfield = m_gridfield;
	}

	public int getPageSize() {
		return pageSize;
	}

	/**
	 * 
	 * @return true if dialog should auto close after successful execution of process
	 */
	public boolean isCloseAfterExecutionOfProcess() {
		return m_closeAfterExecutionOfProcess;
	}

	/**
	 * Set whether dialog should auto close after successful execution of process
	 * @param closeAfterExecutionOfProcess
	 */
	public void setCloseAfterExecutionOfProcess(boolean closeAfterExecutionOfProcess) {
		this.m_closeAfterExecutionOfProcess = closeAfterExecutionOfProcess;
	}
}	//	Info
