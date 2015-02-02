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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.model.MInfoProcess;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.apps.BusyDialog;
import org.adempiere.webui.apps.ProcessModalDialog;
import org.adempiere.webui.apps.WProcessCtl;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.ListModelTable;
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
import org.adempiere.webui.part.ITabOnSelectHandler;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.FDialog;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.event.MouseEvent;
import org.zkoss.zk.ui.event.SelectEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Listhead;
import org.zkoss.zul.Listheader;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Paging;
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
	/**
	 * 
	 */
	private static final long serialVersionUID = 6027970576265023451L;

	private final static int DEFAULT_PAGE_SIZE = 100;
	protected List<Button> btProcessList = new ArrayList<Button>();
	protected Map<String, WEditor> editorMap = new HashMap<String, WEditor>();
	protected final static String PROCESS_ID_KEY = "processId";
	protected final static String ON_RUN_PROCESS = "onRunProcess";
	// attribute key of info process
	protected final static String ATT_INFO_PROCESS_KEY = "INFO_PROCESS";
	protected int pageSize;
	
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
	}	// showPanel

	/** Window Width                */
	static final int        INFO_WIDTH = 800;
	protected boolean m_lookup;

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

	/**************************************************
     *  Detail Constructor
     * @param WindowNo  WindowNo
     * @param tableName tableName
     * @param keyColumn keyColumn
     * @param whereClause   whereClause
	 */
	protected InfoPanel (int WindowNo,
		String tableName, String keyColumn,boolean multipleSelection,
		 String whereClause, boolean lookup)
	{		
		if (WindowNo <= 0) {
			p_WindowNo = SessionManager.getAppDesktop().registerWindow(this);
		} else {
			p_WindowNo = WindowNo;
		}
		if (log.isLoggable(Level.INFO))
			log.info("WinNo=" + WindowNo + " " + whereClause);
		p_tableName = tableName;
		p_keyColumn = keyColumn;
		
        p_multipleSelection = multipleSelection;
        m_lookup = lookup;

		if (whereClause == null || whereClause.indexOf('@') == -1)
			p_whereClause = whereClause == null ? "" : whereClause;
		else
		{
			p_whereClause = Env.parseContext(Env.getCtx(), p_WindowNo, whereClause, false, false);
			if (p_whereClause.length() == 0)
				log.log(Level.SEVERE, "Cannot parse context= " + whereClause);
		}
		
		pageSize = MSysConfig.getIntValue(MSysConfig.ZK_PAGING_SIZE, DEFAULT_PAGE_SIZE);
		
		init();

		this.setAttribute(ITabOnSelectHandler.ATTRIBUTE_KEY, new ITabOnSelectHandler() {
			public void onSelect() {
				scrollToSelectedRow();
			}
		});
		
		setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infopanel");
		
        infoWindow = MInfoWindow.get(p_keyColumn.replace("_ID", ""), null);
		addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
		addEventListener(ON_RUN_PROCESS, this);
				
	}	//	InfoPanel

	private void init()
	{
		if (isLookup())
		{
			setAttribute(Window.MODE_KEY, Window.MODE_HIGHLIGHTED);
			setBorder("normal");
			setClosable(true);
			int height = SessionManager.getAppDesktop().getClientInfo().desktopHeight * 85 / 100;
    		int width = SessionManager.getAppDesktop().getClientInfo().desktopWidth * 80 / 100;
    		setWidth(width + "px");
    		setHeight(height + "px");
    		this.setContentStyle("overflow: auto");
		}
		else
		{
			setAttribute(Window.MODE_KEY, Window.MODE_EMBEDDED);
			setBorder("none");
			setWidth("100%");
			setHeight("100%");
			setStyle("position: absolute");
		}

		confirmPanel = new ConfirmPanel(true, true, true, true, true, true);  // Elaine 2008/12/16 
        confirmPanel.addActionListener(Events.ON_CLICK, this);
        confirmPanel.setHflex("1");

        // Elaine 2008/12/16
		confirmPanel.getButton(ConfirmPanel.A_CUSTOMIZE).setVisible(hasCustomize());
		confirmPanel.getButton(ConfirmPanel.A_HISTORY).setVisible(hasHistory());
		confirmPanel.getButton(ConfirmPanel.A_ZOOM).setVisible(hasZoom());
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
	protected String              m_sqlUserOrder;
	/**ValueChange listeners       */
    private ArrayList<ValueChangeListener> listeners = new ArrayList<ValueChangeListener>();
	/** Loading success indicator       */
	protected boolean	        p_loadedOK = false;
	/**	SO Zoom Window						*/
	private int					m_SO_Window_ID = -1;
	/**	PO Zoom Window						*/
	private int					m_PO_Window_ID = -1;
	
	private MInfoWindow infoWindow;

	/**	Logger			*/
	protected CLogger log = CLogger.getCLogger(getClass());

	protected WListbox contentPanel = new WListbox();
	protected Paging paging;
	protected int pageNo;
	protected int m_count;
	private int cacheStart;
	private int cacheEnd;
	private boolean m_useDatabasePaging = false;
	private BusyDialog progressWindow;
	private Listitem m_lastOnSelectItem;
	/**
	 * false, use saved where clause
	 * IDEMPIERE-1979
	 */
	protected boolean isQueryByUser = false;
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
	protected Map<Integer, List<String>> m_viewIDMap = new HashMap<Integer, List<String>>();
	/**
	 * flag indicate have infoOProcess define ViewID 
	 */
	protected boolean isHasViewID = false;
	/**
	 * number of infoProcess contain ViewID
	 */
	protected int numOfViewID = 0;
	
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

	protected void prepareTable (ColumnInfo[] layout,
            String from,
            String where,
            String orderBy)
	{
        String sql =contentPanel.prepareTable(layout, from,
                where,p_multipleSelection,
                getTableName(),false);
        p_layout = contentPanel.getLayout();
		m_sqlMain = sql;
		m_sqlCount = "SELECT COUNT(*) FROM " + from + " WHERE " + where;
		//
		m_sqlOrder = "";
//		m_sqlUserOrder = "";
		if (orderBy != null && orderBy.trim().length() > 0)
			m_sqlOrder = " ORDER BY " + orderBy;
	}   //  prepareTable

	/**************************************************************************
	 *  Execute Query
	 */
	protected void executeQuery()
	{
		line = new ArrayList<Object>();
		setCacheStart(-1);
		cacheEnd = -1;

		testCount();
		if (m_count > 0)
		{
			m_useDatabasePaging = (m_count > 1000);
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
		        value = new Boolean("Y".equals(rs.getString(colIndex)));
			else if (c == Timestamp.class)
		        value = rs.getTimestamp(colIndex);
			else if (c == BigDecimal.class)
		        value = rs.getBigDecimal(colIndex);
			else if (c == Double.class)
		        value = new Double(rs.getDouble(colIndex));
			else if (c == Integer.class)
		        value = new Integer(rs.getInt(colIndex));
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
			}
			data.add(value);
		}
        line.add(data);
        
        readViewID(rs, data);
	}
	
	/**
	 * save all viewID to end of data line
	 * when override readData(ResultSet rs), consider call this method 
	 * IDEMPIERE-1970
	 */
	protected void readViewID(ResultSet rs, List<Object> data) throws SQLException {
		if (infoProcessList == null || infoProcessList.length == 0) {
			return;
		}

		// with each process have viewID, read it form resultSet by name
		for (MInfoProcess infoProcess : infoProcessList){
			if (infoProcess.getAD_InfoColumn_ID() <= 0)
				continue;

			MInfoColumn infocol = (MInfoColumn) infoProcess.getAD_InfoColumn();
			String viewIDValue = rs.getString(infocol.getColumnName());
			if (rs.wasNull()) {
				data.add(null);
			} else {
				data.add(viewIDValue);
			}
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
	    			insertPagingComponent();
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
        }
        int no = m_count;
        setStatusLine(Integer.toString(no) + " " + Msg.getMsg(Env.getCtx(), "SearchRows_EnterQuery"), false);
        setStatusDB(Integer.toString(no));

        addDoubleClickListener();
    }

    private List<Object> readLine(int start, int end) {
    	//cacheStart & cacheEnd - 1 based index, start & end - 0 based index
    	if (getCacheStart() >= 1 && cacheEnd > getCacheStart())
    	{
    		if (m_useDatabasePaging)
    		{
    			if (start+1 >= getCacheStart() && end+1 <= cacheEnd)
    			{
    				return end == -1 ? line : line.subList(start-getCacheStart()+1, end-getCacheStart()+2);
    			}
    		}
    		else
    		{
    			if (end >= cacheEnd || end <= 0)
    			{
    				end = cacheEnd-1;
    			}
    			return line.subList(start, end+1);
    		}
    	}

    	setCacheStart(start + 1 - (pageSize * 4));
    	if (getCacheStart() <= 0)
    		setCacheStart(1);

    	if (end == -1)
    	{
    		cacheEnd = m_count;
    	}
    	else
    	{
	    	cacheEnd = end + 1 + (pageSize * 4);
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
        if (log.isLoggable(Level.FINER))
        	log.finer(dataSql);
		try
		{
			m_pstmt = DB.prepareStatement(dataSql, null);
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
				readData(m_rs);
				//check now of rows loaded, break if we hit the suppose end
				if (m_useDatabasePaging && rowPointer >= cacheEnd)
				{
					break;
				}
			}
		}

		catch (SQLException e)
		{
			log.log(Level.SEVERE, dataSql, e);
		}

		finally
		{
			DB.close(m_rs, m_pstmt);
		}

		if (end >= cacheEnd || end <= 0)
		{
			end = cacheEnd-1;
		}
		
		if (end == -1) 
		{
			return line;
		}
		else
		{
			int fromIndex = start-getCacheStart()+1;
			int toIndex = end-getCacheStart()+2;
			if (toIndex > line.size()) 
				toIndex = line.size();
			return line.subList(fromIndex, toIndex);
		}
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
        if (m_sqlUserOrder != null && m_sqlUserOrder.trim().length() > 0)
        	sql.append(m_sqlUserOrder);
        else
        	sql.append(m_sqlOrder);
        dataSql = Msg.parseTranslation(Env.getCtx(), sql.toString());    //  Variables
        dataSql = MRole.getDefault().addAccessSQL(dataSql, getTableName(),
            MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
        if (end > start && m_useDatabasePaging && DB.getDatabase().isPagingSupported())
        {
        	dataSql = DB.getDatabase().addPagingSQL(dataSql, getCacheStart(), cacheEnd);
        }
		return dataSql;
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
			setParameters (pstmt, true);
			rs = pstmt.executeQuery();

			if (rs.next())
				m_count = rs.getInt(1);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, countSql, e);
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
     *  @return IDs if selection present
     *  @author ashley
     */
    protected ArrayList<Integer> getSelectedRowKeys()
    {
        ArrayList<Integer> selectedDataList = new ArrayList<Integer>();

        if (contentPanel.getKeyColumnIndex() == -1)
        {
            return selectedDataList;
        }

        if (p_multipleSelection)
        {
        	int[] rows = contentPanel.getSelectedIndices();
            for (int row = 0; row < rows.length; row++)
            {
                Object data = contentPanel.getModel().getValueAt(rows[row], contentPanel.getKeyColumnIndex());
                if (data instanceof IDColumn)
                {
                    IDColumn dataColumn = (IDColumn)data;
                    selectedDataList.add(dataColumn.getRecord_ID());
                }
                else
                {
                    log.severe("For multiple selection, IDColumn should be key column for selection");
                }
            }
        }

        if (selectedDataList.size() == 0)
        {
        	int row = contentPanel.getSelectedRow();
    		if (row != -1 && contentPanel.getKeyColumnIndex() != -1)
    		{
    			Object data = contentPanel.getModel().getValueAt(row, contentPanel.getKeyColumnIndex());
    			if (data instanceof IDColumn)
    				selectedDataList.add(((IDColumn)data).getRecord_ID());
    			if (data instanceof Integer)
    				selectedDataList.add((Integer)data);
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
	public Map<Integer, List<String>> getSaveKeys (){
		// clear result from prev time
		m_viewIDMap.clear();
		
		if (p_multipleSelection)
        {
        	int[] rows = contentPanel.getSelectedIndices();
        	
        	// this flag to just check key column in first record
        	boolean isCheckedKeyType = false;
        	
            for (int row = 0; row < rows.length; row++)
            {
            	// get key data column
                Object keyData = contentPanel.getModel().getValueAt(rows[row], contentPanel.getKeyColumnIndex());
                
                // check key data must is IDColumn
                if (!isCheckedKeyType){
                	if (keyData instanceof IDColumn){
                		isCheckedKeyType = true;
                	}else{
                		log.severe("For multiple selection, IDColumn should be key column for selection");
                		break;
                	}
                }
                
                IDColumn dataColumn = (IDColumn)keyData;

                if (isHasViewID){
                	// have viewID, get it
                	List<String> viewIDValueList = new ArrayList <String> ();
                	String viewIDValue = null;
                	for (int viewIDIndex = 0; viewIDIndex < numOfViewID; viewIDIndex++){
                		// get row data from model
                		@SuppressWarnings("unchecked")
						List<Object> selectedRowData = (List<Object>)contentPanel.getModel().get(rows[row]);
                		// view data store at end of data line
                		viewIDValue = (String)selectedRowData.get (contentPanel.getLayout().length + viewIDIndex);                		
            			viewIDValueList.add(viewIDValue);
                	}
                	
                	m_viewIDMap.put(dataColumn.getRecord_ID(), viewIDValueList);
                }else{
                	// hasn't viewID, set viewID value collection is null
                	m_viewIDMap.put(dataColumn.getRecord_ID(), null);
                }
                
            }
            
            return m_viewIDMap;
        }else{
        	// never has this case, because when have process, p_multipleSelection always is true
        	return null;
        }

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
		boolean enable = (contentPanel.getSelectedCount() > 0);
		enableButtons(enable);
	}
	
	// Elaine 2008/11/28
	/**
	 * enable or disable all control button
	 *  Enable OK, History, Zoom if row/s selected
     *  ---
     *  Changes: Changed the logic for accommodating multiple selection
     *  @author ashley
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
     * @param event event
    *
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
	 *  Save Selection Details
	 *	To be overwritten by concrete classes
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
		String sql = "SELECT AD_Window_ID, PO_Window_ID FROM AD_Table WHERE TableName=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, tableName);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				m_SO_Window_ID = rs.getInt(1);
				m_PO_Window_ID = rs.getInt(2);
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
            	m_lastOnSelectItem = null;
            	SelectEvent<?, ?> selectEvent = (SelectEvent<?, ?>) event;
            	if (selectEvent.getReference() != null && selectEvent.getReference() instanceof Listitem)
            		m_lastOnSelectItem = (Listitem) selectEvent.getReference();
        }else if (event.getTarget() == contentPanel && event.getName().equals("onAfterRender")){        	
        	//IDEMPIERE-1334 at this event selected item from listBox and model is sync
        	enableButtons();
            }
            else if (event.getTarget() == contentPanel && event.getName().equals(Events.ON_DOUBLE_CLICK))
            {
            	if (event.getClass().equals(MouseEvent.class)){
            		return;
            	}
            	if (contentPanel.isMultiple()) {
            		if (m_lastOnSelectItem != null)
            			contentPanel.setSelectedItem(m_lastOnSelectItem);
            	}
            	onDoubleClick();
            }
            else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_REFRESH)))
            {
            	onUserQuery();
            }
            else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_CANCEL)))
            {
            	m_cancel = true;
                dispose(false);
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
            	int pgNo = paging.getActivePage();
            	if (pageNo != pgNo)
            	{

            		contentPanel.clearSelection();

            		pageNo = pgNo;
            		int start = pageNo * pageSize;
            		int end = start + pageSize;
            		if (end >= m_count)
            			end = m_count - 1;
            		List<Object> subList = readLine(start, end);
        			model = new ListModelTable(subList);
        			model.setSorter(this);
    	            model.addTableModelListener(this);
    	            model.setMultiple(p_multipleSelection);
    	            contentPanel.setData(model, null);

    				//contentPanel.setSelectedIndex(0);
    			}
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
        	}else if (event.getName().equals(Events.ON_CANCEL)){
        		m_cancel = true;
        		dispose(false);
        	}
            //when user push enter keyboard at input parameter field
            else
            {
            	// onUserQuery(); // captured now on control key
            }
    }  //  onEvent

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
		// Execute Process
		m_pi.setAD_PInstance_ID(pInstanceID);		
		
		//HengSin - to let process end with message and requery
		WProcessCtl.process(p_WindowNo, m_pi, (Trx)null, new EventListener<Event>() {

			@Override
			public void onEvent(Event event) throws Exception {
				ProcessModalDialog processModalDialog = (ProcessModalDialog)event.getTarget();
				if (DialogEvents.ON_BEFORE_RUN_PROCESS.equals(event.getName())){
					// store in T_Selection table selected rows for Execute Process that retrieves from T_Selection in code.
					DB.createT_Selection(pInstanceID, getSaveKeys(), getProcessIndex(processModalDialog.getAD_Process_ID()), 
						null);					
				}else if (ProcessModalDialog.ON_WINDOW_CLOSE.equals(event.getName())){ 
					if (processModalDialog.isCancel()){
						//clear back 
						m_results.clear();
						// enable or disable control button rely selected record status 
						enableButtons();
					}else if (m_pi.isError()){
						// show error info
						FDialog.error(p_WindowNo, m_pi.getSummary());
						// enable or disable control button rely selected record status 
						enableButtons();
					}else if (!m_pi.isError() && m_pi.getSummary() != null && m_pi.getSummary().trim().length() > 0){
						// when success, show summary if exists
						FDialog.info(p_WindowNo, null, m_pi.getSummary());
						Clients.response(new AuEcho(InfoPanel.this, "onQueryCallback", m_results));
					}
					
				}
				
		//HengSin -- end --
			}
		});   		
    }
   
    /**
     * Get index of infoProcess have processId
     * @param processId
     * @return
     */
    protected int getProcessIndex (int processId){
    	int index = 0;
    	for (int i = 0; i < infoProcessList.length; i++){
    		if (infoProcessList[i].getAD_Process_ID() == processId){
    			return index;
    		}
    		// just increase index when process is have ViewID column
    		if (infoProcessList[i].getAD_InfoColumn_ID() > 0)
    			index++;
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

    public void onQueryCallback(Event event)
    {
    	try
    	{
    		Listhead listHead = contentPanel.getListHead();
    		if (listHead != null) {
    			List<?> headers = listHead.getChildren();
    			for(Object obj : headers)
    			{
    				Listheader header = (Listheader) obj;
    				header.setSortDirection("natural");
    			}
    		}
    		m_sqlUserOrder="";
        	executeQuery();
            renderItems();
        	// IDEMPIERE-1334 after refresh, restore prev selected item start 
        	if (event != null && event.getData() != null){
            	@SuppressWarnings("unchecked")
				List<Integer> lsSelectedKey = (List<Integer>)event.getData();
            	contentPanel.setSelectedByKeys(lsSelectedKey);            	            	
            	m_results.clear();            	
            }
        	// just evaluate display logic of process button when requery by use click requery button
        	if (isQueryByUser){
        		bindInfoProcess();
        	}
        	// IDEMPIERE-1334 after refresh, restore prev selected item end
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
		if (!contentPanel.getChildren().isEmpty() && contentPanel.getSelectedRowKey()!=null)
		{
		    dispose(true);
		}
	}

    private void onDoubleClick()
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

	public void sort(Comparator<Object> cmpr, boolean ascending) {
		WListItemRenderer.ColumnComparator lsc = (WListItemRenderer.ColumnComparator) cmpr;
		if (m_useDatabasePaging)
		{
			int col = lsc.getColumnIndex();
			String colsql = p_layout[col].getColSQL().trim();
			int lastSpaceIdx = colsql.lastIndexOf(" ");
			if (lastSpaceIdx > 0)
			{
				String tmp = colsql.substring(0, lastSpaceIdx).trim();
				char last = tmp.charAt(tmp.length() - 1);
				if (tmp.toLowerCase().endsWith("as"))
				{
					colsql = colsql.substring(lastSpaceIdx).trim();
				}
				else if (!(last == '*' || last == '-' || last == '+' || last == '/' || last == '>' || last == '<' || last == '='))
				{
					tmp = colsql.substring(lastSpaceIdx).trim();
					if (tmp.startsWith("\"") && tmp.endsWith("\""))
					{
						colsql = colsql.substring(lastSpaceIdx).trim();
					}
					else
					{
						boolean hasAlias = true;
						for(int i = 0; i < tmp.length(); i++)
						{
							char c = tmp.charAt(i);
							if (Character.isLetterOrDigit(c))
							{
								continue;
							}
							else
							{
								hasAlias = false;
								break;
							}
						}
						if (hasAlias)
						{
							colsql = colsql.substring(lastSpaceIdx).trim();
						}
					}
				}
			}
			m_sqlUserOrder = " ORDER BY " + colsql;
			if (!ascending)
				m_sqlUserOrder += " DESC ";
			executeQuery();
			renderItems();
		}
		else
		{
			Collections.sort(line, lsc);
			renderItems();
		}
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
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
		} catch (Exception e){}
	}

}	//	Info

