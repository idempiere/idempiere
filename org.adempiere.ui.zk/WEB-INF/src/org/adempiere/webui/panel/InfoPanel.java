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
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;
import java.util.Set;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.IInfoColumn;
import org.adempiere.model.MInfoProcess;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.apps.WProcessCtl;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.ProcessInfoDialog;
import org.adempiere.webui.component.WListItemRenderer;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.IDesktop;
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
import org.compiere.minigrid.UUIDColumn;
import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.model.GridField;
import org.compiere.model.InfoColumnVO;
import org.compiere.model.InfoRelatedVO;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MRefTable;
import org.compiere.model.MRole;
import org.compiere.model.MStatusLine;
import org.compiere.model.MStyle;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
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
 * Abstract base class for info panel and info window.<br/>
 * Info window that works in two mode. <br/>
 * Lookup mode: Popup dialog for a field. Search and return selection to lookup field. <br/>
 * Viewing mode: Independent popup or embedded window. Search and view search results. Optional support for execution of process.
 *
 * @author Sendy Yagambrum
 * @author Elaine
 * @contributor red1 IDEMPIERE-1711 with final review by HengSin 
 */
public abstract class InfoPanel extends Window implements EventListener<Event>, WTableModelListener, Sortable<Object>, IHelpContext
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 8253708190979803268L;

	protected static final String ON_USER_QUERY_ATTR = "ON_USER_QUERY";
	protected static final String INFO_QUERY_TIME_OUT_ERROR = "InfoQueryTimeOutError";
	protected static final String COLUMN_VISIBLE_ORIGINAL = "column.visible.original";
	protected static final String ROW_CTX_VARIABLE_PREFIX = "_IWInfo_";
	protected static final String ROW_ID_CTX_VARIABLE_NAME = "_IWInfoIDs_Selected";
	
	private final static int DEFAULT_PAGE_SIZE = 100;
	private final static int DEFAULT_PAGE_PRELOAD = 4;
	protected List<Button> btProcessList = new ArrayList<Button>();
	/** Column:WEditor */
	protected Map<String, WEditor> editorMap = new HashMap<String, WEditor>();
	protected final static String PROCESS_ID_KEY = "processId";
	protected final static String ON_RUN_PROCESS = "onRunProcess";
	protected final static String ON_SELECT_ALL_RECORDS = "onSelectAllRecords";
	// attribute key of info process
	protected final static String ATT_INFO_PROCESS_KEY = "INFO_PROCESS";
	protected int pageSize;
	/** KeyNamePair/ValueNamePair:[Column:Value] */
	public LinkedHashMap<NamePair,LinkedHashMap<String, Object>> m_values = null;
	protected InfoRelatedVO[] relatedInfoList;
	// for test disable load all record when num of record < 1000
	protected boolean isIgnoreCacheAll = true;
	// Num of page preload, default is 2 page before current and 2 page after current 
	protected int numPagePreLoad = MSysConfig.getIntValue(MSysConfig.ZK_INFO_NUM_PAGE_PRELOAD, DEFAULT_PAGE_PRELOAD);
	// max end index is integer.max_value - 1, not integer.max_value.
	protected int extra_max_row = 1;
	/**
	 * MInfoColumn with isKey = true. In case no column has
	 * isKey = true, keyColumnOfView will be null and we use {@link #p_keyColumn}
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
	 * Value of Key Column:Values of Row.<br/>
	 * Store selected rows.<br/>
	 * If there's no key column of view, use value of {@link #p_keyColumn}.<br/>
	 * Zk6.x listview deosn't send event when user click header checkbox to select all rows, 
	 * so we can't manage selectedRecord all the time. <br/> 
	 * Each time change page, we will update this list with current selected records of current page <br/> 
	 * by calling function {@link #updateListSelected()}. 
	 * When move to zk7, enough to just handle onclick only. <br/>
	 * Because of the issue above, don't use recordSelectedData directly, call
	 * {@link #getSelectedRowInfo()} instead.
	 */
	protected Map<Object, List<Object>> recordSelectedData = new HashMap<Object, List<Object>>();
	
	/**
	 * When re-query but don't want to clear selected record (example after run process), 
	 * set this flag to true to run sync selected record. See also
	 * {@link #syncSelectedAfterRequery()}
	*/
	protected boolean isRequeryByRunSuccessProcess = false;
	
	/**
	 * 
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param value
	 * @param multiSelection
	 * @param whereClause
	 * @return {@link InfoPanel}
	 */
    public static InfoPanel create (int WindowNo,
            String tableName, String keyColumn, String value,
            boolean multiSelection, String whereClause)
    {
        return InfoManager.create(WindowNo, tableName, keyColumn, value, multiSelection, whereClause, true);
    }

	/**
	 * Show panel based on tablename (non modal and not lookup)
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
	/** true for lookup mode */
	protected boolean m_lookup;
	/** AD_InfoWindow_ID */
	protected int m_infoWindowID;
	private boolean m_closeAfterExecutionOfProcess = false;

	private Button btnSelectAll;
	private Button btnDeSelectAll;

	/** true if {@link #p_WindowNo} is not from caller/parent window */
	private boolean registerWindowNo = false;
	
	/**
     * @param WindowNo  WindowNo
     * @param tableName tableName
     * @param keyColumn keyColumn
     * @param multipleSelection
     * @param whereClause  whereClause
	 */
	protected InfoPanel (int WindowNo,
		String tableName, String keyColumn,boolean multipleSelection,
		 String whereClause)
	{
		this(WindowNo, tableName, keyColumn, multipleSelection, whereClause, true);
	}

	/**
	 * 
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param multipleSelection
	 * @param whereClause
	 * @param lookup
	 */
	protected InfoPanel (int WindowNo,
			String tableName, String keyColumn,boolean multipleSelection,
			 String whereClause, boolean lookup){
		this(WindowNo, tableName, keyColumn, multipleSelection, whereClause,
				lookup, 0);
	}
	
	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param multipleSelection
	 * @param whereClause
	 * @param lookup
	 * @param ADInfoWindowID
	 */
	protected InfoPanel (int WindowNo,
			String tableName, String keyColumn,boolean multipleSelection,
			 String whereClause, boolean lookup, int ADInfoWindowID)
	{
		this(WindowNo, tableName, keyColumn, multipleSelection, 
				whereClause, lookup, ADInfoWindowID, null);
	}
	
	/**
     * @param WindowNo  WindowNo
     * @param tableName tableName
     * @param keyColumn keyColumn
     * @param multipleSelection
     * @param whereClause  whereClause
     * @param lookup
     * @param ADInfoWindowID
     * @param queryValue
	 */
	protected InfoPanel (int WindowNo,
		String tableName, String keyColumn,boolean multipleSelection,
		 String whereClause, boolean lookup, int ADInfoWindowID, String queryValue)
	{				
		if (WindowNo <= 0) {
			p_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
			registerWindowNo  = true;
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

        setMultipleSelection(multipleSelection);
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
		
		setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infopanel");
		
		addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
		addEventListener(ON_RUN_PROCESS, this);
		addEventListener(ON_SELECT_ALL_RECORDS, this);
		addEventListener(Events.ON_CLOSE, this);

		setAttribute(IDesktop.WINDOWNO_ATTRIBUTE, p_WindowNo);	// for closing the window with shortcut
	}	//	InfoPanel

	/**
	 * parse query value from calling input element
	 */
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

	/**
	 * Layout window
	 */
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
		btnSelectAll = confirmPanel.createButton("SelectAll");
		confirmPanel.addComponentsLeft(btnSelectAll);
		btnSelectAll.setEnabled(false);
		btnSelectAll.setVisible(p_multipleSelection);
		btnDeSelectAll = confirmPanel.createButton("DeSelectAll");
		confirmPanel.addComponentsLeft(btnDeSelectAll);
		btnDeSelectAll.setEnabled(false);
		btnDeSelectAll.setVisible(p_multipleSelection);
        confirmPanel.addActionListener(Events.ON_CLICK, this);
        ZKUpdateUtil.setHflex(confirmPanel, "1");
        if (ClientInfo.isMobile())
        {
        	if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH) || ClientInfo.maxHeight(ClientInfo.SMALL_HEIGHT))
        	{
        		confirmPanel.useSmallButtonClassForSmallScreen();
        	}
        }

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
        contentPanel.setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infoListbox");
        contentPanel.addEventListener("onAfterRender", this);
        contentPanel.setSclass("z-word-nowrap");
        
        this.setSclass("info-panel");
	}  //  init
	
	protected ConfirmPanel confirmPanel;
	/** Lookup mode: parent window number. Non lookup mode: register desktop tab number for this window */
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
	private ArrayList<Object>	m_results = new ArrayList<Object>(3);

	/** Model of {@link #contentPanel} */
    private ListModelTable model;
	/** Layout of {@link #contentPanel}     */
	protected ColumnInfo[]     p_layout;
	/** Main SQL Statement      */
	protected String              m_sqlMain;
	/** Count SQL Statement		*/
	protected String              m_sqlCount;
	/** Order By Clause         */
	protected String              m_sqlOrder;
	private String              m_sqlUserOrder;
	
	protected int              	  indexOrderColumn = -1;
	/** sql column name of infocolumn (can be alias) */
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
	// in case double click to item. this store clicked item (maybe it's un-select item)
	private int m_lastSelectedIndex = -1;
	protected GridField m_gridfield;

	/**
	 * If false, use saved where clause.
	 * IDEMPIERE-1979
	 */
	protected boolean isQueryByUser = false;
	
	/** true for auto complete call from lookup field */
	protected boolean isAutoComplete = false;
	
	protected int queryTimeout = 0;
	protected boolean useQueryTimeoutFromSysConfig = true;
	
	/** column name for auto complete call */
	protected String autoCompleteSearchColumn = null;
	
	protected String queryValue;
	
	/**
	 * saved where clause of previous query
	 */
	protected String prevWhereClause = null;
	/**
	 * saved value of previous query parameters
	 */
	protected List<Object> prevParameterValues = null;
	protected List<String> prevQueryOperators = null;
	protected List<WEditor> prevRefParmeterEditor = null;
	private static final String[] lISTENER_EVENTS = {};

	/**
	* Info processes of this infoWindow
	*/
	protected MInfoProcess [] infoProcessList;
	/**
	* flag detect exists info process
	*/
	protected boolean haveProcess = false;
	/**
	* Info process with style = button
	*/
	protected List<MInfoProcess> infoProcessBtList;
	/**
	* Info process with style = drop down list
	*/
	protected List<MInfoProcess> infoProcessDropList;
	/**
	* Info process with style = menu
	*/
	protected List<MInfoProcess> infoProcessMenuList;
	/**
	* saved selected id and viewID
	*/
	protected Collection<NamePair> m_viewIDMap = new ArrayList <NamePair>();
	
	/**
	 * AD_InfoColumn_ID:Index Column Sequence <br/>
	 * Store index of infoColumn that have been added.Index increase from 0.
	 */
	protected Map <Integer, Integer> columnDataIndex = new HashMap <Integer, Integer> ();
	/**
	 * After loading of first record, set this to false.<br/> 
	 * When need to update {@link #columnDataIndex}, set this to true. 
	 */
	protected boolean isMustUpdateColumnIndex = true;
	/**
	 * Number of index column that have been added to {@link #columnDataIndex}.
	 */
	protected int indexColumnCount = 0;
	/**
	 * Before the start of reading of a row, reset this list. <br/> 
	 * After reading of each column, store id of infoColumn to this list to prevent duplicate.
	 */
	protected List <Integer> lsReadedColumn = new ArrayList <Integer> ();
	
	/**
	 * IDEMPIERE-1334
	 * button and combobox when layout process button as dropdown list
	 */
	protected Button btCbbProcess;
	protected Combobox cbbProcess;
	protected Button btMenuProcess;

	/**
	 * SysConfig USE_ESC_FOR_TAB_CLOSING
	 */
	private boolean isUseEscForTabClosing = MSysConfig.getBooleanValue(MSysConfig.USE_ESC_FOR_TAB_CLOSING, false, Env.getAD_Client_ID(Env.getCtx()));
	
	/**
	 * Contains the keys of the selected rows in the order of selection
	 */
	protected ArrayList<Object> m_rowSelectionOrder = new ArrayList<Object>();
	/**
	 * Number of selected rows
	 */
	protected int m_selectedCount = 0;
	/** 
	 * Parameter Name:Value
	 * Values that will be put into the context on re-query 
	 */
	protected HashMap<String, Object> paraCtxValues = new HashMap<String, Object>();
	
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
	 *	Set status text for DB
	 *  @param text text 
	 */
	public void setStatusDB (String text)
	{
		statusBar.setStatusDB(text);
	}	//	setStatusDB

	/**
	 *	Set status text for selected rows
	 */
	public void setStatusSelected ()
	{
		int selectedCount = p_multipleSelection ? recordSelectedData.size() : 0;
		
		for (int rowIndex = 0; rowIndex < contentPanel.getModel().getRowCount(); rowIndex++){			
			Object keyCandidate = getColumnValue(rowIndex);
			
			@SuppressWarnings("unchecked")
			List<Object> candidateRecord = (List<Object>)contentPanel.getModel().get(rowIndex);
						
			if (contentPanel.getModel().isSelected(candidateRecord)){
				if(!p_multipleSelection) {
					selectedCount++;
					break;
				}
				else if (!recordSelectedData.containsKey(keyCandidate)){
					selectedCount++;
				}
			}else if (p_multipleSelection){
				if (recordSelectedData.containsKey(keyCandidate)){// unselected record
					selectedCount--;
				}
			}
		}	
		m_selectedCount = selectedCount;
		String msg = Msg.getMsg(Env.getCtx(), "IWStatusSelected", new Object [] {String.valueOf(selectedCount)});
		statusBar.setSelectedRowNumber(msg);
		btnSelectAll.setEnabled(m_count > 0 && selectedCount != m_count);
		btnDeSelectAll.setEnabled(selectedCount > 0);
	}	//	setStatusSelected
	
	/**
	 * set up list box and construct sql clause
	 * @param layout
	 * @param from
	 * @param where
	 * @param orderBy
	 */
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
		if (orderBy != null && orderBy.trim().length() > 0)
			m_sqlOrder = " ORDER BY " + orderBy;
	}   //  prepareTable

	/**
	 * @return true if number of page will be determined through record count.
	 */
	protected boolean isLoadPageNumber(){
		return infoWindow == null || infoWindow.isLoadPageNum();
	}
	
	/**
	 * Execute Query
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

	/**
	 * Read row from result set
	 * @param rs
	 * @throws SQLException
	 */
	private void readData(ResultSet rs) throws SQLException {
		int colOffset = 1;  //  columns start with 1
		List<Object> data = new ArrayList<Object>();
	
		for (int col = 0; col < p_layout.length; col++)
		{
			Object value = null;
			Class<?> c = p_layout[col].getColClass();
			int colIndex = col + colOffset;
			if (c == IDColumn.class)
		        value = new IDColumn(rs.getInt(colIndex));
			else if (c == UUIDColumn.class)
		        value = new UUIDColumn(rs.getString(colIndex));
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
	 * Append viewID column in infoProcessList to data. <br/> 
	 * When override {@link #readData(ResultSet)}, should include call to this method. 
	 * IDEMPIERE-1970
	 * @param rs result set to read data
	 * @param data data line to append
	 * @param listReadedColumn list of columns appended
	 * @throws SQLException
	 */
	protected void appendDataForViewID(ResultSet rs, List<Object> data, List<Integer> listReadedColumn) throws SQLException {
		appendInfoColumnData(rs, data, infoProcessList, listReadedColumn);
	}
	
	/**
	 * Append id column in related info list to data. <br/>
	 * When override {@link #readData(ResultSet)}, should include call to this method.
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
	 * Append {@link #keyColumnOfView} to data. <br/>
	 * When override {@link #readData(ResultSet)}, should include call to this method. 
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
	 * Append value of infoColumn in listModelHaveInfoColumn to data. <br/>
	 * @param rs record set to read data
	 * @param data data line to append
	 * @param listModelHasInfoColumn
	 * @param listReadedColumn list of columns appended
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

	/**
	 * render list box items
	 */
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
        			paging.setVisible(true);
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
        setFocusToContentPanel();
        addDoubleClickListener();
        
        if (paging != null && paging.getParent() == null)
        	insertPagingComponent();

        Mask mask = getMaskObj();
        if (mask == null || mask.getParent() == null)
        	this.invalidate();
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

	/**
	 * update info window status text
	 * @param no
	 */
	protected void updateStatusBar (int no){
    	setStatusLine((no == Integer.MAX_VALUE?"?":Integer.toString(no)) + " " + Msg.getMsg(Env.getCtx(), "SearchRows_EnterQuery"), false);
        setStatusDB(no == Integer.MAX_VALUE?"?":Integer.toString(no));
    }
    
	/**
	 * Read rows from start to end
	 * @param start
	 * @param end
	 * @return rows read
	 */
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
     * After query from database, validate paging (when paging is dynamic, ie isLoadPageNumber()==false) <br/>
     * If end page include in cache, calculate total record read. <br/>
     * If current page is out of cache, process query count to detect end page.
     */
    protected void validateEndPage (){
    	if (paging == null || isLoadPageNumber())
    		return;
    	
    	if (!isHasNextPage){
    		int extraPage = ((line.size() % pageSize > 0)?1:0);
    		int pageInCache = line.size() / pageSize + extraPage;
    		
    		if (pageInCache == 0 || pageInCache <= numPagePreLoad){
    			// selected page is out of cache
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
     * fromIndex and toIndex is calculate base on result from {@link #testCount()}. <br/>
     * For example after testCount, the calculated number of page is 6 page.<br/>
     * When user navigate to page 4. something change in database and we just get 5 page with current query parameter. <br/>
     * So when user navigate to page 6. user will face with index issue (out of index or start index &gt; end index). <br/>
     * This function include fix for it.
     * @param fromIndex
     * @param toIndex
     * @param line
     * @return sub list from line
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
     * When calculating value at bound of integer datatype, sometime value will overflow.
     * This function calculate with higher data type to avoid the overflow issue.
     * @param value
     * @return int
     */
    protected int getOverIntValue (long value){
    	return getOverIntValue (value, 0);
    }
    
    /**
     * see {@link #getOverIntValue(long)}. when value >= max_value, set it near or equal to max_value.
     * @param value
     * @param extra extra value to minus from max_value
     * @return int
     */
    protected int getOverIntValue (long value, int extra){
    	if (value >= Integer.MAX_VALUE)
    		value = Integer.MAX_VALUE - extra;
    	
    	return (int)value;
    }
    
    /**
     * build sql clause with paging
     * @param start
     * @param end
     * @return sql clause
     */
	protected String buildDataSQL(int start, int end) {
		String dataSql;
		String dynWhere = getSQLWhere();   //  includes first AND
        StringBuilder sql = new StringBuilder (m_sqlMain);
        if (dynWhere.length() > 0) {
			if(sql.toString().trim().endsWith("WHERE")) {
				dynWhere = dynWhere.replaceFirst("AND", " ");
			}
			sql.append(dynWhere);
		}
        
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
	 * column index of grid isn't fix, it can change by display logic of column each time after loading of data
	 * {@link InfoWindow#prepareTable(ColumnInfo[], String, String, String)}, 
	 * so need to validate it by comparing the sql of current sort column
	 */
	protected void validateOrderIndex() {
		if (indexOrderColumn > 0 && (indexOrderColumn + 1 > p_layout.length || !p_layout[indexOrderColumn].getColSQL().trim().equals(sqlOrderColumn))) {
			// try to find out new index of ordered column, in case has other column is hide or display
			for (int testIndex = 0; testIndex < p_layout.length; testIndex++) {
				if (p_layout[testIndex].getColSQL().trim().equals(sqlOrderColumn) || p_layout[testIndex].getDisplayColumn().equals(sqlOrderColumn)) {
					indexOrderColumn = testIndex;
					break;
				}
			}
			
			// index still incorrect and can't find out new index (ordered column become hide column)
			if (indexOrderColumn > 0 && (indexOrderColumn + 1 > p_layout.length
					|| (!p_layout[indexOrderColumn].getColSQL().trim().equals(sqlOrderColumn) && !p_layout[indexOrderColumn].getDisplayColumn().equals(sqlOrderColumn)))) {
				indexOrderColumn = -1;
				sqlOrderColumn = null;
				m_sqlUserOrder = null;
			}
		}
			
	}
	
	/**
	 * build order clause of current sort column, and save it to m_sqlUserOrder
	 * @return order clause
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
	 * Build order clause of given column index. <br/>
	 * If call init list will raise NPE.
	 * @param col
	 * @return order clause
	 */
	protected String getUserOrderClause(int col) {
		ColumnInfo orderColumnInfo = p_layout[col];
		String displayColumn = orderColumnInfo.getDisplayColumn();
		String colsql = !Util.isEmpty(displayColumn) ? displayColumn : p_layout[col].getColSQL().trim();
		
		colsql = getSelectForOrderBy(colsql);
		if(!Util.isEmpty(displayColumn) && (DisplayType.isLookup(orderColumnInfo.getAD_Reference_ID()) || DisplayType.isChosenMultipleSelection(orderColumnInfo.getAD_Reference_ID()))) {
			String from = getFromForOrderBy(orderColumnInfo, displayColumn);
			String where = getWhereForOrderBy(orderColumnInfo);
			
			return String.format(" ORDER BY (SELECT %s FROM %s WHERE %s) %s ", colsql, from, where, isColumnSortAscending? "" : "DESC");
		}
		else {
			return String.format(" ORDER BY %s %s ", colsql, isColumnSortAscending? "" : "DESC");
		}
	}

	/**
	 * Get SQL column clause for ORDER BY
	 * @param colsql
	 * @return sql column clause
	 */
	private String getSelectForOrderBy(String colsql) {
		
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
		return colsql;
	}
	
	/**
	 * Get SQL FROM clause for ORDER BY (table and join)
	 * @param orderColumnInfo
	 * @param displayColumn
	 * @return String FROM clause
	 */
	private String getFromForOrderBy(ColumnInfo orderColumnInfo, String displayColumn) {
		String fromClause = "";
		MTable table = getTable(orderColumnInfo.getAD_Reference_Value_ID(), orderColumnInfo.getColumnName());
		String tableName = table.getTableName();
		if(table != null)
			fromClause += tableName;

		// join translation table
		if(displayColumn.contains(table.getTableName()+"_Trl")) {
			String tableNameTrl = tableName+"_Trl";
			MTable tableTrl = MTable.get(Env.getCtx(), tableNameTrl);
			String sqlSelect = orderColumnInfo.getSelectClause();
			String[] keyCols = tableTrl.getKeyColumns();

			fromClause += " JOIN " + tableNameTrl + " ON (";
			for(int i = 0; i < keyCols.length; i++) {
				String keyCol = keyCols[i];
				
				if(i > 0)
					fromClause += " AND ";
				
				fromClause += tableNameTrl + "." + keyCol + " = ";
				
				if("AD_Language".equalsIgnoreCase(keyCol))
					fromClause += " '" + Env.getAD_Language(Env.getCtx()) + "' ";
				else
					fromClause += sqlSelect;
			}
			fromClause += ") ";
		}
		return fromClause;
	}
	
	/**
	 * Get WHERE clause for ORDER BY
	 * @param orderColumnInfo
	 * @return String WHERE clause
	 */
	private String getWhereForOrderBy(ColumnInfo orderColumnInfo) {
		MTable table = getTable(orderColumnInfo.getAD_Reference_Value_ID(), orderColumnInfo.getColumnName());
		String tableName = table.getTableName();
		String keyCol = table.getKeyColumns()[0];
		String sqlSelect = orderColumnInfo.getSelectClause();
		String whereClause = "";
		
		whereClause += tableName + "." + keyCol + " = " + sqlSelect;
		return whereClause;
	}
	
	/**
	 * Add current info panel instance as double click and on select listener of {@link #contentPanel}.
	 */
    private void addDoubleClickListener() {
    	Iterator<EventListener<? extends Event>> i = contentPanel.getEventListeners(Events.ON_DOUBLE_CLICK).iterator();
		while (i.hasNext()) {
			if (i.next() == this)
				return;
		}
		contentPanel.addEventListener(Events.ON_DOUBLE_CLICK, this);
		contentPanel.addEventListener(Events.ON_SELECT, this);
	}

	/**
	 * Get alias of the table, or the table name
	 * @return String alias
	 */
	public String getAlias(String tableName) {
		if(Util.isEmpty(tableName))
			return "";
		String alias = tableName;
		for(TableInfo tableInfo : infoWindow.getTableInfos()) {
			if(tableName.equalsIgnoreCase(tableInfo.getTableName()))
				alias = !Util.isEmpty(tableInfo.getSynonym()) ? tableInfo.getSynonym() : tableName;
		}
		return alias;
	}
    
    /**
     * add paging component for list box
     */
    protected void insertPagingComponent() {
		contentPanel.getParent().insertBefore(paging, contentPanel.getNextSibling());
	}

    /**
     * 
     * @param p_layout
     * @return column headers
     */
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
		String dynWhere = getSQLWhere();   //  includes first AND
		StringBuilder sql = new StringBuilder (m_sqlCount);

		if (dynWhere.length() > 0) {
			if(sql.toString().trim().endsWith("WHERE")) {
				dynWhere = dynWhere.replaceFirst("AND", " ");
			}
			sql.append(dynWhere);
		}

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
            return;
		}

		//	Multi Selection
		if (p_multipleSelection)
		{
			m_results.addAll(getSelectedRowKeys());
		}
		else    //  singleSelection
		{
			Serializable data = getSelectedRowKey();
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
	protected <T extends Serializable> T getSelectedRowKey()
	{
		T key = contentPanel.getSelectedRowKey();

		return key;
	}   //  getSelectedRowKey

	/**
	 *  Get the integer key of currently selected row
	 *  @param tableId
	 *  @return selected key
	 */
	protected Integer getIntSelectedRowKey(int tableId)
	{
		Object key = getSelectedRowKey();
		
		if (key == null)
			return Integer.valueOf(-1);

		if (key instanceof Integer)
			return (Integer) key;

		MTable table = MTable.get(tableId);
		table.getPOByUU((String) key, null);
		return Integer.valueOf(table.get_ID());
	}   //  getIntSelectedRowKey

	/**
     *  Get the keys of selected rows
     *  @return selected IDs or UUIDs
     */
    @SuppressWarnings("unchecked")
	protected <T extends Serializable> List<T> getSelectedRowKeys()
    {
    	List<T> selectedDataList = new ArrayList<>();
		for (Map.Entry<Object, List<Object>> rowInfo : getSelectedRowInfo().entrySet()) {
			if(rowInfo.getValue().get(0) instanceof IDColumn idColumn)
				selectedDataList.add((T)idColumn.getRecord_ID());
			else if(rowInfo.getValue().get(0) instanceof UUIDColumn uuidColumn)
				selectedDataList.add((T)uuidColumn.getRecord_UU());
		}
		return selectedDataList;
    }   //  getSelectedRowKeys

    /**
	 *	Get selected Keys as Collection
	 *  @deprecated use getSaveKeys
	 *  @return selected keys (Integers)
	 */
    @Deprecated
	public Collection<Object> getSelectedKeysCollection()
	{
		m_ok = true;
		saveSelection();
		if (!m_ok || m_results.size() == 0)
			return null;	
		return m_results;
	}

	/**
	 * Add view id column (infoColumnId) to {@link #m_viewIDMap}.
	 * @param infoColumnId view id column
	 */
	public Collection<NamePair> getSaveKeys (int infoColumnId){
		// clear result from previous call
		m_viewIDMap.clear();
		
		if (p_multipleSelection)
        {
			Map <Object, List<Object>> selectedRow = getSelectedRowInfo();
			
            for (Entry<Object, List<Object>> selectedInfo : selectedRow.entrySet())
            {
            	// get key data column
            	Object keyData = selectedInfo.getKey();
                
                if (infoColumnId > 0){
                	// has viewID, get it
                	int dataIndex = columnDataIndex.get(infoColumnId) + p_layout.length;
                	
            		// get row data from model
					Object viewIDValue = selectedInfo.getValue().get(dataIndex);
                	if (keyData instanceof String)
                		m_viewIDMap.add (new ValueNamePair((String) keyData, viewIDValue == null?null:viewIDValue.toString()));
                	else
                		m_viewIDMap.add (new KeyNamePair((Integer) keyData, viewIDValue == null?null:viewIDValue.toString()));
                }else{
                	// no viewID, set viewID value to null
                	if (keyData instanceof String)
                		m_viewIDMap.add (new ValueNamePair((String) keyData, null));
                	else
                		m_viewIDMap.add (new KeyNamePair((Integer) keyData, null));
                }
                
            }
            
            return m_viewIDMap;
        }else{
        	// should never reach here, when have process, p_multipleSelection is always true
        	return null;
        }

	}
	
	/**
	 * need override at infoWindow to check isDisplay
	 * @return true if need to append {@link #keyColumnOfView} to {@link #columnDataIndex}
	 */
	protected boolean isNeedAppendKeyViewData (){
		return false;
	}
		
	/**
	 * Check type of object is IDColumn
	 * @param keyData
	 * @param isCheckNull when true, raise exception when data is null
	 * @return true if keyData is instanceof IDColumn
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
	 * call {@link #isIDColumn(Object, boolean)} without null check
	 * @param keyData
	 * @return true if keyData is instanceof IDColumn
	 */
	protected boolean isIDColumn(Object keyData){
		return isIDColumn(keyData, false);
	}
	
	/**
	 * Get all selected record of current page and update to {@link #recordSelectedData}.<br/>
	 * Remove unselected record and add new selected record.<br/>
	 * We maintain value of key, and extra value append by {@link #appendInfoColumnData(ResultSet, List, IInfoColumn[], List)} 
	 */
	protected void updateListSelected (){
		for (int rowIndex = 0; rowIndex < contentPanel.getModel().getRowCount(); rowIndex++){			
			Object keyCandidate = getColumnValue(rowIndex);
			
			@SuppressWarnings("unchecked")
			List<Object> candidateRecord = (List<Object>)contentPanel.getModel().get(rowIndex);
			
			int ri = rowIndex;
			if (contentPanel.getModel().isSelected(candidateRecord) || Arrays.stream(contentPanel.getSelectedIndices()).anyMatch(si -> si==ri)){
				recordSelectedData.put(keyCandidate, candidateRecord);// add or update selected record info				
			}else{
				if (recordSelectedData.containsKey(keyCandidate)){// unselected record
					List<Object> recordSelected = recordSelectedData.get(keyCandidate);
					IDColumn idcSel = null;
					UUIDColumn uucSel = null;
					if (recordSelected.get(0) instanceof IDColumn) {
						idcSel = (IDColumn) recordSelected.get(0);
					} else if (recordSelected.get(0) instanceof UUIDColumn) {
						uucSel = (UUIDColumn) recordSelected.get(0);
					}
					IDColumn idcCan = null;
					UUIDColumn uucCan = null;
					if (candidateRecord.get(0) instanceof IDColumn) {
						idcCan = (IDColumn) candidateRecord.get(0);
					} else if (candidateRecord.get(0) instanceof UUIDColumn) {
						uucCan = (UUIDColumn) candidateRecord.get(0);
					}
					if (   (idcSel != null && idcCan != null && idcSel.getRecord_ID().equals(idcCan.getRecord_ID()))
						|| (uucSel != null && uucCan != null && uucSel.getRecord_UU().equals(uucCan.getRecord_UU())) ) {
						recordSelected.set(0, candidateRecord.get(0)); // set same ID/UUID Column for comparison
					}
					if (recordSelected.equals(candidateRecord)) {
						recordSelectedData.remove(keyCandidate);
					}
				}
			}
			
		}		    
	}
	
	/**
	 * get column index of keyView
	 * @return index of key column
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
			Object keyViewValue = getColumnValue(rowIndex);
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
	
	/** 
	 * Hook to intercept 'restore selection' actions 
	 * 
	 * @param keyViewValue row view key
	 * @param rowIndex row index
	 * @param row row
	 * @return false to skip restore selection
	 */
	public boolean onRestoreSelectedItemIndexInPage(Object keyViewValue, int rowIndex, Object row)
	{
		return true;
	}
		
	protected AdempiereException getKeyNullException (){
		String errorMessage = String.format("has null value at column %1$s use as key of view in info window %2$s", 
				keyColumnOfView == null ? p_keyColumn : keyColumnOfView, infoWindow.getName());
		return new AdempiereException(errorMessage);
	}
	/**
	 * Get keyView value at rowIndex.<br/>
	 * Exception is raise if value is null.
	 * @param rowIndex
	 * @return value of key column
	 */
	protected Object getColumnValue (int rowIndex){
		
		int keyIndex = getIndexKeyColumnOfView();
		Object keyValue = null;
    	// get row data from model
		Object keyColumValue = contentPanel.getModel().getDataAt(rowIndex, keyIndex);
		// throw exception when value is null
		if (keyColumValue == null){
			AdempiereException ex = getKeyNullException();
			log.severe(ex.getMessage());
			throw ex;
		}
		
		// IDColumn is recreate after change page, because use value of IDColumn
		if (keyColumValue != null) {
			if (keyColumValue instanceof IDColumn) {
				keyColumValue = ((IDColumn)keyColumValue).getRecord_ID();
			} else if (keyColumValue instanceof UUIDColumn) {
				keyColumValue = ((UUIDColumn)keyColumValue).getRecord_UU();
			}
		}
		
		if (keyColumValue instanceof Integer) {
			keyValue = (Integer)keyColumValue;
		} else if (keyColumValue instanceof String) {
			keyValue = (String)keyColumValue;
		} else {
			String msg = "keyView column must be integer or string";
			AdempiereException ex = new AdempiereException (msg);
			log.severe(msg);
			throw ex;
		}
		
		return keyValue;
	}
	
	/**
	 * Maintain selected record after re-query (for example after success run of a process). <br/>
	 * We must sync selected row, because some selected row maybe missing after re-query (change by process and no longer match with current query).
	 * TODO:rewrite, current code just reset isRequeryByRunSuccessProcess flag and didn't do anything else.
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
	 * Update {@link #recordSelectedData}
	 * @return {@link #recordSelectedData} after update 
	 */
	public Map<Object, List<Object>> getSelectedRowInfo (){
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
		return m_results.toArray(new Object[0]);
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

	/**
	 * @return list of events
	 */
	public String[] getEvents()
    {
        return InfoPanel.lISTENER_EVENTS;
    }

	/**
	 * enable all control button or disable all depends on whether there are selected records. 
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

	/**
	 *  Get dynamic WHERE part of SQL.<br/>
	 *  When override this method, please take isQueryByUser and prevWhereClause into consideration. 
	 *  @return WHERE clause
	 */
	protected abstract String getSQLWhere();

	/**
	 *  Set Parameters for Query. <br/>
	 *  When override this method, please take isQueryByUser and prevWhereClause into consideration.
	 *  @param pstmt statement
	 *  @param forCount for counting records
	 *  @throws SQLException
	 */
	protected abstract void setParameters (PreparedStatement pstmt, boolean forCount)
		throws SQLException;
	
    /**
     * Show history dialog
     */
	protected void showHistory()					{}
	
	/**
	 *  Has History (default false).
	 *	Override this and {@link #showHistory()} method to add history dialog support.
	 *  @return true if it has history (default false)
	 */
	protected boolean hasHistory()				{return false;}
	
	/**
	 * @return true if support running of process.
	 */
	protected boolean hasProcess()				{return false;}
	
	/**
	 *  Show Customize dialog
	 */	
	protected void customize()					{}
	
	/**
	 *  Has Customize dialog (default false).
	 *	Override this and {@link #customize()} method to add customize dialog support.
	 *  @return true if it has customize (default false)
	 */
	protected boolean hasCustomize()				{return false;}
	
	/**
	 *  Has Zoom support (default false)
	 *  @return true if it has zoom support (default false)
	 */
	protected boolean hasZoom()					{return false;}
	
	/**
	 * Support create new record (default false)
	 * @return true if support create new record
	 */
	protected boolean hasNew()					{return false;}
	
	/**
	 *  Save Selection Details. <br/>
	 *  This method is call when user close an info window. <br/>
	 *  By default, infoWindow will set value of all column of current selected record to environment context with {@link Env#TAB_INFO}. <br/>
	 *  Sub class can override this method to do more. 
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

	@Override
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
        	if(!isLookup()) {
	        	updateRowSelectionOrder();
	        	updateContext(false);
        	}
        	
        }else if (event.getTarget() == contentPanel && event.getName().equals("onAfterRender")){           	
        	//IDEMPIERE-1334 at this event selected item from listBox and model is sync
        	enableButtons();
        	setFocusToContentPanel();
        }
        else if (event.getTarget() == contentPanel && event.getName().equals(Events.ON_DOUBLE_CLICK))
        {
        	if (event.getClass().equals(MouseEvent.class)){
        		return;
        	}
        	if (contentPanel.isMultiple() && m_lastSelectedIndex >= 0 && isLookup()) {
				
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
        	
        	if (isLookup() || hasZoom()) 
        	{
	        	onDoubleClick();
	        	contentPanel.repaint();
	        	m_lastSelectedIndex = -1;
        	}
        }
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_REFRESH)))
        {
    		recordSelectedData.clear();
    		setStatusSelected();
        	onUserQuery();
        }
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_CANCEL)))
        {
        	onCancel();
        }
        else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_RESET))) {
    		recordSelectedData.clear();
        	resetParameters ();
        }
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
        else if (event.getTarget().equals(btnSelectAll))
        {
    		Clients.showBusy(Msg.getMsg(Env.getCtx(), "Processing"));
    		Events.echoEvent(ON_SELECT_ALL_RECORDS, this, null);
        }
        else if (ON_SELECT_ALL_RECORDS.equals(event.getName()))
        {
        	selectAllRecords();
        	if(!isLookup()) {
		    	updateRowSelectionOrder();
		    	updateContext(false);
        	}
        }
        else if (event.getTarget().equals(btnDeSelectAll))
        {
        	deSelectAllRecords();
        	if(!isLookup()) {
	        	updateRowSelectionOrder();
	        	updateContext(false);
        	}
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
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Info, infoWindow.getAD_InfoWindow_ID(), this);
			else
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0);
    	}
        else if (event.getName().equals(Events.ON_CTRL_KEY))
        {
    		KeyEvent keyEvent = (KeyEvent) event;
    		if (LayoutUtils.isReallyVisible(this))
    			this.onCtrlKeyEvent(keyEvent);
    	}else if (event.getName().equals(Events.ON_OK)){// on ok when focus at non parameter component. example grid result
        	if (m_lookup && contentPanel.getSelectedIndex() >= 0){
    			// do nothing when parameter not change and at window mode, or at dialog mode but select no record    			
    			onOk();
    		}
        	else if (m_infoWindowID == 0 && event.getTarget() instanceof InfoGeneralPanel) {
        		onUserQuery();
        	}
    	}else if (event.getName().equals(Events.ON_CANCEL) || (event.getTarget().equals(this) && event.getName().equals(Events.ON_CLOSE))){
    		onCancel();
    	}
    	else if(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT.equals(event.getName())) {
        	IDesktop desktop = SessionManager.getAppDesktop();
        	if (p_WindowNo > 0 && desktop.isCloseTabWithShortcut())
        		desktop.closeWindow(p_WindowNo);
        	else
        		desktop.setCloseTabWithShortcut(true);
        }
        //when user push enter keyboard at input parameter field
        else
        {
        	// onUserQuery(); // captured now on control key
        }
    }  //  onEvent

	/**
	 * handle cancel event
	 */
	protected void onCancel() {
		// do not allow to close tab for Events.ON_CTRL_KEY event
		if(isUseEscForTabClosing)
			SessionManager.getAppDesktop().setCloseTabWithShortcut(false);

		m_cancel = true;
		dispose(false);
	}

    public static final int VK_ENTER          = '\r';
    public static final int VK_ESCAPE         = 0x1B;
    
    /**
     * Handle ON_CTRL_KEY event
     * @param keyEvent
     */
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
		} else if ((keyEvent.isAltKey() && keyEvent.getKeyCode() == 0x58)	// Alt-X
				|| (keyEvent.getKeyCode() == 0x1B && isUseEscForTabClosing)) {	// ESC
			keyEvent.stopPropagation();
			Events.echoEvent(new Event(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this));
		}
	}

    /**
     * Call query when user click to query button enter in parameter field
     */
    public void onUserQuery (){
		recordSelectedData.clear();

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
     * @return true if parameters pass validation
     */
    public boolean validateParameters(){
    	return true;
    }

	/**
	 * Call after loading of parameter panel to set initial value. Can call to reset parameters.
	 */
	protected void initParameters() {

	}
	
	/**
	 * Update related info when selection in {@link #contentPanel} change.
	 */
	protected void updateSubcontent (){ updateSubcontent(-1);};
	
	/**
	 * Update related info for a specific row. If targetRow &lt; 0, update using selected row.
	 * @param targetRow
	 */
	protected void updateSubcontent (int targetRow){};


	/**
	 * Reset parameter to default value or to empty value.
	 */
	protected void resetParameters() {
	}
    
	/**
	 * Before running of process
	 * @param processId
	 */
    protected void preRunProcess (Integer processId){
    	// disable all control button when run process
    	enableButtons(false);
    	// call run process in next request to disable all button control
    	Events.echoEvent(ON_RUN_PROCESS, this, processId);
    }
    
    /**
     * Run a process.<br/>
     * Before start process, save id of record selected. <br/>
     * After run of process, show process message report result. 
     * @param processIdObj
     */
    protected void runProcess (Object processIdObj){
    	final Integer processId = (Integer)processIdObj;
    	final MProcess m_process = MProcess.get(Env.getCtx(), processId);
    	final ProcessInfo m_pi = new ProcessInfo(m_process.getName(), processId);
		m_pi.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
		m_pi.setAD_Client_ID(Env.getAD_Client_ID(Env.getCtx()));

		MPInstance instance = new MPInstance(Env.getCtx(), processId, 0, 0, null);
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
	            DB.createT_SelectionNewNP(pInstanceID, getSaveKeys(getInfoColumnIDFromProcess(processId)), null);

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
		
		//let process end with message and re-query
		WProcessCtl.process(p_WindowNo, m_pi, (Trx)null, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				ProcessModalDialog processModalDialog = (ProcessModalDialog)event.getTarget();
				if (DialogEvents.ON_BEFORE_RUN_PROCESS.equals(event.getName())){
					updateListSelected();
					// store in T_Selection table selected rows for Execute Process that retrieves from T_Selection in code.
					DB.createT_SelectionNewNP(pInstanceID, getSaveKeys(getInfoColumnIDFromProcess(processModalDialog.getAD_Process_ID())),
						null);	
					saveResultSelection(getInfoColumnIDFromProcess(processModalDialog.getAD_Process_ID()));
					createT_Selection_InfoWindow(pInstanceID);
					recordSelectedData.clear();
				}else if (ProcessModalDialog.ON_WINDOW_CLOSE.equals(event.getName())){ 
					if (getDesktop() == null) 
						return;
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
			}
		});   		
    }
   
    
    /**
	 * Save selected rows to {@link #m_values}
	 * @param infoColumnId AD_InfoProcess.AD_InfoColumn_ID. Use as key column if > 0
	 */
	protected void saveResultSelection(int infoColumnId) {
		int m_keyColumnIndex = contentPanel.getKeyColumnIndex();
		if (m_keyColumnIndex == -1) {
			return;
		}

		m_values = new LinkedHashMap<NamePair,LinkedHashMap<String,Object>>();
		
		if (p_multipleSelection) {
				
			Map <Object, List<Object>> selectedRow = getSelectedRowInfo();
			
			// for selected rows
            for (Entry<Object, List<Object>> selectedInfo : selectedRow.entrySet())
            {
            	// get key and viewID
            	Object keyData = selectedInfo.getKey();
                NamePair kp = null;
                
                if (infoColumnId > 0){
                	int dataIndex = columnDataIndex.get(infoColumnId) + p_layout.length;
                	Object viewIDValue = selectedInfo.getValue().get(dataIndex);
                	if (keyData instanceof String)
                		kp = new ValueNamePair((String) keyData, viewIDValue == null ? null : viewIDValue.toString());
                	else
                		kp = new KeyNamePair((Integer) keyData, viewIDValue == null ? null : viewIDValue.toString());
                }else{
                	if (keyData instanceof String)
                		kp = new ValueNamePair((String) keyData, null);
                	else
                		kp = new KeyNamePair((Integer) keyData, null);
                }
                
                // get Data
				LinkedHashMap<String, Object> values = new LinkedHashMap<String, Object>();
				for(int col  = 0 ; col < p_layout.length; col ++)
				{
					// layout has same columns as selectedInfo
						values.put(p_layout[col].getColumnName(), selectedInfo.getValue().get(col));
				}
				if(values.size() > 0)
					m_values.put(kp, values);
            }
		}
	} // saveResultSelection
	
	/**
	 * Insert selected rows to T_Selection_InfoWindow
	 * @param AD_PInstance_ID
	 */
	public void createT_Selection_InfoWindow(int AD_PInstance_ID)
	{
		MTable table = MTable.get(infoWindow.getAD_Table_ID());
		StringBuilder insert = new StringBuilder();
		insert.append("INSERT INTO T_Selection_InfoWindow (AD_PINSTANCE_ID, ");
		if (table != null && table.isUUIDKeyTable())
			insert.append("T_SELECTION_UU");
		else
			insert.append("T_SELECTION_ID");
		insert.append(", COLUMNNAME , VALUE_STRING, VALUE_NUMBER , VALUE_DATE ) VALUES(?,?,?,?,?,?) ");
		for (Entry<NamePair,LinkedHashMap<String, Object>> records : m_values.entrySet()) {
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
					else if(key instanceof ValueNamePair)
					{
						ValueNamePair vnp = (ValueNamePair)key;
						parameters.add(vnp.getValue());
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
					else if (data instanceof UUIDColumn)
					{
						UUIDColumn id = (UUIDColumn) data;
						parameters.add(id.getRecord_UU());
						parameters.add(null);
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
					else if(data instanceof ValueNamePair)
					{
						ValueNamePair vnp = (ValueNamePair)data;
						parameters.add(vnp.getValue());
						parameters.add(null);
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
     * Get InfoColumnID of infoProcess
     * @param processId
     * @return AD_InfoColumn_ID, -1 if processId not in {@link #infoProcessList}
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
		Clients.showBusy(this, Msg.getMsg(Env.getCtx(), "Processing"));
	}

	private void hideBusyDialog() {		
		Clients.clearBusy(this);
	}

	/**
	 * Set sort direction indicator
	 */
	protected void correctHeaderOrderIndicator() {
		Listhead listHead = contentPanel.getListHead();
		if (listHead != null) {
			List<?> headers = listHead.getChildren();
			for(Object obj : headers)
			{
				Listheader header = (Listheader) obj;
				if (header.getColumnIndex() == indexOrderColumn)
	              header.setSortDirection(isColumnSortAscending?"ascending":"descending");
	            else
	              header.setSortDirection("natural");
			}
		}
	}
	
	/**
	 * handle echo from query event
	 * @param event null to indicate reset instead of echo from query event
	 */
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
    	if(!isLookup()) {
			updateRowSelectionOrder();
			updateContext(true);
    	}
    }

    /**
     * Evaluate display logic of processes.
     * Implemented by sub class.
     */
    protected void bindInfoProcess (){}
    
    /**
     * handle ok event
     */
    protected void onOk()
    {
		if (!contentPanel.getChildren().isEmpty() && getSelectedRowInfo().size() > 0)
		{
		    dispose(true);
		}
	}

    /**
     * handle double click on row event
     */
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

    @Override
    public void tableChanged(WTableModelEvent event)
    {
    	enableButtons();
    }

    /**
     * zoom to record
     */
    public void zoom()
    {    	
    	Object recordId = contentPanel.getSelectedRowKey();
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
    		int AD_Table_ID = infoWindow != null ? infoWindow.getAD_Table_ID() : -1;
    		if (AD_Table_ID <= 0)
    		{
    			if (p_keyColumn.endsWith("_ID") || p_keyColumn.endsWith("_UU"))
    			{
    				AD_Table_ID = MTable.getTable_ID(p_keyColumn.substring(0, p_keyColumn.length() - 3));
    			}
    		}
    		if (AD_Table_ID > 0) {
    			if (recordId instanceof String)
    	    		AEnv.zoomUU(AD_Table_ID, (String) recordId);
    			else
        			AEnv.zoom(AD_Table_ID, (Integer) recordId);
    		}
    	}
    }

	/**
	 * Select all records from all pages
	 */
	private void selectAllRecords() {
		// select all
		try {
			if (paging != null) {
				int currentPage = paging.getActivePage();
				int pgCnt = paging.getPageCount();
				for (int pgNo = 0; pgNo <= pgCnt-1; pgNo++) {
					if (pgNo == currentPage)
						continue; // will be done at the end
					setAndLoadActivePage(pgNo);
				}
				setAndLoadActivePage(currentPage);
			} else {
		        addAllCurrentContentPanelToSelected();
			}
			restoreSelectedInPage();
			setStatusSelected();
			btnSelectAll.setEnabled(false);
			btnDeSelectAll.setEnabled(true);
		} finally {
			Clients.clearBusy();
		}
	}

	/**
	 * Set and load pgNo as active page
	 * @param pgNo
	 */
	private void setAndLoadActivePage(int pgNo) {
		paging.setActivePage(pgNo);
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
        addAllCurrentContentPanelToSelected();
	}

	/**
	 * Add all the records from current content panel to selected records
	 */
	private void addAllCurrentContentPanelToSelected() {
		for (int rowIndex = 0; rowIndex < contentPanel.getModel().getRowCount(); rowIndex++){
			Object keyCandidate = getColumnValue(rowIndex);
			@SuppressWarnings("unchecked")
			List<Object> candidateRecord = (List<Object>)contentPanel.getModel().get(rowIndex);
			if (!recordSelectedData.containsKey(keyCandidate)) {
				recordSelectedData.put(keyCandidate, candidateRecord);
			}
		}
	}

	/**
	 * De-Select all records from all pages
	 */
	private void deSelectAllRecords() {
		// unselect all
		recordSelectedData.clear();
		restoreSelectedInPage();
		setStatusSelected();
		btnSelectAll.setEnabled(true);
		btnDeSelectAll.setEnabled(false);
	}

    /**
     * Handle user click on new record button.
     */
    protected void newRecordAction (){}
    
    /**
     * 
     * @param listener
     */
    public void addValueChangeListener(ValueChangeListener listener)
    {
        if (listener == null)
        {
            return;
        }

        listeners.add(listener);
    }

    /**
     * Fire ValueChangeEvent event.
     * @param event
     */
    public void fireValueChange(ValueChangeEvent event)
    {
        for (ValueChangeListener listener : listeners)
        {
           listener.valueChange(event);
        }
    }
    /**
     *  Dispose and save Selection
     *  @param ok true if OK pressed
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
        {
        	SessionManager.getAppDesktop().closeActiveWindow();
        }
        else
        {
		//detach if attach to page
		if (getDesktop() != null)
		{
			//Workaround for detached HTML input element leak
			if (getChildren().size() > 0) {
					Component[] childs = getChildren().toArray(new Component[0]);
					for(Component c : childs) {
						AEnv.detachInputElement(c);
					}
				}
			Executions.schedule(getDesktop(), e -> this.detach(), new Event("onAsyncDetach"));
		}
        }
    }   //  dispose

    /**
     * Save width of columns
     * @param comp
     */
    private void saveWlistBoxColumnWidth(Component comp){

        if(comp instanceof WListbox){
        	((WListbox)comp).saveColumnWidth();
        }

        List<Component> list = comp.getChildren();
        for(Component child:list){
        	saveWlistBoxColumnWidth(child);
        }
    } 
    
    /**
     * @param cmpr {@link WListItemRenderer.ColumnComparator}
     * @param ascending
     */
	public void sort(Comparator<Object> cmpr, boolean ascending) {
		updateListSelected();
		WListItemRenderer.ColumnComparator lsc = (WListItemRenderer.ColumnComparator) cmpr;
		
		// keep column order
		int col = lsc.getColumnIndex();
		indexOrderColumn = col;
		isColumnSortAscending = ascending;
		String displayColumn = p_layout[col].getDisplayColumn();
		sqlOrderColumn = !Util.isEmpty(displayColumn) ? displayColumn : p_layout[col].getColSQL().trim();
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

	/**
	 * Get table name from AD_Ref_Table of Column Name
	 * @param refValID
	 * @param columnName
	 * @return MTable[] tables
	 */
	private MTable getTable(int refValID, String columnName) {
		if(refValID > 0) {
			return MTable.get(Env.getCtx(), MRefTable.get(Env.getCtx(), refValID).getAD_Table_ID());
		}
		else if (columnName.endsWith("_ID") || columnName.endsWith("_UU")) {
			return MTable.get(Env.getCtx(), columnName.substring(0, columnName.length() - 3));
		}
		else {
			return null;
		}
	}
	
	/**
	 * 
	 * @return true if this is a lookup dialog
	 */
    public boolean isLookup()
    {
    	return m_lookup;
    }

    /**
     * scroll selected row into view (i.e make sure it is visible)
     */
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

	/**
	 * 
	 * @return window no
	 */
	public int getWindowNo() {
		return p_WindowNo;
	}
	
	/**
	 * 
	 * @return row count
	 */
	public int getRowCount() {
		return contentPanel.getRowCount();
	}
	
	/**
	 * 
	 * @return first row key/id
	 */
	public Object getFirstRowKey() {
		return contentPanel.getFirstRowKey();
	}

	/**
	 * 
	 * @param row
	 * @return row key/id
	 */
	public Object getRowKeyAt(int row) {
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
	
	/**
	 * 
	 * @return true if using database paging feature
	 */
	protected boolean isUseDatabasePaging() {
		return m_useDatabasePaging;
	}
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null && !isLookup()) {
			if (infoWindow != null)
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Info, infoWindow.getAD_InfoWindow_ID(), this);
			else
				SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0, this);
		}
		SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
		addEventListener(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this);
	}

	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		try {
			removeEventListener(IDesktop.ON_CLOSE_WINDOW_SHORTCUT_EVENT, this);

			if (SessionManager.getSessionApplication() != null &&
				SessionManager.getSessionApplication().getKeylistener() != null)
				SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
			if (getFirstChild() != null)
				saveWlistBoxColumnWidth(getFirstChild());
			if (registerWindowNo && SessionManager.getAppDesktop() != null)
				SessionManager.getAppDesktop().unregisterWindow(p_WindowNo);
		} catch (Exception e){
			log.log(Level.WARNING, e.getMessage(), e);
		}
	}

	/**
	 * field call this info panel as search editor
	 * null in case info window open in stand-alone window (from menu, fav,...) 
	 * @return {@link GridField}
	 */
	public GridField getGridfield() {
		return m_gridfield;
	}

	/**
	 * 
	 * @param m_gridfield
	 */
	public void setGridfield(GridField m_gridfield) {
		this.m_gridfield = m_gridfield;
	}

	/**
	 * 
	 * @return page size (number of rows per page)
	 */
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

	/**
	 * 
	 * @param multipleSelection
	 */
	public void setMultipleSelection(boolean multipleSelection) {
		p_multipleSelection = multipleSelection;
		if (btnSelectAll != null)
			btnSelectAll.setVisible(multipleSelection);
		if (btnDeSelectAll != null)
			btnDeSelectAll.setVisible(multipleSelection);
	}
	

	
	/**
	 *	Widget support
	 *	Depending on Window/Tab returns widget lines info
	 *  @return info
	 */
	public String getStatusLinesWidget() {
		if(infoWindow == null)
			return null;
		MStatusLine[] wls = MStatusLine.getStatusLinesWidget(0, 0, 0, infoWindow.getAD_InfoWindow_ID());
		if (wls != null && wls.length > 0)
		{
			StringBuilder lines = new StringBuilder();
			for (MStatusLine wl : wls) {
				String line = wl.parseLine(getWindowNo());
				if (line != null) {
					if (wl.getAD_Style_ID() > 0) {
			    		MStyle style = MStyle.get(wl.getAD_Style_ID());
						String css = style.buildStyle(Env.getContext(Env.getCtx(), Env.THEME), new DefaultEvaluatee(), false);				
						if (!Util.isEmpty(css, true)) {
							lines.append("<div>\n")
								.append("<style>\n")
								.append("@scope {\n")
								.append(css)
								.append("\n}\n")
								.append("</style>\n")
								.append(line)
								.append("\n")
								.append("</div>\n");
						} else {
							lines.append(line).append("<br>");
						}
		    		} else {
		    			lines.append(line).append("<br>");
		    		}
				}
			}
			if (lines.length() > 0)
				return lines.toString();
		}
		return null;
	} // getWidgetLines

	/**
	 * Update row selection order
	 */
	protected void updateRowSelectionOrder() {
		// check if any rows are found
		if(contentPanel.getModel().size() <= 0) {
			m_rowSelectionOrder.clear();
			return;
		}
    	// update selection
		if(!p_multipleSelection && m_lastSelectedIndex >= 0) {
			m_rowSelectionOrder.clear();
			@SuppressWarnings("unchecked")
			List<Object> lastSelectedRecord = (List<Object>)contentPanel.getModel().get(m_lastSelectedIndex);
			Object key = lastSelectedRecord.get(0);
			if(key instanceof IDColumn)
				key = ((IDColumn)key).getRecord_ID();
			m_rowSelectionOrder.add(key);
		}
		else {
			// add selected rows
			for(Map.Entry<Object, List<Object>> entry : getSelectedRowInfo().entrySet()) {
				List<Object> candidateRecord = entry.getValue();
				// get row key
				Object key = candidateRecord.get(0);
				if(key instanceof IDColumn)
					key = ((IDColumn)key).getRecord_ID();
				//
				if(!m_rowSelectionOrder.contains(key))
					m_rowSelectionOrder.add(key);
			}
			// remove unselected rows
			for(Iterator<Object> it = m_rowSelectionOrder.iterator(); it.hasNext();) {
				if(!getSelectedRowInfo().containsKey(it.next()))
					it.remove();
			}
		}
	} // updateRowSelectionOrder
	
	/**
	 * Put values from the selected row into the context
	 */
	protected void updateContext(boolean checkQueryCriteria) {
		List<Object> lastSelectedRow = getLastSelectedRow();
		
		if(checkQueryCriteria) {
			// put parameter values into the context
			for(Map.Entry<String, Object> e : paraCtxValues.entrySet()) {
				String columnName = e.getKey();
				Object value = e.getValue();
				setContext(columnName, value);
			}
		}
		
		// put the values of the last selected row into the context
		for(int i = 0; i < p_layout.length; i++) {
			String columnName = p_layout[i].getColumnName();
			Object value = lastSelectedRow != null ? lastSelectedRow.get(i) : null;
			setContext(ROW_CTX_VARIABLE_PREFIX + columnName, value);
		}
		// add selected IDs to the context
		setContext(ROW_ID_CTX_VARIABLE_NAME, getSelectedIDsForCtx());
		
		// update Quick Info widget
		if (infoWindow != null)
			SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Info, infoWindow.getAD_InfoWindow_ID(), this);
		else
			SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0, this);
	} // updateContext
	
	/**
	 * Set context
	 * @param columnName
	 * @param value
	 */
	protected void setContext(String columnName, Object value) {
		if(value instanceof KeyNamePair)
			value = ((KeyNamePair)value).getKey();
		else if(value instanceof IDColumn)
			value = ((IDColumn)value).getRecord_ID();
		
		if (value == null) {
        	Env.setContext(Env.getCtx(), p_WindowNo, columnName, "");
        } else if (value instanceof Boolean) {
        	Env.setContext(Env.getCtx(), p_WindowNo, columnName, (Boolean)value);
        } else if (value instanceof Timestamp) {
        	Env.setContext(Env.getCtx(), p_WindowNo, columnName, (Timestamp)value);
        } else {
        	Env.setContext(Env.getCtx(), p_WindowNo, columnName, value.toString());
        }
	}
	
	/**
	 * Get a comma-separated string of selected IDs
	 * @return String ctx value
	 */
	protected String getSelectedIDsForCtx() {
		String returnVal = null;
		
		for(Object key : m_rowSelectionOrder) {
			String selectedID = Objects.toString(key);
			if(returnVal == null)
				returnVal = selectedID;
			else
				returnVal += "," + selectedID;
		}		
		return returnVal;
	}
	
	/**
	 * Get last selected row
	 * @return List
	 */
	protected List<Object> getLastSelectedRow() {
		int index = m_rowSelectionOrder.size() - 1;
		
		List<Object> lastSelectedRow = m_rowSelectionOrder.size() > 0 ? getSelectedRowInfo().get(m_rowSelectionOrder.get(index)) : null;
		return lastSelectedRow;
	}

	/**
	 * Set focus to {@link #contentPanel}:<br/>
	 * - Single selection: auto select first item and set focus to it.<br/>
	 * - Multiple selection: set focus to first item. 
	 */
	private void setFocusToContentPanel() {
        if(contentPanel.getRowCount() > 0) {
        	if(p_multipleSelection) {

        		((HtmlBasedComponent)contentPanel.getItems().get(0)).focus();
        	}
        	else {
        		if(contentPanel.getSelectedItem() == null) 
        			contentPanel.setSelectedIndex(0);              		

            	((HtmlBasedComponent)contentPanel.getSelectedItem()).focus();
            	contentPanel.getSelectedItem().setSelected(true);

            	Set<Listitem> selectionList = new LinkedHashSet<>();
            	selectionList.add(contentPanel.getSelectedItem());

            	Events.postEvent(new SelectEvent<>(Events.ON_SELECT, contentPanel, selectionList));
        	}

        	setStatusSelected ();
        	m_lastSelectedIndex = 0;
        }
	}
}	//	Info
